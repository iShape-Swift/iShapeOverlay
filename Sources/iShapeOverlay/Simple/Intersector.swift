//
//  Intersector.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

struct Intersector {
    
    struct Result {
        let list: [IntPath]
    }
    
    func intersect(pathA: [IntPoint], pathB: [IntPoint], navigator: Navigator) -> Result {

        var list = [IntPath]()
        
        var nav = navigator

        var s0 = nav.nextIntersect()
        var points = [IntPoint]()
        let fixer = Fixer()

        while s0.isNotEmpty {
            
            let start = s0.pinId
            
            repeat {
                let s1 = nav.nextIntersect(stone: s0, endId: start)
                switch s0.direction {
                case .ab:
                    points.reverseAppend(a: s0.pin.a, b: s1.pin.a, points: pathA)
                case .ba:
                    points.directAppend(a: s0.pin.b, b: s1.pin.b, points: pathB)
                }
                
                s0 = s1
            } while s0.pinId != start
            
            let regions = fixer.solve(path: points, clockWise: true)
            for region in regions {
                list.append(IntPath(unsafe: region))
            }

            points.removeAll(keepingCapacity: true)

            s0 = nav.nextIntersect()
        }
        
        return Result(list: list)
    }
    
}
