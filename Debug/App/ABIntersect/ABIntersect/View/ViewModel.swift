//
//  ViewModel.swift
//  ABIntersect
//
//  Created by Nail Sharipov on 24.11.2022.
//

import SwiftUI
import iGeometry
import DebugUtil
@testable import iShapeOverlay

final class ViewModel: ObservableObject {

    struct Pin: Identifiable, Hashable {
        let id: Int
        let a: IntPoint
        let b: IntPoint
        let p: IntPoint
        let mainColor: Color
        let fillColor: Color
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(p.x)
            hasher.combine(p.y)
            hasher.combine(a.x)
            hasher.combine(a.y)
            hasher.combine(b.x)
            hasher.combine(b.y)
            hasher.combine(mainColor.hashValue)
            hasher.combine(fillColor.hashValue)
        }
    }
    
    struct Polygon: Identifiable {
        let id: Int
        let color: Color
        let points: [IntPoint]
    }

    private let test = Test()
    var title: String { "test \(test.index)" }
    private (set) var scale: CGFloat = 20
    private (set) var shapeA: [IntPoint] = []
    private (set) var shapeB: [IntPoint] = []
    private (set) var pins: [Pin]?
    private (set) var polygons: [Polygon]?
    
    func coordSystem(size: CGSize) -> CoordSystem {
        let iOffset = IntPoint(x: 0, y: 0)
        let fOffset = IntGeom.defGeom.float(point: iOffset)
        let offset = CGPoint(x: CGFloat(fOffset.x), y: CGFloat(fOffset.y))

        return CoordSystem(offset: offset, size: size, scale: scale)
    }
    
    func onAppear() {
        self.load()
    }
    
    func onNext() {
        test.next()
        self.load()
    }
    
    func onPrev() {
        test.prev()
        self.load()
    }
    
    func onScaleUp() {
        scale *= 2
        objectWillChange.send()
    }
    
    func onScaleDown() {
        scale /= 2
        objectWillChange.send()
    }
    
    func update() {
        self.doTask()
        objectWillChange.send()
    }
    
    func load() {
        let data = test.current
        shapeA = data.shapeA
        shapeB = data.shapeB
        self.doTask()
        objectWillChange.send()
    }
    
    func doTask() {
        let detector = Collision.Detector()
        let result = detector.findPins(pathA: shapeA, pathB: shapeB, fixer: Fixer())

        switch result.pinResult {
        case .success:
            self.success(pathA: shapeA, pathB: shapeB, pins: result.pins)
        case .modified:
            self.success(
                pathA: result.pathA.isEmpty ? [] : result.pathA[0],
                pathB: result.pathB.isEmpty ? [] : result.pathB[0],
                pins: result.pins
            )
        case .conflict:
            self.pins = nil
            self.polygons = nil
        }
    }
    
    private func success(pathA: [IntPoint], pathB: [IntPoint], pins: [PinPoint]) {
        let intersector = Intersector()
        
        let segments = intersector.intersect(pathA: pathA, pathB: pathB, navigator: Navigator(pins: pins))
        
//        print(segments)
        
        var pinList = [Pin]()

        let nb = pathB.count

        for id in 0..<pins.count {
            let pin = pins[id]
            let a = pathB[(pin.b - 1 + nb) % nb]
            let b = pathB[(pin.b + 1) % nb]

            let mainColor: Color
            let fillColor: Color

            switch pin.type {
            case .into:
                mainColor = .blue
                fillColor = .white
            case .out:
                mainColor = .red
                fillColor = .white
            case .false_in_same:
                mainColor = .blue
                fillColor = .cyan
            case .false_in_back:
                mainColor = .blue
                fillColor = .black
            case .false_out_same:
                mainColor = .red
                fillColor = .cyan
            case .false_out_back:
                mainColor = .red
                fillColor = .black
            case .start_in:
                mainColor = .blue
                fillColor = .green
            case .start_out:
                mainColor = .red
                fillColor = .green
            case .end_in:
                mainColor = .blue
                fillColor = .yellow
            case .end_out:
                mainColor = .red
                fillColor = .yellow
            }

            pinList.append(Pin(
                id: id,
                a: a,
                b: b,
                p: pin.p,
                mainColor: mainColor,
                fillColor: fillColor)
            )
        }

        self.pins = pinList

        var polygons = [Polygon]()
        for i in 0..<segments.list.count {
            let polygon = Polygon(
                id: i,
                color: .white,
                points: segments.list[i].points
            )
            
            polygons.append(polygon)
        }
        
        self.polygons = polygons
    }
    
    
    func onModifiedA(points: [IntPoint]) {
        guard shapeA != points else {
            return
        }
        shapeA = points
        self.doTask()
        objectWillChange.send()
    }

    func onModifiedB(points: [IntPoint]) {
        guard shapeB != points else {
            return
        }
        shapeB = points
        self.doTask()
        objectWillChange.send()
    }

}
