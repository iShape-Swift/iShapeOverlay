//
//  File.swift
//  
//
//  Created by Nail Sharipov on 26.09.2022.
//

import SwiftUI
import iGeometry

extension PolygonView {

    struct IndexData: Identifiable {
        let id: Int
        let point: CGPoint
    }
    
    final class ViewModel: ObservableObject {

        private (set) var origin: [IntPoint] = []
        private (set) var points: [IntPoint] = []
        private (set) var path: Path?
        private (set) var indices: [IndexData] = []
        private (set) var vertices: [CGPoint] = []
        private (set) var coordSystem: CoordSystem = .init(size: .zero)
        private (set) var indexBuilder: IndexBuilder?
        private (set) var vertextModifier: VertextModifier?
        private (set) var eVer: CGPoint?
        
        func initialize(points: [IntPoint], coordSystem: CoordSystem, indexBuilder: IndexBuilder?, vertextModifier: VertextModifier?) {
            self.indexBuilder = indexBuilder
            self.vertextModifier = vertextModifier
            self.update(points: points, coordSystem: coordSystem)
        }
        
        func update(points: [IntPoint], coordSystem: CoordSystem) {
            var isModified = false
            if origin != points {
                let rounded = self.round(points: points)
                self.origin = points
                self.points = rounded
                isModified = true
            }
            
            if self.coordSystem != coordSystem {
                self.coordSystem = coordSystem
                isModified = true
            }
            
            if isModified {
                self.update()
            }
        }
        
        private func update() {
            guard !self.points.isEmpty else { return }
            
            let world = points.map {
                CGPoint(
                    x: CGFloat(IntGeom.defGeom.float(int: $0.x)),
                    y: CGFloat(IntGeom.defGeom.float(int: $0.y))
                )
            }
            
            let view = coordSystem.convertToView(points: world)
            
            vertices.removeAll()
            if vertextModifier != nil {
                vertices = view
            }
           
            self.path = Path() { path in
                path.addLines(view)
                path.closeSubpath()
            }

            indices.removeAll()
            if let builder = self.indexBuilder {
                var c = CGPoint.zero
                
                for p in view {
                    c = c + p
                }
                
                c = 1 / CGFloat(view.count) * c
                
                for i in 0..<view.count {
                    let a = view[i]
                    let p = a + builder.radius * (a - c).normalized
                    indices.append(IndexData(id: i, point: p))
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.objectWillChange.send()
            }
            
        }
        
        func onDrag(index: Int, data: DragGesture.Value) {
            guard let ver = eVer else {
                eVer = vertices[index]
                return
            }
            
            let dx = data.translation.width
            let dy = data.translation.height
            
            let pos = ver + CGPoint(x: dx, y: dy)
            let world = coordSystem.convertToWorld(point: pos)
            
            let p = IntGeom.defGeom.int(point: world)

            if let modifier = self.vertextModifier, modifier.gridRound != 0 {
                let r = modifier.gridRound
                let x = r * (p.x / r)
                let y = r * (p.y / r)
                points[index] = IntPoint(x: x, y: y)
            } else {
                points[index] = p
            }
            
            self.update()
            self.vertextModifier?.onModified(points)
        }
        
        func onEndDrag(index: Int, data: DragGesture.Value) {
            defer { eVer = nil }
            guard let ver = eVer else {
                return
            }
            
            let dx = data.translation.width
            let dy = data.translation.height
            
            let pos = ver + CGPoint(x: dx, y: dy)
            let world = coordSystem.convertToWorld(point: pos)
            
            let p = IntGeom.defGeom.int(point: world)

            if let modifier = self.vertextModifier, modifier.gridRound != 0 {
                let r = modifier.gridRound
                let x = r * (p.x / r)
                let y = r * (p.y / r)
                points[index] = IntPoint(x: x, y: y)
            } else {
                points[index] = p
            }

            self.update()

            self.vertextModifier?.onModified(points)
        }
        
        private func round(points: [IntPoint]) -> [IntPoint] {
            guard let modifier = self.vertextModifier, modifier.gridRound != 0 else {
                return points
            }
         
            var rounded = [IntPoint](repeating: .zero, count: points.count)
            
            let r = modifier.gridRound
            for i in 0..<points.count {
                let p = points[i]
                let x = r * (p.x / r)
                let y = r * (p.y / r)
                rounded[i] = IntPoint(x: x, y: y)
            }

            return rounded
        }
    }
}
