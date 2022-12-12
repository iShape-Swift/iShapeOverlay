//
//  Util.swift
//  
//
//  Created by Nail Sharipov on 09.12.2022.
//

import CoreGraphics
import iGeometry
@testable import iShapeOverlay

extension Array where Element == IntPoint {
    
    func shift(offset: Int) -> [IntPoint] {
        guard offset != 0 else { return self }
        var array = [IntPoint]()
        let n = count
        array.reserveCapacity(n)
        for i in 0..<n {
            array.append(self[(i + offset) % n])
        }
        return array
    }

    func isSame(_ array: [IntPoint]) -> Bool {
        guard array.count == count else { return false }
        guard !array.isEmpty && !self.isEmpty else { return true }
        
        let n = count
        for i in 0..<n {
            var isEqual = true
            for j in 0..<n {
                let a = self[j]
                let b = array[(j + i) % n]
                if !a.isPrettySame(b) {
                    isEqual = false
                    break
                }
            }
            if isEqual {
                return true
            }
        }
        
        return false
    }
    
    var prettyPrint: String {
        guard !self.isEmpty else { return "" }
        var result = String()
        for i in 0..<count {
            let ip = self[i]
            let p = IntGeom.defGeom.float(point: ip)
            result.append("CGPoint(\(p.x), \(p.y))")
            if i != count - 1 {
                result.append(", ")
            }
        }
        return result
    }
    
}

extension Array where Element == IntPath {
    func isSame(_ array: [IntPath]) -> Bool {
        guard array.count == count else { return false }
        guard !array.isEmpty && !self.isEmpty else { return true }
        
        var buffer = array
        for a in self {
            if let index = buffer.firstIndex(where: { a == $0 }) {
                buffer.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
}

extension IntPath: Equatable {
    
    public static func == (lhs: IntPath, rhs: IntPath) -> Bool {
        let a = abs(lhs.area - rhs.area)
        guard a < 2_000 else { return false }
        return lhs.points.isSame(rhs.points)
    }

}

extension CGPoint {
    
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
}

private extension IntPoint {
    
    func isPrettySame(_ p: IntPoint) -> Bool {
        let dx = p.x - x
        let dy = p.y - y
        
        return dx * dx + dy * dy <= 2
    }
    
}
