//
//  File.swift
//  
//
//  Created by Nail Sharipov on 15.09.2022.
//

import CoreGraphics
import iGeometry

@inline(__always)
public func +(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

@inline(__always)
public func -(left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

@inline(__always)
public func *(left: CGFloat, right: CGPoint) -> CGPoint {
    CGPoint(x: left * right.x, y: left * right.y)
}

@inline(__always)
public func *(left: CGFloat, right: CGSize) -> CGSize {
    CGSize(width: left * right.width, height: left * right.height)
}

public extension CGPoint {
    
    @inlinable
    var sqrMagnitude: CGFloat {
        x * x + y * y
    }

    @inlinable
    var normalized: CGPoint {
        let k = 1 / sqrMagnitude.squareRoot()
        return CGPoint(x: k * x, y: k * y)
    }
    
    init(point: IntPoint) {
        let x = IntGeom.defGeom.float(int: point.x)
        let y = IntGeom.defGeom.float(int: point.y)
        self.init(x: CGFloat(x), y: CGFloat(y))
    }
}
