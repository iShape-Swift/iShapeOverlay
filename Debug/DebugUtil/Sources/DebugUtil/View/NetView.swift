//
//  NetView.swift
//  
//
//  Created by Nail Sharipov on 26.10.2022.
//

import SwiftUI

public struct NetView: View {
    
    public let step: CGFloat

    public init(step: CGFloat) {
        self.step = step
    }
    
    public var body: some View {

        return ZStack {
            GeometryReader() { proxy in
                self.content(size: proxy.size)
            }
        }
    }
    
    private func content(size: CGSize) -> some View {
        let cx = size.width * 0.5
        let cy = size.height * 0.5

        let wi = Int(cx / step)
        let hi = Int(cy / step)
        
        return ZStack {
            Path { path in

                path.move(to: CGPoint(x: cx, y: 0))
                path.addLine(to: CGPoint(x: cx, y: size.height))
                
                for i in 1...wi {
                    let dx = CGFloat(i) * step
                    
                    let xa = cx + dx
                    let xb = cx - dx
                    
                    path.move(to: CGPoint(x: xa, y: 0))
                    path.addLine(to: CGPoint(x: xa, y: size.height))
                    
                    path.move(to: CGPoint(x: xb, y: 0))
                    path.addLine(to: CGPoint(x: xb, y: size.height))
                }

                path.move(to: CGPoint(x: 0, y: cy))
                path.addLine(to: CGPoint(x: size.width, y: cy))
                
                for i in 1...hi {
                    let dy = CGFloat(i) * step
                    
                    let ya = cy + dy
                    let yb = cy - dy
                    
                    path.move(to: CGPoint(x: 0, y: ya))
                    path.addLine(to: CGPoint(x: size.width, y: ya))
                    
                    path.move(to: CGPoint(x: 0, y: yb))
                    path.addLine(to: CGPoint(x: size.width, y: yb))
                }
            }
            .stroke(style: .init(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel))
            .foregroundColor(.blue.opacity(0.7))
            Path { path in
                let a = 2 * step
                path.move(to: CGPoint(x: cx + a, y: cy))
                path.addLine(to: CGPoint(x: cx, y: cy))
                path.addLine(to: CGPoint(x: cx, y: cy - a))
            }
            .stroke(style: .init(lineWidth: 2, lineCap: .butt, lineJoin: .bevel))
            .foregroundColor(.red)
            Circle()
                .fill(.red)
                .frame(width: 8, height: 8)
                .position(CGPoint(x: cx, y: cy))
        }
        
    }
    
}
