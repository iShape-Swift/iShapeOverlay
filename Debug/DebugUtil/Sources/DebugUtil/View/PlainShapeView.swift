//
//  PlainShapeView.swift
//  
//
//  Created by Nail Sharipov on 15.09.2022.
//
/*
import SwiftUI
import iGeometry

public struct PlainShapeView: View {

    public let fill: Color
    public let stroke: Color
    public let lineWidth: CGFloat
    public let plainShape: PlainShape
    public let coordSystem: CoordSystem

    public init(fill: Color, stroke: Color, lineWidth: CGFloat, plainShape: PlainShape, coordSystem: CoordSystem) {
        self.fill = fill
        self.stroke = stroke
        self.lineWidth = lineWidth
        self.plainShape = plainShape
        self.coordSystem = coordSystem
    }
    
    public var body: some View {
        let path = Path() { path in
            let hull = self.points(iPoints: plainShape.get(index: 0))
            path.addLines(hull)
            path.closeSubpath()
            
            if plainShape.layouts.count > 1 {
                for i in 1..<plainShape.layouts.count {
                    let hole = self.points(iPoints: plainShape.get(index: i))
                    
                    path.addLines(hole)
                    path.closeSubpath()
                }
            }
        }

        return ZStack {
            path.fill(fill)
            path.stroke(style: .init(lineWidth: lineWidth, lineCap: .butt, lineJoin: .bevel))
                .foregroundColor(stroke)
        }
    }

    private func points(iPoints: [IntPoint]) -> [CGPoint] {
        let world = iPoints.map {
            CGPoint(
                x: CGFloat(IntGeom.defGeom.float(int: $0.x)),
                y: CGFloat(IntGeom.defGeom.float(int: $0.y))
            )
        }
        
        let view = coordSystem.convertToView(points: world)
        
        return view
    }
}
*/
