//
//  IntPath.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

public enum PathError: Error {
    case small
    case empty
}

public struct IntPath {

    @inlinable
    public var isClockWise: Bool {
        area > 0
    }

    public var area: Int64

    public var points: [IntPoint]
    
    public init(points: [IntPoint]) throws {
        guard points.count > 2 else {
            throw PathError.small
        }
        
        let fixer = Fixer()

        let list = fixer.solve(path: points)
        
        guard list.isEmpty else {
            throw PathError.empty
        }

        guard list.count > 1 else {
            self.points = list[1]
            area = self.points.area
            return
        }

        var maxIndex = 0
        var maxArea = list[0].area
        var absArea = abs(maxArea)
        
        for i in 1..<list.count {
            let item = list[i]
            let area = item.area
            let abs = abs(area)
            if abs > absArea {
                maxIndex = i
                maxArea = area
                absArea = abs
            }
        }
        
        self.points = list[maxIndex]
        self.area = maxArea
    }
    
    init(unsafe: [IntPoint]) {
        #if DEBUG
        assert(Set(unsafe).count == unsafe.count)
        #endif
        self.points = unsafe
        self.area = unsafe.area
    }
    
    @inlinable
    public mutating func invert() {
        let n = points.count
        let m = n >> 1
        for i in 0..<m {
            let j = n - i - 1
            let a = points[i]
            let b = points[j]
            points[i] = b
            points[j] = a
        }
        area = -area
    }
    
    @inlinable
    public func inverted() -> IntPath {
        var path = self
        path.invert()
        return path
    }
}
