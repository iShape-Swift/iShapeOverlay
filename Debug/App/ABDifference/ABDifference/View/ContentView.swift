//
//  ContentView.swift
//  ABDiference
//
//  Created by Nail Sharipov on 12.12.2022.
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
        let coordSystem = viewModel.coordSystem(size: size)
        return ZStack {
            PolygonView(
                fill: .white.opacity(0.2),
                stroke: .white.opacity(0.4),
                lineWidth: 2,
                points: viewModel.shapeA,
                indexBuilder: .init(color: .orange, radius: 12),
                coordSystem: coordSystem,
                vertextModifier: .init(gridRound: 0) { points in
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
                vertextModifier: .init(gridRound: 0) { points in
                    viewModel.onModifiedB(points: points)
                }
            )
            if let polygons = viewModel.polygons {
                ForEach(polygons) { polygon in
                    PolygonView(
                        fill: .white.opacity(0.6),
                        stroke: .clear,
                        lineWidth: 0,
                        points: polygon.points,
                        coordSystem: coordSystem
                    )
                }
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
                Text(viewModel.title).padding(8)
                HStack() {
                    Button("Prev") {
                        viewModel.onPrev()
                    }.padding(.leading, 20)
                    Spacer(minLength: 10)
                    Button("-") {
                        viewModel.onScaleDown()
                    }.frame(minWidth: 40)
                    Spacer(minLength: 10)
                    Button("update") {
                        viewModel.update()
                    }.frame(minWidth: 40)
                    Spacer(minLength: 10)
                    Button("+") {
                        viewModel.onScaleUp()
                    }.frame(minWidth: 40)
                    Spacer(minLength: 10)
                    Button("Next") {
                        viewModel.onNext()
                    }.padding(.trailing, 20)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}
