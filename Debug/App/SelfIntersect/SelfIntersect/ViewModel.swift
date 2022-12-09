//
//  ViewModel.swift
//  SelfIntersect
//
//  Created by Nail Sharipov on 09.11.2022.
//

import SwiftUI
import iGeometry
import DebugUtil
@testable import iShapeOverlay

final class ViewModel: ObservableObject {
    
    struct Polygon: Identifiable {
        let id: Int
        let color: Color
        let points: [IntPoint]
    }
    
    private var randomColor: Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
    
    private let colors: [Color] = [
        .red,
        .blue,
        .green,
        .orange,
        .yellow,
        .mint,
        .teal,
        .cyan,
        .indigo,
        .purple,
        .pink,
        .brown
    ]
    
    private let test = Test()
    private (set) var shape: [IntPoint] = []
    private (set) var dots: [IntPoint]?
    private (set) var polygons: [Polygon] = []
    
    func coordSystem(size: CGSize) -> CoordSystem {
        let iOffset = IntPoint(x: 0, y: 0)
        let fOffset = IntGeom.defGeom.float(point: iOffset)
        let offset = CGPoint(x: CGFloat(fOffset.x), y: CGFloat(fOffset.y))

        return CoordSystem(offset: offset, size: size, scale: 1)
    }
    
    func onAppear() {
        self.load()
    }
    
    func onNext() {
        test.next()
        self.load()
    }
    
    func load() {
        shape = test.current
        self.doTask()
        objectWillChange.send()
    }
    
    func doTask() {
        let fixer = Fixer()
        let result = fixer.solve(path: shape, removeSameLine: true)

        var polygons = [Polygon]()
        var dots = [IntPoint]()
        for i in 0..<result.count {
            let polygon = result[i]
            let line = Polygon(
                id: i,
                color: randomColor,
                points: polygon
            )

            polygons.append(line)
            
            for p in polygon {
                dots.append(p)
            }
        }

        self.dots = dots
        self.polygons = polygons
    }
    
    func onModified(points: [IntPoint]) {
        guard shape != points else {
            return
        }
        shape = points
        self.doTask()
        objectWillChange.send()
    }

}

