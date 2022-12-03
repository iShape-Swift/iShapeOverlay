//
//  Tests+Array.swift
//  
//
//  Created by Nail Sharipov on 02.12.2022.
//

#if DEBUG

import iGeometry

extension Array where Element == IntPoint {

    func scale(value: Int64) -> [IntPoint] {
        var result = Array(repeating: .zero, count: self.count)
        for i in 0..<self.count {
            let p = self[i]
            result[i] = IntPoint(x: p.x * value, y: p.y * value)
        }
        return result
    }
    
    func points(scale: Int64 = 1) -> [Point] {
        var result = [Point](repeating: .zero, count: self.count)
        let geom = IntGeom.defGeom
        for i in 0..<self.count {
            let p = self[i]
            let x = geom.float(int: p.x * scale)
            let y = geom.float(int: p.y * scale)
            result[i] = Point(x: x, y: y)
        }
        return result
    }
}

extension Array where Element == Point {
    var int: [IntPoint] {
        IntGeom.defGeom.int(points: self)
    }
}

#endif
