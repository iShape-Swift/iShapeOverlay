//
//  ContentView.swift
//  ABIntersect
//
//  Created by Nail Sharipov on 24.11.2022.
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
                fill: .white.opacity(0.2),
                stroke: .white.opacity(0.4),
                lineWidth: 2,
                points: viewModel.shapeA,
                indexBuilder: .init(color: .orange, radius: 12),
                coordSystem: coordSystem,
                vertextModifier: .init(gridRound: 100000) { points in
                    viewModel.onModifiedA(points: points)
                }
            )
            PolygonView(
                fill: .black.opacity(0.2),
                stroke: .black.opacity(0.4),
                lineWidth: 2,
                points: viewModel.shapeB,
                indexBuilder: .init(color: .orange, radius: 12),
                coordSystem: coordSystem,
                vertextModifier: .init(gridRound: 100000) { points in
                    viewModel.onModifiedB(points: points)
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
            if let pins = viewModel.pins {
                ForEach(pins) { pin in
                    PinView(
                        a: pin.a,
                        b: pin.b,
                        p: pin.p,
                        mainColor: pin.mainColor,
                        fillColor: pin.fillColor,
                        width: 4,
                        radius: 10,
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
