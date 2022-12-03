//
//  MileStone.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

#if DEBUG
import iGeometry
#endif

@usableFromInline
struct MileStone: Equatable, Hashable {
    
    static let zero = MileStone(index: 0)
    static let empty = MileStone(index: -1)

    @usableFromInline
    let index: Int
    @usableFromInline
    let offset: Int64
    
    #if DEBUG
    let off: Float
    #endif
    
    init(index: Int, offset: Int64 = 0) {
        self.index = index
        self.offset = offset
#if DEBUG
        self.off = IntGeom.defGeom.float(int: Int64(Double(offset).squareRoot()))
#endif
    }
    
    public static func < (lhs: MileStone, rhs: MileStone) -> Bool {
        if lhs.index != rhs.index {
            return lhs.index < rhs.index
        }

        return lhs.offset < rhs.offset
    }
    
    public static func > (lhs: MileStone, rhs: MileStone) -> Bool {
        if lhs.index != rhs.index {
            return lhs.index > rhs.index
        }

        return lhs.offset > rhs.offset
    }
    
    public static func >= (lhs: MileStone, rhs: MileStone) -> Bool {
        if lhs.index != rhs.index {
            return lhs.index > rhs.index
        }

        return lhs.offset >= rhs.offset
    }
    
    public static func == (lhs: MileStone, rhs: MileStone) -> Bool {
        return lhs.index == rhs.index && lhs.offset == rhs.offset
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(index)
        hasher.combine(offset)
    }
}

#if DEBUG
extension MileStone: CustomStringConvertible {
    
    public var description: String {
        "(\(index), \(off))"
    }
    
}
#endif
