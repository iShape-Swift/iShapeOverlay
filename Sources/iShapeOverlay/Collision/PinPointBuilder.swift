//
//  PinPointBuilder.swift
//  
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry

struct PinPointBuilder {

//    @inlinable
//    func buildSimple(cross: IntPoint, edge0: CrossDetector.Edge, edge1: CrossDetector.Edge) -> PinPoint {
//        let edgeA: CrossDetector.Edge
//        let edgeB: CrossDetector.Edge
//
//        if edge0.shapeId == 0 {
//            edgeA = edge0
//            edgeB = edge1
//        } else {
//            edgeA = edge1
//            edgeB = edge0
//        }
//
//        let isCCW = self.isCCW(a: edgeA.p1.point, b: cross, c: edgeA.p1.point)
//        let type: PinType = isCCW ? .outside : .inside
//
//        let mA = MileStone(index: edgeA.p0.index, offset: edgeA.p0.point.sqrDistance(point: cross))
//        let mB = MileStone(index: edgeB.p0.index, offset: edgeB.p0.point.sqrDistance(point: cross))
//
//        return PinPoint(p: cross, type: type, mA: mA, mB: mB)
//    }
 
//    @inlinable
//    func buildOnSide(cross: IntPoint, edge0: CrossDetector.Edge, edge1: CrossDetector.Edge) -> PinPoint {
//        let edgeA: CrossDetector.Edge
//        let edgeB: CrossDetector.Edge
//
//        if edge0.shapeId == 0 {
//            edgeA = edge0
//            edgeB = edge1
//        } else {
//            edgeA = edge1
//            edgeB = edge0
//        }
//
//        let corner = Corner(o: cross, a: edgeA.p0.point, b: edgeA.p1.point)
//        
//        let s0 = corner.isBetween(p: edgeB.p0.point, clockwise: true)
//        let s1 = corner.isBetween(p: edgeB.p1.point, clockwise: true)
//        
//        let type: PinType
//        
//        if s0 == .onBoarder || s1 == .onBoarder {
//            if s0 == .onBoarder && s1 == .onBoarder {
//                type = .null
//            } else if s0 != .onBoarder {
//                type = s0 == .contain ? .inside : .outside
//            } else {
//                type = s1 == .contain ? .outside : .inside
//            }
//        } else {
//            let isSl0 = s0 == .contain
//            let isSl1 = s1 == .contain
//            
//            if isSl0 && isSl1 {
//                type = .in_out
//            } else if !isSl0 && !isSl1 {
//                type = .out_in
//            } else {
//                type = isSl0 ? .inside : .outside
//            }
//        }
//        
//        let mA: MileStone
//        let mB: MileStone
//        
//        if edgeA.p1.point != cross {
//            mA = MileStone(index: edgeA.p0.index, offset: edgeA.p0.point.sqrDistance(point: cross))
//        } else {
//            mA = MileStone(index: edgeA.p1.index)
//        }
//
//        if edgeB.p1.point != cross {
//            mB = MileStone(index: edgeB.p0.index, offset: edgeB.p0.point.sqrDistance(point: cross))
//        } else {
//            mB = MileStone(index: edgeB.p1.index)
//        }
//
//        return PinPoint(p: cross, type: type, mA: mA, mB: mB)
//    }
//    
//    private func isCCW(a: IntPoint, b: IntPoint, c: IntPoint) -> Bool {
//        let m0 = (c.y - a.y) * (b.x - a.x)
//        let m1 = (b.y - a.y) * (c.x - a.x)
//
//        return m0 < m1
//    }
}
