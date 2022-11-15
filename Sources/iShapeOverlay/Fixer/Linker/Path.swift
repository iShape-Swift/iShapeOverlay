//
//  Path.swift
//  
//
//  Created by Nail Sharipov on 15.11.2022.
//

import iGeometry

extension Linker {
    
    struct Path {
        
        private var points: [IntPoint]
        private var indices: [Int]
        private var set: [Int]
        
        @inlinable
        init(count: Int) {
            points = [IntPoint]()
            points.reserveCapacity(count)
            indices = [Int]()
            indices.reserveCapacity(count)
            set = [Int](repeating: -1, count: count)
        }
        
        @inlinable
        func isContain(_ node: Linker.Node) -> Bool {
            set[node.index] != -1
        }
        
        @inlinable
        mutating func add(_ node: Linker.Node) {
            set[node.index] = points.count
            points.append(node.point)
            indices.append(node.index)
        }
        
        @inlinable
        mutating func slice(node: Linker.Node) -> [IntPoint] {
            let start = set[node.index]
            let n = points.count
            guard start < n else {
                return []
            }

            for i in start..<n {
                let index = indices[i]
                set[index] = -1
            }
            
            let result: [IntPoint]
            let count = n - start
            if count > 2 {
                if start != 0 {
                    result = Array(points[start..<n]).removeSameLinePoints()
                } else {
                    result = points.removeSameLinePoints()
                }
            } else {
                result = []
            }
            
            points.removeLast(count)
            indices.removeLast(count)
            
            return result
        }
    }
}

private extension Array where Element == IntPoint {
    
    func removeSameLinePoints() -> [IntPoint] {
        let n = self.count
        guard n > 2 else { return self }
        var result = [IntPoint]()
        result.reserveCapacity(n)
        
        var a = self[n - 2]
        var b = self[n - 1]
        for c in self {
            if !IntPoint.isSameLine(a: a, b: b, c: c) {
                result.append(b)
            }
            a = b
            b = c
        }
        
        return result
    }

}
