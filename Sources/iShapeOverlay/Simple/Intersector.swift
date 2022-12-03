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
        while !s0.isEmpty {

            var points = [IntPoint]()
            
            repeat {
                let s1 = nav.nextIntersect(stone: s0)
                points.append(s0.p)
                switch s0.direction {
                case .ab:
                    points.directAppend(m0: s0.m, m1: s1.m, points: pathB)
                case .ba:
                    points.directAppend(m0: s0.m, m1: s1.m, points: pathA)
                }
                
                s0 = s1
            } while !s0.isEmpty

            list.append(Path(unsafe: points))
            points.removeAll(keepingCapacity: true)
        }
        
        return Result(list: list)
    }
    
}
