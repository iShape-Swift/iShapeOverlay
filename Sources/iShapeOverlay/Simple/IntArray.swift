//
//  IntArray.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Array where Element == IntPoint {
    
    @inlinable
    mutating func directAppend(a: Int, b: Int, points: [IntPoint]) {
        let n = points.count

        let b0 = b
        var i = a
        
        if a < b {
            while i < b0 {
                self.append(points[i])
                i += 1
            }
        } else {
            while i < n {
                self.append(points[i])
                i += 1
            }
            
            i = 0
            while i < b0 {
                self.append(points[i])
                i += 1
            }
        }
    }
    
    @inlinable
    mutating func reverseAppend(a: Int, b: Int, points: [IntPoint]) {
        let n = points.count

        let b0 = b
        var i = a
        
        if a > b {
            while i > b0 {
                self.append(points[i])
                i -= 1
            }
        } else {
            while i >= 0 {
                self.append(points[i])
                i -= 1
            }
            
            i = n - 1
            while i > b0 {
                self.append(points[i])
                i -= 1
            }
        }
    }

//    func isAnyInsideDirect(a: MileStone, b: MileStone, pa: IntPoint, pb: IntPoint, points: [IntPoint]) -> Bool {
//        let anyPoint = points.anyDirect(a: a, b: b, pa: pa, pb: pb)
//        return self.isContain(point: anyPoint)
//    }
//    
//    @inlinable
//    func anyReverse(a: MileStone, b: MileStone, pa: IntPoint, pb: IntPoint) -> IntPoint {
//        let b0 = b.index
//        let a0 = a.offset != 0 ? a.index : a.index - 1
//        
//        if a > b {
//            if a0 > b0 {
//                return self[a0]
//            } else {
//                let x = (pa.x + pb.x) / 2
//                let y = (pa.y + pb.y) / 2
//                return IntPoint(x: x, y: y)
//            }
//        } else {
//            return self[0]
//        }
//    }
//    
//    func isAnyInsideReverse(a: MileStone, b: MileStone, pa: IntPoint, pb: IntPoint, points: [IntPoint]) -> Bool {
//        let anyPoint = points.anyReverse(a: a, b: b, pa: pa, pb: pb)
//        return self.isContain(point: anyPoint)
//    }
    
}
