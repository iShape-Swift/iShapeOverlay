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
            guard dot.mA.offset == 0 || dot.mB.offset == 0 else {
                continue
            }
            
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
            updateA = self.updatePath(path: pathA, map: mapA, count: countA)
        } else {
            updateA = .init(isModified: false, path: [])
        }

        let updateB: PathUpdate
        
        if countB > 0 {
            updateB = self.updatePath(path: pathB, map: mapB, count: countB)
        } else {
            updateB = .init(isModified: false, path: [])
        }

        return Paths(
            updateA: updateA,
            updateB: updateB
        )
    }
    
    private func updatePath(path: [IntPoint], map: [Int: [OrderPoint]], count: Int) -> PathUpdate {
        var result = [IntPoint]()
        result.reserveCapacity(count)
        
        let n = path.count
        var anyUpdate = false
        
        for i in 0..<n {
            let p = path[i]
            result.append(p)
            if var items = map[i] {
                
                var isSameLine = true
                let a = path[i]
                let b = path[(i + 1) % n]
                
                let ba = b - a
                
                for item in items {
                    let c = item.point
                    let ca = c - a
                    let res = ba.x * ca.y - ca.x * ba.y
                    if res != 0 {
                        isSameLine = false
                        break
                    }
                }
                
                if !isSameLine {
                    anyUpdate = true
                    items.sort(by: { $0.order < $1.order })
                    for item in items {
                        result.append(item.point)
                    }
                }
            }
        }
        
        if anyUpdate {
            return PathUpdate(isModified: true, path: result)
        } else {
            return PathUpdate(isModified: false, path: [])
        }
    }
    
    private func isSameLine(ba: IntPoint, a: IntPoint, c: IntPoint) -> Bool {
        let ca = c - a
        let res = ba.x * ca.y - ca.x * ba.y
        return res == 0
    }
    
}
