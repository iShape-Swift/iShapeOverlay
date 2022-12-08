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
    }
    
    struct Composition {

        private var setA: ContactSet
        private var setB: ContactSet

        private (set) var dots = Set<Dot>()
        
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
                let iA1 = (iA + 1) % nA
                let iA0 = (iA - 1 + nA) % nA

                let iB = dot.mB.index
                let iB1 = (iB + 1) % nB
                let iB0 = (iB - 1 + nB) % nB

                let a0_b0 = self.isOverlap(
                    sA: .init(eIndex: iA0, vIndex: iA0),
                    sB: .init(eIndex: iB0, vIndex: iB0)
                )
                let a0_b1 = self.isOverlap(
                    sA: .init(eIndex: iA0, vIndex: iA0),
                    sB: .init(eIndex: iB, vIndex: iB1)
                )
                let a1_b0 = self.isOverlap(
                    sA: .init(eIndex: iA, vIndex: iA1),
                    sB: .init(eIndex: iB0, vIndex: iB0)
                )
                let a1_b1 = self.isOverlap(
                    sA: .init(eIndex: iA, vIndex: iA1),
                    sB: .init(eIndex: iB, vIndex: iB1)
                )
                
                let b0_a = a0_b0 || a1_b0
                let b1_a = a0_b1 || a1_b1
                
                if b1_a && b0_a {
                    continue
                }
                
                let a0 = pathA[iA0]
                let a1 = pathA[iA1]

                let b0 = pathB[iB0]
                let b1 = pathB[iB1]
                
                if b0_a {
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
                        if a1_b1 {
                            type = .start_out_same
                        } else {
                            type = .start_out_back
                        }
                    } else {
                        if a1_b1 {
                            type = .start_in_same
                        } else {
                            type = .start_in_back
                        }
                    }
                } else {
                    let r0: CornerLocation
                    let r1: CornerLocation
                    
                    let corner = Corner(o: dot.p, a: a0, b: a1)
                    r0 = corner.test(p: b0, clockWise: false)
                    r1 = corner.test(p: b1, clockWise: false)

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

                result.append(PinPoint(p: dot.p, type: type, a: dot.mA.index, b: dot.mB.index))
            }
            
            return result
        }

        private func isOverlap(sA: Segment, sB: Segment) -> Bool {
            if setA.isContain(edge: sA.eIndex, vertex: sB.vIndex) {
                return true
            }
            if setB.isContain(edge: sB.eIndex, vertex: sA.vIndex) {
                return true
            }
            
            return false
        }
    }
}

private extension Rect {
    init(edge: Collision.Edge) {
        self.init(a: edge.start, b: edge.end)
    }
}
