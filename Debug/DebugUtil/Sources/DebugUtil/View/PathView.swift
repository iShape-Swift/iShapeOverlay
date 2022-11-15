//
//  PathView.swift
//  
//
//  Created by Nail Sharipov on 20.09.2022.
//

import SwiftUI
import iGeometry

public struct PathView: View {

    public let color: Color
    public let lineWidth: CGFloat
    public let points: [IntPoint]
    public let coordSystem: CoordSystem

    public init(color: Color, lineWidth: CGFloat, points: [IntPoint], coordSystem: CoordSystem) {
        self.color = color
        self.lineWidth = lineWidth
        self.points = points
        self.coordSystem = coordSystem
    }
    
    public var body: some View {
        let world = points.map {
            CGPoint(
                x: CGFloat(IntGeom.defGeom.float(int: $0.x)),
                y: CGFloat(IntGeom.defGeom.float(int: $0.y))
            )
        }
        
        let view = coordSystem.convertToView(points: world)
       
        let path = Path() { path in
            path.addLines(view)
        }
        
        return ZStack {
            path.stroke(style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
        }
    }

}
