//
//  IntArray.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Array where Element == IntPoint {
    
    @inlinable
    mutating func append(a: MileStone, b: MileStone, points: [IntPoint]) {
        let a0 = a.index + 1
        let b0 = b.index + (b.offset == 0 ? 0 : 1)
        let n = points.count
        if a0 <= b0 {
            var i = a0
            while i < b0 {
                self.append(points[i])
                i += 1
            }
        } else {
            var i = a0
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
    mutating func directAppend(m0 a: MileStone, m1 b: MileStone, points: [IntPoint]) {
        let n = points.count

        let b0 = b.index + 1
        var i = a.index + 1
        
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
    mutating func reverseAppend(m0 a: MileStone, m1 b: MileStone, points: [IntPoint]) {
        let n = points.count

        let b0 = b.index
        var i = a.offset != 0 ? a.index : a.index - 1
        
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

    @inlinable
    func anyDirect(a: MileStone, b: MileStone, pa: IntPoint, pb: IntPoint) -> IntPoint {
        if a < b {
            if a.index < b.index {
                return self[a.index + 1]
            } else {
                let x = (pa.x + pb.x) / 2
                let y = (pa.y + pb.y) / 2
                return IntPoint(x: x, y: y)
            }
        } else {
            return self[0]
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
