//
//  PinPoint.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

enum PinType: Int {
    case into           = 0
    case start_in       = 1
    case end_in         = 2
    case false_in_same  = 3
    case false_in_back  = 4
    case out            = 5
    case start_out      = 6
    case end_out        = 7
    case false_out_same = 8
    case false_out_back = 9
}

struct PinPoint {
    
    static let zero = PinPoint(p: .zero, type: .into, a: .zero, b: .zero)
    
    let p: IntPoint
    let type: PinType
    let a: Int
    let b: Int
    
    @inlinable
    init(p: IntPoint, type: PinType, a: Int, b: Int) {
        self.p = p
        self.type = type
        self.a = a
        self.b = b
    }
    
}

extension PinPoint: Equatable {

    @inlinable
    static func == (lhs: PinPoint, rhs: PinPoint) -> Bool {
        lhs.a == rhs.a && lhs.b == rhs.b
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
        case .false_in_same:
            return "false_in_same"
        case .false_in_back:
            return "false_in_back"
        case .false_out_same:
            return "false_out_same"
        case .false_out_back:
            return "false_out_back"
        case .start_in:
            return "start_in"
        case .start_out:
            return "start_out"
        case .end_in:
            return "end_in"
        case .end_out:
            return "end_out"
        }
    }
    
}
#endif
