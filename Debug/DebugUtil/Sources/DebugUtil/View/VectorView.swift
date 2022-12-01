//
//  VectorView.swift
//  
//
//  Created by Nail Sharipov on 01.12.2022.
//

import SwiftUI
import iGeometry

public struct VectorView: View {
 
    private let a: IntPoint
    private let b: IntPoint
    private let color: Color
    private let width: CGFloat
    private let arrow: CGFloat
    private let coordSystem: CoordSystem
    
    public init(
        a: IntPoint,
        b: IntPoint,
        color: Color,
        width: CGFloat,
        arrow: CGFloat,
        coordSystem: CoordSystem
    ) {
        self.a = a
        self.b = b
        self.color = color
        self.width = width
        self.arrow = arrow
        self.coordSystem = coordSystem
    }

    public var body: some View {
        let wa = CGPoint(
            x: CGFloat(IntGeom.defGeom.float(int: a.x)),
            y: CGFloat(IntGeom.defGeom.float(int: a.y))
        )
        
        let wb = CGPoint(
            x: CGFloat(IntGeom.defGeom.float(int: b.x)),
            y: CGFloat(IntGeom.defGeom.float(int: b.y))
        )

        
        let va = coordSystem.convertToView(point: wa)
        let vb = coordSystem.convertToView(point: wb)

        return VectorShape(a: va, b: vb, arrow: arrow)
            .stroke(style: .init(lineWidth: width, lineCap: .round, lineJoin: .round))
            .foregroundColor(color)
    }
}

struct VectorShape: SwiftUI.Shape {

    let a: CGPoint
    let b: CGPoint
    let arrow: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path() { path in
            let angle = atan2(b.y - a.y, b.x - a.x)
            let angleLeft = angle + CGFloat.pi * 9 / 10
            let angleRight = angle - CGFloat.pi * 9 / 10
            
            let leftPoint = b + CGPoint(radius: arrow, angle: angleLeft)
            let rightPoint = b + CGPoint(radius: arrow, angle: angleRight)
            
            path.move(to: leftPoint)
            path.addLine(to: b)
            path.addLine(to: rightPoint)
            
            path.move(to: b)
            path.addLine(to: a)
        }
    }
}

private extension CGPoint {
    
    init(radius: CGFloat, angle: CGFloat) {
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        self.init(x: x, y: y)
    }
}
