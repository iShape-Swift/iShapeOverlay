//
//  PinView.swift
//  ABUnion
//
//  Created by Nail Sharipov on 13.12.2022.
//

import SwiftUI
import iGeometry
import DebugUtil

struct PinView: View {
 
    private let a: IntPoint
    private let b: IntPoint
    private let p: IntPoint
    private let mainColor: Color
    private let fillColor: Color
    private let width: CGFloat
    private let radius: CGFloat
    private let coordSystem: CoordSystem
    
    public init(
        a: IntPoint,
        b: IntPoint,
        p: IntPoint,
        mainColor: Color,
        fillColor: Color,
        width: CGFloat,
        radius: CGFloat,
        coordSystem: CoordSystem
    ) {
        self.a = a
        self.b = b
        self.p = p
        self.mainColor = mainColor
        self.fillColor = fillColor
        self.width = width
        self.radius = radius
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
        
        let wp = CGPoint(
            x: CGFloat(IntGeom.defGeom.float(int: p.x)),
            y: CGFloat(IntGeom.defGeom.float(int: p.y))
        )

        let va = coordSystem.convertToView(point: wa)
        let vb = coordSystem.convertToView(point: wb)
        let vp = coordSystem.convertToView(point: wp)
        
        return ZStack {
            Path() { path in
                path.addEllipse(
                    in: CGRect(
                        x: vp.x - radius,
                        y: vp.y - radius,
                        width: 2 * radius,
                        height: 2 * radius
                    )
                )
            }
            .fill(fillColor)
            Path() { path in
                let r = radius
                let c = vp
                
                let ac = atan2(vb.y - va.y, vb.x - va.x)
                let a0 = ac + CGFloat.pi * 0.75
                let a1 = ac - CGFloat.pi * 0.75
                
                let p = c + CGPoint(radius: r, angle: ac)
                let p0 = c + CGPoint(radius: r, angle: a0)
                let p1 = c + CGPoint(radius: r, angle: a1)
                
                path.move(to: c)
                path.addLine(to: p0)
                path.addLine(to: p)
                path.addLine(to: p1)
                path.closeSubpath()
            }
            .fill(mainColor)
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
