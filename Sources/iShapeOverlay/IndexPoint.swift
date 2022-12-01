//
//  IndexPoint.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

struct IndexPoint {
    
    static let zero = IndexPoint(index: 0, point: .zero)
    
    let index: Int
    let point: IntPoint
}
