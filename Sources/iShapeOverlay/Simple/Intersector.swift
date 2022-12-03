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
        while s0.direction != .stop {

            var points = [IntPoint]()
            
            repeat {
                let s1 = nav.nextIntersect(stone: s0)
//                if s0.pin.mA.offset != 0 && s0.pin.mB.offset != 0 {
                    points.append(s0.pin.p)
//                }
                switch s0.direction {
                case .ab:
                    points.reverseAppend(m0: s0.pin.mA, m1: s1.pin.mA, points: pathA)
                case .ba:
                    points.directAppend(m0: s0.pin.mB, m1: s1.pin.mB, points: pathB)
                case .stop:
                    assertionFailure("Impossible")
                }
                
                s0 = s1
            } while s0.direction != .stop

            list.append(Path(unsafe: points))
            points.removeAll(keepingCapacity: true)
        }
        
        return Result(list: list)
    }
    
}
