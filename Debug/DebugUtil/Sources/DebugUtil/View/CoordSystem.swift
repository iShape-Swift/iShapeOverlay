//
//  CoordSystem.swift
//  
//
//  Created by Nail Sharipov on 15.09.2022.
//

import CoreGraphics
import iGeometry

public struct CoordSystem: Equatable {
    
    private let center: CGPoint
    private let offset: CGPoint
    private let scale: CGFloat
    
    public init(size: CGSize) {
        self.center = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        self.offset = .zero
        self.scale = 1
    }

    public init(offset: CGPoint, size: CGSize, scale: CGFloat) {
        self.center = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        self.offset = offset
        self.scale = scale
    }
    
    public init(offset: IntPoint, size: CGSize, scale: CGFloat) {
        self.center = CGPoint(x: 0.5 * size.width, y: 0.5 * size.height)
        let c = IntGeom.defGeom.float(point: offset)
        self.offset = CGPoint(x: CGFloat(c.x), y: CGFloat(c.y))
        self.scale = scale
    }
    
    public func convertToView(points: [CGPoint]) -> [CGPoint] {
        let c = center
        let s = scale
        var result = [CGPoint](repeating: .zero, count: points.count)
        
        var i = 0
        for p in points {
            result[i] = CGPoint(
                x: c.x + s * (p.x - offset.x),
                y: c.y - s * (p.y - offset.y)
            )
            i += 1
        }
        
        return result
    }
    
    @inlinable
    public func convertToView(list: [[CGPoint]]) -> [[CGPoint]] {
        var result = [[CGPoint]]()
        for points in list {
            let path = self.convertToView(points: points)
            result.append(path)
        }
        
        return result
    }

    public func convertToView(point p: CGPoint) -> CGPoint {
        let c = center
        let s = scale
        return CGPoint(
            x: c.x + s * (p.x - offset.x),
            y: c.y - s * (p.y - offset.y)
        )
    }
    
    public func convertToWorld(point p: CGPoint) -> CGPoint {
        let c = center
        let s = scale
        return CGPoint(
            x: (p.x - c.x) / s + offset.x,
            y:(-p.y + c.y) / s + offset.y
        )
    }

}
