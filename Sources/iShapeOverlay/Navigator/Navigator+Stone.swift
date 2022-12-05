//
//  Stone.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Navigator {
    
    struct Stone {
        
        static let empty = Stone(a: 0, b: 0, pinId: -1, pin: .zero, direction: .ab)
        
        var isNotEmpty: Bool { pinId >= 0 }
        
        let a: Int
        let b: Int
        let pinId: Int
        let pin: PinPoint
        let direction: Direction
    }
}
