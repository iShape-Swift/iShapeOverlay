//
//  Corner.swift
//  
//
//  Created by Nail Sharipov on 30.11.2022.
//

import iGeometry

extension Collision {

    enum CornerLocation {
        case inCenter
        case onA
        case onB
        case inside
        case outside
    }

    
    struct Corner {
        
        private let o: IntPoint
        private let ao: IntPoint
        private let bo: IntPoint
        
        private let dir: Int
        
        @inlinable
        init(o: IntPoint, a: IntPoint, b: IntPoint) {
            self.o = o
            ao = a - o
            bo = b - o
            
            dir = ao.crossProduct(bo).sign
        }

        @inlinable
        func test(p: IntPoint, clockWise: Bool) -> CornerLocation {
            let po = p - o
            
            let ap = ao.crossProduct(po).sign
            if ap == 0 {
                if p == o {
                    return .inCenter
                }
                
                let dotProd = po.dotProduct(ao)
                if dotProd > 0 {
                    return .onA
                }
            }
            
            let bp = bo.crossProduct(po).sign
            if bp == 0 {
                let dotProd = po.dotProduct(bo)
                if dotProd > 0 {
                    return .onB
                }
            }
            
            guard dir != 0 else {
                let d = clockWise ? -1 : 1
                let isContain = ap == d && bp != d
                if isContain {
                    return .inside
                } else {
                    return .outside
                }
            }
            
            let isSmall = ap == dir && bp != dir
            let isSmallCW = dir == -1
            if isSmallCW == clockWise {
                if isSmall {
                    return .inside
                } else {
                    return .outside
                }
            } else {
                if !isSmall {
                    return .inside
                } else {
                    return .outside
                }
            }
        }

    }
}

private extension Int64 {
        
    var sign: Int {
        if self == 0 {
            return 0
        } else if self > 0 {
            return 1
        } else {
            return -1
        }
    }
}
