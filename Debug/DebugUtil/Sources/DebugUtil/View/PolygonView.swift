//
//  PolygonView.swift
//  
//
//  Created by Nail Sharipov on 15.09.2022.
//

import SwiftUI
import iGeometry

public struct PolygonView: View {

    public struct IndexBuilder {
        let color: Color
        let radius: CGFloat
        
        public init(color: Color, radius: CGFloat) {
            self.color = color
            self.radius = radius
        }
    }
    
    public struct VertextModifier {
        
        let gridRound: Int64
        let onModified: ([IntPoint]) -> ()
        
        public init(gridRound: Int64 = 0, onModified: @escaping ([IntPoint]) -> ()) {
            self.gridRound = gridRound
            self.onModified = onModified
        }
    }
    
    @StateObject
    private var viewModel = ViewModel()
    
    private let fill: Color
    private let stroke: Color
    private let lineWidth: CGFloat
    private let points: [IntPoint]
    private let indexBuilder: IndexBuilder?
    private let coordSystem: CoordSystem
    private let vertextModifier: VertextModifier?

    public init(
        fill: Color,
        stroke: Color,
        lineWidth: CGFloat,
        points: [IntPoint],
        indexBuilder: IndexBuilder? = nil,
        coordSystem: CoordSystem,
        vertextModifier: VertextModifier? = nil
    ) {
        self.fill = fill
        self.stroke = stroke
        self.lineWidth = lineWidth
        self.points = points
        self.indexBuilder = indexBuilder
        self.coordSystem = coordSystem
        self.vertextModifier = vertextModifier
    }
    
    public var body: some View {
        viewModel.update(points: points, coordSystem: coordSystem)
        return ZStack {
            if let path = viewModel.path {
                path.fill(fill)
                path.stroke(style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(stroke)
            }
            if let builder = indexBuilder {
                ForEach(viewModel.indices) { index in
                    Text("\(index.id)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(builder.color)
                        .position(index.point)
                }
            }
            if vertextModifier != nil {
                ForEach((0..<viewModel.vertices.count), id: \.self) { id in
                    Circle()
                        .fill(.white.opacity(0.1))
                        .frame(width: 32, height: 32)
                        .position(viewModel.vertices[id])
                        .zIndex(1)
                        .gesture(DragGesture()
                            .onChanged { data in
                                viewModel.onDrag(index: id, data: data)
                            }
                            .onEnded { data in
                                viewModel.onEndDrag(index: id, data: data)
                            }
                        )
                }
            }
        }.onAppear() {
            viewModel.initialize(points: points, coordSystem: coordSystem, indexBuilder: indexBuilder, vertextModifier: vertextModifier)
        }
    }

}
