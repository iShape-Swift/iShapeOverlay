//
//  PinSegment.swift
//  
//
//  Created by Nail Sharipov on 25.11.2022.
//

import iGeometry

struct PinSegment {
    
    enum Origin {
        case point
        case path
    }

    let type: PinType
    let origin: Origin
    
    let start: IntPoint
    let startA: MileStone
    let startB: MileStone

    let end: IntPoint
    let endA: MileStone
    let endB: MileStone
    
}
