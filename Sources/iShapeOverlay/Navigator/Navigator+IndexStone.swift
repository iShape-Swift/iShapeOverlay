//
//  IndexStone.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Navigator {

    struct IndexStone {
        
        static let zero = IndexStone(pinId: 0, other: 0, point: .zero, type: .into, stone: .zero)
        
        let pinId: Int
        var other: Int
        let point: IntPoint
        let type: PinType
        let stone: MileStone
    }
}
