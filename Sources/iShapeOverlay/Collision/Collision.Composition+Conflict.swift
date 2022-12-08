//
//  Collision.Composition+Conflict.swift
//  
//
//  Created by Nail Sharipov on 07.12.2022.
//

import iGeometry

extension Collision.Composition {
    
    private struct OrderPoint {
        let point: IntPoint
        let order: Int64
    }
    
    struct Paths {
        let updateA: PathUpdate
        let updateB: PathUpdate
    }
    
    struct PathUpdate {
        let isModified: Bool
        let path: [IntPoint]
    }
    
    func eliminateConflictDots(pathA: [IntPoint], pathB: [IntPoint]) -> Paths {
        
        var mapA = [Int: [OrderPoint]]()
        var mapB = [Int: [OrderPoint]]()
        var countA = 0
        var countB = 0
        
        for dot in dots {
            if dot.mA.offset != 0 {
                let op = OrderPoint(point: dot.p, order: dot.mA.offset)
                if var array = mapA[dot.mA.index] {
                    array.append(op)
                    mapA[dot.mA.index] = array
                } else {
                    mapA[dot.mA.index] = [op]
                }
                countA += 1
            }
            if dot.mB.offset != 0 {
                let op = OrderPoint(point: dot.p, order: dot.mB.offset)
                if var array = mapB[dot.mB.index] {
                    array.append(op)
                    mapB[dot.mB.index] = array
                } else {
                    mapB[dot.mB.index] = [op]
                }
                countB += 1
            }
        }
        
        let updateA: PathUpdate
        
        if countA > 0 {
            let newA = self.updatePath(path: pathA, map: mapA, count: countA)
            updateA = .init(isModified: true, path: newA)
        } else {
            updateA = .init(isModified: false, path: [])
        }

        let updateB: PathUpdate
        
        if countB > 0 {
            let newB = self.updatePath(path: pathB, map: mapB, count: countB)
            updateB = .init(isModified: true, path: newB)
        } else {
            updateB = .init(isModified: false, path: [])
        }

        return Paths(
            updateA: updateA,
            updateB: updateB
        )
    }
    
    private func updatePath(path: [IntPoint], map: [Int: [OrderPoint]], count: Int) -> [IntPoint] {
        var result = [IntPoint]()
        result.reserveCapacity(count)
        
        let n = path.count
        
        for i in 0..<n {
            let p = path[i]
            result.append(p)
            if var items = map[i] {
                items.sort(by: { $0.order < $1.order })
                for item in items {
                    result.append(item.point)
                }
            }
        }
        
        return result
    }
    
}
