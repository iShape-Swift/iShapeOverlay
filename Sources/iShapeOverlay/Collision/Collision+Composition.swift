//
//  Collision+Composition.swift
//  
//
//  Created by Nail Sharipov on 25.11.2022.
//

import iGeometry

extension Collision {

    struct Contact: Equatable {
        let edge: Int
        let vertex: Int
    }
    
    struct Composition {

        private var list_A: [Contact] = []
        private var list_B: [Contact] = []

        private var dots: [Dot] = []
        
        func isContain(edgeA: Int, vertexB: Int) -> Bool {
            false
        }
        
        mutating func addPure(edge0: Edge, edge1: Edge, point: IntPoint) {
            dots.append(Dot(ed0: edge0, ed1: edge1, type: .simple, point: point))
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
                
                list_B.add(
                    Contact(
                        edge: eB.p0.index,
                        vertex: eA.p0.index
                    )
                )
                if b1 {
                    list_B.add(
                        Contact(
                            edge: eB.p1.index,
                            vertex: eA.p0.index
                        )
                    )
                }
            } else if a1 {
                mA = MileStone(index: eA.p1.index)
                
                list_B.add(
                    Contact(
                        edge: eB.p0.index,
                        vertex: eA.p1.index
                    )
                )
            } else {
                mA = MileStone(index: eA.p0.index, offset: point.sqrDistance(point: eA.p0.point))
            }
            
            if b0 {
                mB = MileStone(index: eB.p0.index)
                
                list_A.add(
                    Contact(
                        edge: eA.p0.index,
                        vertex: eB.p0.index
                    )
                )
                if a1 {
                    list_A.add(
                        Contact(
                            edge: eA.p1.index,
                            vertex: eB.p0.index
                        )
                    )
                }
            } else if b1 {
                mB = MileStone(index: eB.p1.index)
                
                list_A.add(
                    Contact(
                        edge: eA.p0.index,
                        vertex: eB.p1.index
                    )
                )
            } else {
                mB = MileStone(index: eB.p0.index, offset: point.sqrDistance(point: eB.p0.point))
            }
            
            dots.append(Dot(mA: mA, mB: mB, type: .complex, point: point))
        }

        mutating func addSameLine(edge0: Edge, edge1: Edge) {
            let edgeA: Edge
            let edgeB: Edge
    
            if edge0.shapeId == 0 {
                edgeA = edge0
                edgeB = edge1
            } else {
                edgeA = edge1
                edgeB = edge0
            }
            
            let rectA = Rect(edge: edgeA)
            
            if rectA.isContain(edgeB.p0.point) {
                list_A.add(
                    Contact(
                        edge: edgeA.p0.index,
                        vertex: edgeB.p0.index
                    )
                )
            }
            if rectA.isContain(edgeB.p1.point) {
                list_A.add(
                    Contact(
                        edge: edgeA.p0.index,
                        vertex: edgeB.p1.index
                    )
                )
            }
            
            let rectB = Rect(edge: edgeB)

            if rectB.isContain(edgeA.p0.point) {
                list_B.add(
                    Contact(
                        edge: edgeB.p0.index,
                        vertex: edgeA.p0.index
                    )
                )
            }
            if rectB.isContain(edgeA.p1.point) {
                list_B.add(
                    Contact(
                        edge: edgeB.p0.index,
                        vertex: edgeA.p1.index
                    )
                )
            }
        }
        
        func pins(pathA: [IntPoint], pathB: [IntPoint]) -> [PinPoint] {
            
            let setA = ContactSet(module: pathA.count, contacts: list_A)
            let setB = ContactSet(module: pathB.count, contacts: list_B)
           
            let an = pathA.count
            let bn = pathB.count
            
            var result = [PinPoint]()

            for dot in dots {
                
                let type: PinType
                
                switch dot.t {
                case .simple:
                    let a = pathA[dot.mA.index]
                    let b = pathA[dot.mB.index]
                    
                    let isCCW = self.isCCW(a, dot.p, b)
                    type = isCCW ? .out : .into
                case .complex:
                    let i0: Int
                    let i1 = (dot.mA.index + 1) % an
                    let j0: Int
                    let j1 = (dot.mB.index + 1) % bn
                    
                    if dot.mA.offset == 0 {
                        i0 = (dot.mA.index + an - 1) % an
                    } else {
                        i0 = dot.mA.index
                    }
                    
                    if dot.mB.offset == 0 {
                        j0 = (dot.mB.index + bn - 1) % bn
                    } else {
                        j0 = dot.mB.index
                    }
                    
                    let a0 = IndexPoint(index: i0, point: pathA[i0])
                    let a1 = IndexPoint(index: i1, point: pathA[i1])

                    let b0 = IndexPoint(index: j0, point: pathB[j0])
                    let b1 = IndexPoint(index: j1, point: pathB[j1])

                    let a0_b0 = setA.isContain(edge: a0.index, vertex: b0.index) || setB.isContain(edge: b0.index, vertex: a0.index)
                    
                    let a1_b1 = setA.isContain(edge: a1.index, vertex: b1.index) || setB.isContain(edge: b1.index, vertex: a1.index)

                    guard !(a0_b0 && a1_b1) else {
                        assertionFailure("impossible case")
                        return []
                    }
                    
                    let corner = Corner(o: dot.p, a: a0.point, b: a1.point)
                    
                    if a0_b0 {
                        let r1 = corner.isBetween(p: b1.point, clockwise: false)
                        assert(r1 != .onBoarder)
                        let x1 = r1 == .contain
                        
                        if x1 {
                            type = .end_in
                        } else {
                            type = .end_out
                        }
                    } else if a1_b1 {
                        let r0 = corner.isBetween(p: b0.point, clockwise: false)
                        assert(r0 != .onBoarder)
                        let x0 = r0 == .contain
                        
                        if x0 {
                            type = .start_out
                        } else {
                            type = .start_in
                        }
                    } else {
                        let r0 = corner.isBetween(p: b0.point, clockwise: false)
                        let r1 = corner.isBetween(p: b1.point, clockwise: false)
                        
                        assert(r0 != .onBoarder)
                        assert(r1 != .onBoarder)
                        
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

    }
}

private extension Rect {
    init(edge: Collision.Edge) {
        self.init(a: edge.start, b: edge.end)
    }
}

private extension Array where Element == Collision.Contact {
    
    mutating func add(_ contact: Collision.Contact) {
        if isEmpty || last != contact {
            self.append(contact)
        }
    }
    
}
