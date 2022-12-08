//
//  Intersector.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

struct Intersector {
    
    struct Result {
        let list: [Path]
    }
    
    func intersect(pathA: [IntPoint], pathB: [IntPoint], navigator: Navigator) -> Result {

        var list = [Path]()
        
        var nav = navigator

        var s0 = nav.nextIntersect()
        while s0.isNotEmpty {

            var points = [IntPoint]()
            
            let start = s0.pinId
            
            repeat {
                let s1 = nav.nextIntersect(stone: s0, endId: start)
                points.append(s0.pin.p)
                switch s0.direction {
                case .ab:
                    points.reverseAppend(a: s0.pin.a, b: s1.pin.a, points: pathA)
                case .ba:
                    points.directAppend(a: s0.pin.b, b: s1.pin.b, points: pathB)
                }
                
                s0 = s1
            } while s0.pinId != start

            list.append(Path(unsafe: points))
            points.removeAll(keepingCapacity: true)

            s0 = nav.nextIntersect()
        }
        
        return Result(list: list)
    }
    
}
