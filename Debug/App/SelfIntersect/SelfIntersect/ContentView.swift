//
//  ContentView.swift
//  SelfIntersect
//
//  Created by Nail Sharipov on 09.11.2022.
//

import SwiftUI
import DebugUtil

struct ContentView: View {
    
    @StateObject
    var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            content(size: proxy.size)
        }
        .frame(minWidth: 400, minHeight: 400)
        .onAppear() {
            viewModel.onAppear()
        }
    }
    
    private func content(size: CGSize) -> some View {
        let coordSystem = CoordSystem(size: size)
        return ZStack {
            PolygonView(
                fill: .gray.opacity(0.2),
                stroke: .gray.opacity(0.4),
                lineWidth: 2,
                points: viewModel.shape,
                indexBuilder: .init(color: .orange, radius: 12),
                coordSystem: coordSystem,
                vertextModifier: .init(gridRound: 0) { points in
                    viewModel.onModified(points: points)
                }
            )
            ForEach(viewModel.polygons) { polygon in
                PolygonView(
                    fill: polygon.color,
                    stroke: .white,
                    lineWidth: 4,
                    points: polygon.points,
                    coordSystem: coordSystem
                )
            }
            if let dots = viewModel.dots {
                ForEach((0..<dots.count), id: \.self) { id in
                    DotView(
                        fill: .white,
                        stroke: .white,
                        lineWidth: 0,
                        radius: 6,
                        point: dots[id],
                        coordSystem: coordSystem
                    )
                }
            }
            VStack() {
                Button("Next") {
                    viewModel.onNext()
                }.padding(.top, 16)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}
