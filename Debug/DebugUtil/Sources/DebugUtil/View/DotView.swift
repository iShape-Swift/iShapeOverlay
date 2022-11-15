//
//  DotView.swift
//  
//
//  Created by Nail Sharipov on 20.09.2022.
//

import SwiftUI
import iGeometry

public struct DotView: View {

    public let fill: Color
    public let stroke: Color
    public let lineWidth: CGFloat
    public let radius: CGFloat
    public let point: IntPoint
    public let coordSystem: CoordSystem

    public init(fill: Color, stroke: Color, lineWidth: CGFloat, radius: CGFloat, point: IntPoint, coordSystem: CoordSystem) {
        self.fill = fill
        self.stroke = stroke
        self.lineWidth = lineWidth
        self.radius = radius
        self.point = point
        self.coordSystem = coordSystem
    }
    
    public var body: some View {
        let world = CGPoint(
            x: CGFloat(IntGeom.defGeom.float(int: point.x)),
            y: CGFloat(IntGeom.defGeom.float(int: point.y))
        )
        
        let view = coordSystem.convertToView(point: world)
        
        let path = Path() { path in
            
            path.addEllipse(
                in: CGRect(
                    x: view.x - radius,
                    y: view.y - radius,
                    width: 2 * radius,
                    height: 2 * radius
                )
            )
        }
        
        return ZStack {
            path.fill(fill)
            if lineWidth > 0 {
                path.stroke(style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)).foregroundColor(stroke)
            }
        }
    }

}
