//
//  ViewModel.swift
//  CornerApp
//
//  Created by Nail Sharipov on 30.11.2022.
//

import SwiftUI

final class ViewModel: ObservableObject {

    private (set) var color = Color.gray
    private (set) var testPoint = CGPoint(x: 200, y: 200)
    private (set) var dots: [CGPoint] = [
        CGPoint(x: 100, y: 300),
        CGPoint(x: 200, y: 100),
        CGPoint(x: 300, y: 300)
    ]

    func onAppear() {
        self.validate()
        objectWillChange.send()
    }
    
    func onDrag(index: Int, data: DragGesture.Value) {
        dots[index] = data.location
        self.validate()
        objectWillChange.send()
    }
    
    func onEndDrag(index: Int, data: DragGesture.Value) {
        dots[index] = data.location
        self.validate()
        objectWillChange.send()
    }

    func onDrag(data: DragGesture.Value) {
        testPoint = data.location
        self.validate()
        objectWillChange.send()
    }
    
    func onEndDrag(data: DragGesture.Value) {
        testPoint = data.location
        self.validate()
        objectWillChange.send()
    }
    
    private func validate() {
        let corner = Corner(o: dots[1], a: dots[0], b: dots[2])
        let result = corner.isBetween(p: testPoint, clockwise: true)
        
        switch result {
        case .contain:
            self.color = .green
        case .absent:
            self.color = .black.opacity(0.5)
        case .onBoarder:
            self.color = .red
        }
    }
    
    private func isInCorner(a: CGPoint, o: CGPoint, b: CGPoint, x: CGPoint) -> Bool {
        let aob = isCCW(a, o, b)
        let aox = isCCW(a, o, x)
        let xob = isCCW(x, o, b)
        
        return aob == aox && aob == xob
    }
    
    private func isCCW(_ p0: CGPoint, _ p1: CGPoint, _ p2: CGPoint) -> Bool {
        let m0 = (p2.y - p0.y) * (p1.x - p0.x)
        let m1 = (p1.y - p0.y) * (p2.x - p0.x)

        return m0 <= m1
    }
}
