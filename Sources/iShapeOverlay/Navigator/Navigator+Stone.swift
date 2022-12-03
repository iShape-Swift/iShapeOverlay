//
//  Stone.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Navigator {
    
    struct Stone {
        
        static let empty = Stone(a: -1, b: -1, pin: .zero, direction: .stop)
        
        let a: Int
        let b: Int
        let pin: PinPoint
        let direction: Direction
    }
}
