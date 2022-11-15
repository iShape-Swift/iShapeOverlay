//
//  File.swift
//  
//
//  Created by Nail Sharipov on 15.09.2022.
//

import iGeometry
import CoreGraphics

public extension PlainShape {
    init(points: [CGPoint]) {
        let hull = points.map({ Point(x: Float($0.x), y: Float($0.y)) })
        self.init(iGeom: .defGeom, hull: hull)
    }
}
