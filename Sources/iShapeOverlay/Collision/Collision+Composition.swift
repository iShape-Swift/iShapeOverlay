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
                
                switch dot.t {
                case .simple:
                    let a = pathA[dot.mA.index]
                    let b = pathB[dot.mB.index]
                    
                    let isCCW = self.isCCW(a, dot.p, b)
                    type = isCCW ? .out : .into
                case .complex:
                    let iA = dot.mA.index
                    let forward_A = (iA + 1) % nA
                    let back_A = (iA - 1 + nA) % nA

                    let iB = dot.mB.index
                    let forward_B = (iB + 1) % nB
                    let back_B = (iB - 1 + nB) % nB
                    
                    let eA0: Int
                    let eA1 = iA
                    
                    let iA0: Int
                    let iA1 = forward_A
                    
                    let eB0: Int
                    let eB1 = iB
                    
                    let iB0: Int
                    let iB1 = forward_B
                    
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
 
                    let corner = Corner(o: dot.p, a: a0, b: a1)
                    
                    let b0_a = a0_b0 || a1_b0
                    let b1_a = a0_b1 || a1_b1
                    
                    if b1_a && b0_a {
                        continue
                    } else if b0_a {
                        let r1 = corner.isBetween(p: b1, clockwise: false)
                        let x1 = r1 == .contain
                        
                        if x1 {
                            type = .end_in
                        } else {
                            type = .end_out
                        }
                    } else if b1_a {
                        let r0 = corner.isBetween(p: b0, clockwise: false)
                        let x0 = r0 == .contain
                        
                        if x0 {
                            type = .start_out
                        } else {
                            type = .start_in
                        }
                    } else {
                        let r0 = corner.isBetween(p: b0, clockwise: false)
                        let r1 = corner.isBetween(p: b1, clockwise: false)
                        
                        let x0 = r0 == .contain
                        let x1 = r1 == .contain
                        
                        if x0 && x1 {
                            type = .false_out
                        } else if x0 {
                            type = .out
                        } else if x1 {
                            type = .into
                        } else {
                            type = .false_in
                        }
                    }
                }
                
                let pin = PinPoint(p: dot.p, type: type, mA: dot.mA, mB: dot.mB)
                result.append(pin)
            }
            
            return result
        }
        
        private func isCCW(_ p0: IntPoint, _ p1: IntPoint, _ p2: IntPoint) -> Bool {
            let m0 = (p2.y - p0.y) * (p1.x - p0.x)
            let m1 = (p1.y - p0.y) * (p2.x - p0.x)

            return m0 < m1
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
    }
}

private extension Rect {
    init(edge: Collision.Edge) {
        self.init(a: edge.start, b: edge.end)
    }
}
