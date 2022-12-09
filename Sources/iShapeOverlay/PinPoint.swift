//
//  PinPoint.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

enum PinType {
    case into
    case start_in_same
    case start_in_back
    case end_in_same
    case end_in_back
    case false_in_same
    case false_in_back
    case out
    case start_out_same
    case start_out_back
    case end_out_same
    case end_out_back
    case false_out_same
    case false_out_back
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
        case .start_in_same:
            return "start_in_same"
        case .start_in_back:
            return "start_in_back"
        case .start_out_same:
            return "start_out_same"
        case .start_out_back:
            return "start_out_back"
        case .end_in_same:
            return "end_in_same"
        case .end_in_back:
            return "end_in_back"
        case .end_out_same:
            return "end_out_same"
        case .end_out_back:
            return "end_out_back"
        }
    }
    
}
#endif
