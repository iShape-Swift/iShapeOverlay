//
//  CrossDetector+Edge.swift
//  
//
//  Created by Nail Sharipov on 23.11.2022.
//

import iGeometry

extension Collision {
    
    struct CrossResult {
        let type: CrossType
        let point: IntPoint
    }
    
    enum CrossType {
        case not_cross          // no intersections
        case pure               // simple intersection with no overlaps or common points
        case same_line          // same line
        
        case end_a0
        case end_a1
        case end_b0
        case end_b1
        case end_a0_b0
        case end_a0_b1
        case end_a1_b0
        case end_a1_b1
    }
    
    struct Edge {
        
        static let empty = Edge(shapeId: -1, start: .zero, end: .zero, p0: .zero, p1: .zero)
        
        let shapeId: Int
        let start: IntPoint
        let end: IntPoint
        let p0: IndexPoint
        let p1: IndexPoint

        init(shapeId: Int, start: IntPoint, end: IntPoint, p0: IndexPoint, p1: IndexPoint) {
            self.shapeId = shapeId
            self.start = start
            self.end = end
            self.p0 = p0
            self.p1 = p1
        }
        
        init(parent: Edge, start: IntPoint, end: IntPoint) {
            self.shapeId = parent.shapeId
            self.start = start
            self.end = end
            self.p0 = parent.p0
            self.p1 = parent.p1
        }
        
        init(parent: Edge, a: IntPoint, b: IntPoint) {
            if a.bitPack < b.bitPack {
                self.start = a
                self.end = b
            } else {
                self.start = b
                self.end = a
            }
            self.shapeId = parent.shapeId
            self.p0 = parent.p0
            self.p1 = parent.p1
        }
        
        
        @inlinable
        func cross(other: Collision.Edge) -> CrossResult {
            let a0 = self.start
            let a1 = self.end
            
            let b0 = other.start
            let b1 = other.end
            
            let d0 = self.isCCW(a: a0, b: b0, c: b1)
            let d1 = self.isCCW(a: a1, b: b0, c: b1)
            let d2 = self.isCCW(a: a0, b: a1, c: b0)
            let d3 = self.isCCW(a: a0, b: a1, c: b1)
            
            if d0 == 0 || d1 == 0 || d2 == 0 || d3 == 0 {
                if d0 == 0 && d1 == 0 && d2 == 0 && d3 == 0 {
                    return .init(type: .same_line, point: .zero)
                }
                if d0 == 0 {
                    if d2 == 0 || d3 == 0 {
                        if d2 == 0 {
                            return .init(type: .end_a0_b0, point: a0)
                        } else {
                            return .init(type: .end_a0_b1, point: a0)
                        }
                    } else if d2 != d3 {
                        return .init(type: .end_a0, point: a0)
                    } else {
                        return .init(type: .not_cross, point: .zero)
                    }
                }
                if d1 == 0 {
                    if d2 == 0 || d3 == 0 {
                        if d2 == 0 {
                            return .init(type: .end_a1_b0, point: a1)
                        } else {
                            return .init(type: .end_a1_b1, point: a1)
                        }
                    } else if d2 != d3 {
                        return .init(type: .end_a1, point: a1)
                    } else {
                        return .init(type: .not_cross, point: .zero)
                    }
                }
                if d0 != d1 {
                    if d2 == 0 {
                        return .init(type: .end_b0, point: b0)
                    } else {
                        return .init(type: .end_b1, point: b1)
                    }
                } else {
                    return .init(type: .not_cross, point: .zero)
                }
            } else if d0 != d1 && d2 != d3 {
                let cross = self.crossPoint(a0: a0, a1: a1, b0: b0, b1: b1)
                
                // still can be ends (watch case union 44)
                let isA0 = a0 == cross
                let isA1 = a1 == cross
                let isB0 = b0 == cross
                let isB1 = b1 == cross
                
                let type: CrossType
                
                if !(isA0 || isA1 || isB0 || isB1) {
                    type = .pure
                } else if isA0 && isB0 {
                    type = .end_a0_b0
                } else if isA0 && isB1 {
                    type = .end_a0_b1
                } else if isA1 && isB0 {
                    type = .end_a1_b0
                } else if isA1 && isB1 {
                    type = .end_a1_b1
                } else if isA0 {
                    type = .end_a0
                } else if isA1 {
                    type = .end_a1
                } else if isB0 {
                    type = .end_b0
                } else {
                    type = .end_b1
                }
                
                return .init(type: type, point: cross)
            } else {
                return .init(type: .not_cross, point: .zero)
            }
        }
        
        @inlinable
        func isCross(other: Collision.Edge) -> Bool {
            let a0 = self.start
            let a1 = self.end
            
            let b0 = other.start
            let b1 = other.end
            
            let d0 = self.isCCW(a: a0, b: b0, c: b1)
            let d1 = self.isCCW(a: a1, b: b0, c: b1)
            let d2 = self.isCCW(a: a0, b: a1, c: b0)
            let d3 = self.isCCW(a: a0, b: a1, c: b1)
            
            if d0 == 0 || d1 == 0 || d2 == 0 || d3 == 0 {
                if d0 == 0 && d1 == 0 && d2 == 0 && d3 == 0 {
                    return true
                }
                
                if d0 == 0 || d1 == 0 {
                    if d2 == 0 || d3 == 0 || d2 != d3 {
                        return true
                    } else {
                        return false
                    }
                }
                
                if d0 != d1 {
                    return true
                } else {
                    return false
                }
            } else if d0 != d1 && d2 != d3 {
                return true
            } else {
                return false
            }
        }
        
        private func isCCW(a: IntPoint, b: IntPoint, c: IntPoint) -> Int {
            let m0 = (c.y - a.y) * (b.x - a.x)
            let m1 = (b.y - a.y) * (c.x - a.x)
            
            if m0 < m1 {
                return -1
            }
            
            if m0 > m1 {
                return 1
            }
            
            return 0
        }
        
        private func crossPoint(a0: IntPoint, a1: IntPoint, b0: IntPoint, b1: IntPoint) -> IntPoint {
            let dxA = a0.x - a1.x
            let dyB = b0.y - b1.y
            let dyA = a0.y - a1.y
            let dxB = b0.x - b1.x
            
            let divider = dxA * dyB - dyA * dxB
            
            let xyA = Double(a0.x * a1.y - a0.y * a1.x)
            let xyB = Double(b0.x * b1.y - b0.y * b1.x)
            
            let invert_divider: Double = 1.0 / Double(divider)
            
            let x = xyA * Double(b0.x - b1.x) - Double(a0.x - a1.x) * xyB
            let y = xyA * Double(b0.y - b1.y) - Double(a0.y - a1.y) * xyB
            
            let cx = x * invert_divider
            let cy = y * invert_divider
            
            let rx = Int64(cx.rounded(.toNearestOrAwayFromZero))
            let ry = Int64(cy.rounded(.toNearestOrAwayFromZero))

            return IntPoint(x: rx, y: ry)
        }
    }
}
