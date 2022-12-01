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

#if DEBUG

extension PinType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .into:
            return "into"
        case .out:
            return "out"
        case .false_in:
            return "false_in"
        case .false_out:
            return "false_out"
        case .start_in:
            return "start_in"
        case .start_out:
            return "start_out"
        case .end_in:
            return "end_in"
        case .end_out:
            return "end_out"
        case .null:
            return "null"
        }
    }
    
}
#endif
