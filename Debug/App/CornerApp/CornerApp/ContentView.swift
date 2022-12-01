//
//  ContentView.swift
//  CornerApp
//
//  Created by Nail Sharipov on 30.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var viewModel = ViewModel()
    
    var body: some View {
        content()
        .frame(minWidth: 400, minHeight: 400)
        .onAppear() {
            viewModel.onAppear()
        }
    }
    
    private func content() -> some View {
        ZStack {
            VectorShape(a: viewModel.dots[0], b: viewModel.dots[1], arrow: 20)
                .stroke(style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(.gray)
            VectorShape(a: viewModel.dots[1], b: viewModel.dots[2], arrow: 20)
                .stroke(style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(.gray)
            Circle()
                .fill(viewModel.color)
                .frame(width: 32, height: 32)
                .position(viewModel.testPoint)
                .zIndex(1)
                .gesture(DragGesture()
                    .onChanged { data in
                        viewModel.onDrag(data: data)
                    }
                    .onEnded { data in
                        viewModel.onEndDrag(data: data)
                    }
                )
            ForEach((0..<viewModel.dots.count), id: \.self) { id in
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 32, height: 32)
                    .position(viewModel.dots[id])
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
        .padding()
    }
    
}
