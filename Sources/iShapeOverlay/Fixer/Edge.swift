//
//  Edge.swift
//  
//
//  Created by Nail Sharipov on 09.11.2022.
//

import iGeometry

extension Fixer {
    
    struct Edge {
        
        let start: IntPoint
        let end: IntPoint
        
        @inlinable
        var sortIndex: Int64 {
            let a = start.bitPack
            let b = end.bitPack
            return min(a, b)
        }
        
    }
}
