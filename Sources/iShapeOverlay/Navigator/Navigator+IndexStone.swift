//
//  IndexStone.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

import iGeometry

extension Navigator {

    struct IndexStone {
        
        static let empty = IndexStone(pinId: -1, other: -1, pin: .zero)
        
        let pinId: Int
        var other: Int
        let pin: PinPoint
    }
}
