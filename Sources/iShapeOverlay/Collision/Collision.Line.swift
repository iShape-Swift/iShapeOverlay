//
//  Line.swift
//  
//
//  Created by Nail Sharipov on 06.12.2022.
//

import iGeometry

extension Collision {
    
    struct Line {
        
        static func normalBase(a: IntPoint, b: IntPoint, p: IntPoint) -> DBPoint {
            if a.x == b.x {
                return DBPoint(x: Double(a.x), y: Double(p.y))
            } else if a.y == b.y {
                return DBPoint(x: Double(p.x), y: Double(a.y))
            } else {
                let px = Double(p.x)
                let py = Double(p.y)
                
                let ax = Double(a.x)
                let ay = Double(a.y)
                
                let bx = Double(b.x)
                let by = Double(b.y)
                
                let dx = bx - ax
                let sx = dx * dx
                let dy = by - ay
                let sy = dy * dy
                
                
                let x = (ax * sy + px * sx + dx * dy * (py - ay)) / (sy + sx)
                let y = dx * (px - x) / dy + py
                
                return DBPoint(x: x, y: y)
            }
        }
        
    }
}
