//
//  PinPoint.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

@usableFromInline
enum PinType: Int {
    case into               = 0
    case start_in_same      = 1
    case start_in_back      = 2
    case end_in_same        = 3
    case end_in_back        = 4
    case false_in_same      = 5
    case false_in_back      = 6
    case out                = 7
    case start_out_same     = 8
    case start_out_back     = 9
    case end_out_same       = 10
    case end_out_back       = 11
    case false_out_same     = 12
    case false_out_back     = 13
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

extension PinType {
    
    @inlinable
    var bit: Int {
        1 << rawValue
    }
}

extension Int {
    
    @inlinable
    func isContain(_ pinType: PinType) -> Bool {
        let bit = pinType.bit
        return self & bit == bit
    }
}

extension Array where Element == PinType {
    
    @inlinable
    var mask: Int {
        self.reduce(0, { $0 | $1.bit })
    }
}
