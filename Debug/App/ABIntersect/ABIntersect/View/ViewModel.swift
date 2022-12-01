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
    private (set) var shapeA: [IntPoint] = []
    private (set) var shapeB: [IntPoint] = []
    private (set) var dots: [IntPoint]?
    private (set) var pins: [Pin]?
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
        let data = test.current
        shapeA = data.shapeA
        shapeB = data.shapeB
        self.doTask()
        objectWillChange.send()
    }
    
    func doTask() {
        let detector = Collision.Detector()
        let pins = detector.findPins(pathA: shapeA, pathB: shapeB)
        debugPrint(pins)
        
        var pinList = [Pin]()
        
        let nb = shapeB.count
        
        for id in 0..<pins.count {
            let pin = pins[id]
            let a = shapeB[pin.mB.offset == 0 ? (pin.mB.index - 1 + nb) % nb : pin.mB.index]
            let b = shapeB[(pin.mB.index + 1) % nb]
            
            let mainColor: Color
            let fillColor: Color
            
            switch pin.type {
            case .into:
                mainColor = .blue
                fillColor = .white
            case .out:
                mainColor = .red
                fillColor = .white
            case .false_in:
                mainColor = .blue
                fillColor = .gray
            case .false_out:
                mainColor = .red
                fillColor = .gray
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
            case .null:
                mainColor = .gray
                fillColor = .black
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
