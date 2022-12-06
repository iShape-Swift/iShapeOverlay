//
//  Collision+Composition.swift
//  
//
//  Created by Nail Sharipov on 25.11.2022.
//

import iGeometry

extension Collision {

    private struct Segment {
        let eIndex: Int
        let vIndex: Int
        let end: IntPoint
    }
    
    struct Composition {

        private var setA: ContactSet
        private var setB: ContactSet

        private var dots = Set<Dot>()
        
        init(countA: Int, countB: Int) {
            setA = ContactSet(module: countA)
            setB = ContactSet(module: countB)
        }
        
        mutating func addPure(edge0: Edge, edge1: Edge, point: IntPoint) {
            dots.insert(Dot(ed0: edge0, ed1: edge1, type: .simple, point: point))
        }
        
        mutating func addCommon(edge0: Edge, edge1: Edge, point: IntPoint) {
            let eA: Edge
            let eB: Edge
    
            if edge0.shapeId == 0 {
                eA = edge0
                eB = edge1
            } else {
                eA = edge1
                eB = edge0
            }
  
            let mA: MileStone
            let mB: MileStone
            
            let a0 = eA.p0.point == point
            let a1 = eA.p1.point == point
            let b0 = eB.p0.point == point
            let b1 = eB.p1.point == point
            
            guard a0 || a1 || b0 || b1 else {
                return
            }

            if a0 {
                mA = MileStone(index: eA.p0.index)
                setB.put(edge: eB.p0.index, vertex: eA.p0.index)
                if b1 {
                    setB.put(edge: eB.p1.index, vertex: eA.p0.index)
                }
            } else if a1 {
                mA = MileStone(index: eA.p1.index)
                setB.put(edge: eB.p0.index, vertex: eA.p1.index)
            } else {
                mA = MileStone(index: eA.p0.index, offset: point.sqrDistance(point: eA.p0.point))
            }
            
            if b0 {
                mB = MileStone(index: eB.p0.index)
                setA.put(edge: eA.p0.index, vertex: eB.p0.index)
                if a1 {
                    setA.put(edge: eA.p1.index, vertex: eB.p0.index)
                }
            } else if b1 {
                mB = MileStone(index: eB.p1.index)
                setA.put(edge: eA.p0.index, vertex: eB.p1.index)
            } else {
                mB = MileStone(index: eB.p0.index, offset: point.sqrDistance(point: eB.p0.point))
            }
            
            dots.insert(Dot(mA: mA, mB: mB, type: .complex, point: point))
        }

        mutating func addSameLine(edge0: Edge, edge1: Edge) {
            let eA: Edge
            let eB: Edge
    
            if edge0.shapeId == 0 {
                eA = edge0
                eB = edge1
            } else {
                eA = edge1
                eB = edge0
            }
            
            let rectA = Rect(edge: eA)
            
            if rectA.isContain(eB.p0.point) {
                setA.put(edge: eA.p0.index, vertex: eB.p0.index)
            }
            if rectA.isContain(eB.p1.point) {
                setA.put(edge: eA.p0.index, vertex: eB.p1.index)
            }
            
            let rectB = Rect(edge: eB)

            if rectB.isContain(eA.p0.point) {
                setB.put(edge: eB.p0.index, vertex: eA.p0.index)
            }
            if rectB.isContain(eA.p1.point) {
                setB.put(edge: eB.p0.index, vertex: eA.p1.index)
            }
        }
        
        func pins(pathA: [IntPoint], pathB: [IntPoint]) -> [PinPoint] {

            let nA = pathA.count
            let nB = pathB.count
            
            var result = [PinPoint]()

            for dot in dots {
                
                let type: PinType
                
                let iA = dot.mA.index
                
                let forward_A = (iA + 1) % nA
                let back_A = (iA - 1 + nA) % nA

                let iA1 = forward_A
                let a1 = pathA[iA1]
                
                let iB = dot.mB.index
                let forward_B = (iB + 1) % nB
                let back_B = (iB - 1 + nB) % nB
                
                let iB1 = forward_B
                let b1 = pathB[iB1]
                
                switch dot.t {
                case .simple:
                    let a0 = pathA[iA]
                    let b0 = pathB[iB]
                    
                    let aa = a1 - a0
                    let bb = b1 - b0
                    
                    let crossProduct = aa.crossProduct(bb)
                    
                    type = crossProduct > 0 ? .out : .into
                case .complex:
                    let eA0: Int
                    let eA1 = iA
                    
                    let iA0: Int
                    
                    let eB0: Int
                    let eB1 = iB
                    
                    let iB0: Int
                    
                    if dot.mA.offset == 0 {
                        eA0 = back_A
                        iA0 = back_A
                    } else {
                        eA0 = iA
                        iA0 = iA
                    }

                    if dot.mB.offset == 0 {
                        eB0 = back_B
                        iB0 = back_B
                    } else {
                        eB0 = iB
                        iB0 = iB
                    }

                    let a0 = pathA[iA0]
                    let a1 = pathA[iA1]

                    let b0 = pathB[iB0]
                    let b1 = pathB[iB1]

                    let a0_b0 = self.isOverlap(
                        sA: .init(eIndex: eA0, vIndex: iA0, end: a0),
                        sB: .init(eIndex: eB0, vIndex: iB0, end: b0),
                        start: dot.p
                    )
                    let a0_b1 = self.isOverlap(
                        sA: .init(eIndex: eA0, vIndex: iA0, end: a0),
                        sB: .init(eIndex: eB1, vIndex: iB1, end: b1),
                        start: dot.p
                    )
                    let a1_b0 = self.isOverlap(
                        sA: .init(eIndex: eA1, vIndex: iA1, end: a1),
                        sB: .init(eIndex: eB0, vIndex: iB0, end: b0),
                        start: dot.p
                    )
                    let a1_b1 = self.isOverlap(
                        sA: .init(eIndex: eA1, vIndex: iA1, end: a1),
                        sB: .init(eIndex: eB1, vIndex: iB1, end: b1),
                        start: dot.p
                    )
                    
                    let b0_a = a0_b0 || a1_b0
                    let b1_a = a0_b1 || a1_b1
                    
                    if b1_a && b0_a {
                        continue
                    } else if b0_a {
                        let corner = Corner(o: dot.p, a: a0, b: a1)
                        
                        let r1 = corner.test(p: b1, clockWise: false)
                        let x1 = r1 != .outside
                        
                        if x1 {
                            type = .end_in
                        } else {
                            type = .end_out
                        }
                    } else if b1_a {
                        let corner = Corner(o: dot.p, a: a0, b: a1)
                        
                        let r0 = corner.test(p: b0, clockWise: false)
                        let x0 = r0 != .outside
                        
                        if x0 {
                            type = .start_out
                        } else {
                            type = .start_in
                        }
                    } else {
                        let r0: CornerLocation
                        let r1: CornerLocation
                        
                        if (dot.mA.offset == 0 || dot.mB.offset == 0) && dot.mA.offset != dot.mB.offset {
                            let dP = DBPoint(iPoint: dot.p)
                            let dA0: DBPoint
                            let dA1: DBPoint
                            let dB0: DBPoint
                            let dB1: DBPoint

                            if dot.mA.offset == 0 {
                                // b0 - b1 is line

                                dA0 = DBPoint(iPoint: a0)
                                dA1 = DBPoint(iPoint: a1)

                                let db = testPoint(a0: a0, a1: a1, e: dot.p, b0: b0, b1: b1)

                                dB0 = db.p0
                                dB1 = db.p1
                            } else {
                                // a0 - a1 is line

                                dB0 = DBPoint(iPoint: b0)
                                dB1 = DBPoint(iPoint: b1)

                                let db = testPoint(a0: b0, a1: b1, e: dot.p, b0: a0, b1: a1)

                                dA0 = db.p0
                                dA1 = db.p1
                            }

                            let dbCorner = DBCorner(o: dP, a: dA0, b: dA1)
                            r0 = dbCorner.test(p: dB0, clockWise: false)
                            r1 = dbCorner.test(p: dB1, clockWise: false)
                        } else {
                            let corner = Corner(o: dot.p, a: a0, b: a1)
                            r0 = corner.test(p: b0, clockWise: false)
                            r1 = corner.test(p: b1, clockWise: false)
                        }

                        let x0 = r0 != .outside
                        let x1 = r1 != .outside
                        
                        if x0 && x1 {
                            let subCorner = Corner(o: dot.p, a: a0, b: b1)
                            let isB0 = subCorner.test(p: b0, clockWise: false)
                            if isB0 != .outside {
                                type = .false_out_same
                            } else {
                                type = .false_out_back
                            }
                            
                        } else if x0 {
                            type = .out
                        } else if x1 {
                            type = .into
                        } else {
                            let subCorner = Corner(o: dot.p, a: a0, b: b1)
                            let isA1 = subCorner.test(p: a1, clockWise: false)
                            if isA1 != .outside {
                                type = .false_in_same
                            } else {
                                type = .false_in_back
                            }
                        }
                    }
                }

                result.append(PinPoint(p: dot.p, type: type, mA: dot.mA, mB: dot.mB))
            }
            
            return result
        }

        private func isOverlap(sA: Segment, sB: Segment, start: IntPoint) -> Bool {
            if setA.isContain(edge: sA.eIndex, vertex: sB.vIndex) {
                let rect = Rect(a: start, b: sA.end)
                if rect.isContain(sB.end) {
                    return true
                }
            }
            if setB.isContain(edge: sB.eIndex, vertex: sA.vIndex) {
                let rect = Rect(a: start, b: sB.end)
                if rect.isContain(sA.end) {
                    return true
                }
            }
            
            return false
        }
        
        private struct TwoPoint {
            let p0: DBPoint
            let p1: DBPoint
        }
        
        // b0 - b1 is line
        private func testPoint(a0: IntPoint, a1: IntPoint, e: IntPoint, b0: IntPoint, b1: IntPoint) -> TwoPoint {
            let bb = b1 - b0
            let a0e = a0 - e
            let a1e = a1 - e
            
            let dotA0 = bb.dotProduct(a0e)
            let dotA1 = bb.dotProduct(a1e)
            
            let da0: DBPoint
            let da1: DBPoint
            
            if dotA0 > 0 {
                let db = b1.sqrDistance(point: e)
                let da = a0.sqrDistance(point: e)
                if db < da {
                    da0 = DBPoint(iPoint: b0)
                } else {
                    da0 = Line.normalBase(a: b0, b: b1, p: a0)
                }
            } else {
                let db = b0.sqrDistance(point: e)
                let da = a0.sqrDistance(point: e)
                if db < da {
                    da0 = DBPoint(iPoint: b0)
                } else {
                    da0 = Line.normalBase(a: b0, b: b1, p: a0)
                }
            }

            if dotA1 > 0 {
                let db = b1.sqrDistance(point: e)
                let da = a1.sqrDistance(point: e)
                if db < da {
                    da1 = DBPoint(iPoint: b1)
                } else {
                    da1 = Line.normalBase(a: b0, b: b1, p: a1)
                }
            } else {
                let db = b0.sqrDistance(point: e)
                let da = a1.sqrDistance(point: e)
                if db < da {
                    da1 = DBPoint(iPoint: b1)
                } else {
                    da1 = Line.normalBase(a: b0, b: b1, p: a1)
                }
            }
            
            return .init(p0: da0, p1: da1)
        }

    }
}

private extension Rect {
    init(edge: Collision.Edge) {
        self.init(a: edge.start, b: edge.end)
    }
}
