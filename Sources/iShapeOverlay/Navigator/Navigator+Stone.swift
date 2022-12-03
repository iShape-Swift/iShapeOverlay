//
//  Stone.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Navigator {
    
    struct Stone {
        
        static let empty = Stone(a: -1, b: -1, p: .zero, m: .zero, direction: .ab)
        
        var isEmpty: Bool { a < 0 }
        
        let a: Int
        let b: Int
        let p: IntPoint
        let m: MileStone
        let direction: Direction
    }
}
