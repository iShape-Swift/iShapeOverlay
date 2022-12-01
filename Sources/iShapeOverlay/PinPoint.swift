//
//  PinPoint.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

enum PinType: Int {
    case into       = 0
    case out        = 1
    case false_in   = 2
    case false_out  = 3
    case start_in   = 4
    case start_out  = 5
    case end_in     = 6
    case end_out    = 7
    case null       = 8
}

struct PinPoint {
    
    static let zero = PinPoint(p: .zero, type: .null, mA: .zero, mB: .zero)
    
    let p: IntPoint
    let type: PinType
    let mA: MileStone
    let mB: MileStone
    
    @inlinable
    init(p: IntPoint, type: PinType, mA: MileStone, mB: MileStone) {
        self.p = p
        self.type = type
        self.mA = mA
        self.mB = mB
    }
    
}

extension PinPoint: Equatable {

    @inlinable
    static func == (lhs: PinPoint, rhs: PinPoint) -> Bool {
        lhs.mA == rhs.mA && lhs.mB == rhs.mB
    }
}

