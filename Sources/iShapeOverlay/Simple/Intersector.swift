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
                let s1 = nav.nextIntersect(stone: s0)
                points.append(s0.pin.p)
                switch s0.direction {
                case .ab:
                    points.reverseAppend(m0: s0.pin.mA, m1: s1.pin.mA, points: pathA)
                case .ba:
                    points.directAppend(m0: s0.pin.mB, m1: s1.pin.mB, points: pathB)
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
