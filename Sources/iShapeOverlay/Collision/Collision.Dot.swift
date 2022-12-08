//
//  Collision+Dot.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

extension Collision {

    enum DotType {
        case simple
        case complex
    }
    
    struct Dot: Hashable {
        let mA: MileStone
        let mB: MileStone
        let t: DotType
        let p: IntPoint
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(mA.index)
            hasher.combine(mA.offset)
        }
        
        init(ed0: Collision.Edge, ed1: Collision.Edge, type: DotType, point: IntPoint) {
            assert(ed0.shapeId != ed1.shapeId)
            if ed0.shapeId == 0 {
                mA = MileStone(index: ed0.p0.index, offset: point.sqrDistance(point: ed0.p0.point))
                mB = MileStone(index: ed1.p0.index, offset: point.sqrDistance(point: ed1.p0.point))
            } else {
                mA = MileStone(index: ed1.p0.index, offset: point.sqrDistance(point: ed1.p0.point))
                mB = MileStone(index: ed0.p0.index, offset: point.sqrDistance(point: ed0.p0.point))
            }
            t = type
            p = point
        }
        
        init(mA: MileStone, mB: MileStone, type: DotType, point: IntPoint) {
            self.mA = mA
            self.mB = mB
            t = type
            p = point
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.t == rhs.t && lhs.mA == rhs.mA && lhs.mB == rhs.mB
        }
        
    }
    
}
