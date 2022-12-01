//
//  CrossDetector.swift
//  
//
//  Created by Nail Sharipov on 23.11.2022.
//

import iGeometry

private typealias Edge = Collision.Edge
private typealias Dot = Collision.Dot

extension Collision {
    struct Detector {}
}

extension Collision.Detector {

    func findPins(pathA: [IntPoint], pathB: [IntPoint]) -> [PinPoint] {
        let composition = self.composition(pathA: pathA, pathB: pathB)
        let result = composition.pins(pathA: pathA, pathB: pathB)
        return result
    }
        
    private func composition(pathA: [IntPoint], pathB: [IntPoint]) -> Collision.Composition {
        let edgesA = pathA.edges(id: 0)
        let edgesB = pathB.edges(id: 1)
        var edges = [Edge]()
        edges.append(contentsOf: edgesA)
        edges.append(contentsOf: edgesB)

        var events = edges.events
        
        var scanList = [Int]()
        scanList.reserveCapacity(16)

        var composition = Collision.Composition()
        
        while !events.isEmpty {
            let event = events.removeLast()

            switch event.action {
            case .add:
                
                var thisId = event.edgeId
                var thisEdge = edges[thisId]
                var newScanId = thisId
                
                // try to cross with the scan list
                var j = 0
                while j < scanList.count {
                    let otherId = scanList[j]
                    let otherEdge = edges[otherId]
                    
                    guard otherEdge.shapeId != thisEdge.shapeId else {
                        j += 1
                        continue
                    }
                    
                    let crossResult = thisEdge.cross(other: otherEdge)
                    
                    switch crossResult.type {
                    case .not_cross:
                        j += 1
                    case .same_line:
                        composition.addSameLine(edge0: thisEdge, edge1: otherEdge)
                        j += 1
                    case .end_a0_b0, .end_a0_b1, .end_a1_b0, .end_a1_b1:
                        let cross = crossResult.point

                        composition.addCommon(edge0: thisEdge, edge1: otherEdge, point: cross)
                        
                        j += 1
                    case .pure:
                        let cross = crossResult.point

                        composition.addPure(edge0: thisEdge, edge1: otherEdge, point: cross)
                        
                        // devide edges
                        
                        // for this edge
                        // create new left part (new edge id), put 'remove' event
                        // update right part (keep old edge id), put 'add' event
                        
                        let thisNewId = edges.count
                        let thisResult = self.devide(edge: thisEdge, id: thisId, cross: cross, nextId: thisNewId)
                        
                        edges.append(thisResult.leftPart)
                        thisEdge = thisResult.leftPart
                        edges[thisId] = thisResult.rightPart    // update old edge (right part)
                        thisId = thisNewId                      // we are now left part with new id

                        newScanId = thisNewId
                        
                        // for other(scan) edge
                        // create new left part (new edge id), put 'remove' event
                        // update right part (keep old edge id), put 'add' event
                        
                        let otherNewId = edges.count
                        let otherResult = self.devide(edge: otherEdge, id: otherId, cross: cross, nextId: otherNewId)
                        
                        edges.append(otherResult.leftPart)
                        edges[otherId] = otherResult.rightPart

                        scanList[j] = otherNewId
                        
                        // insert events

                        let bitPack = cross.bitPack
                        
                        let index = events.findIndexAnyResult(value: bitPack)
                        
                        var evIndex = events.lowerBoundary(value: bitPack, index: index)
                        events.insert(thisResult.removeEvent, at: evIndex)
                        evIndex += 1
                        events.insert(otherResult.removeEvent, at: evIndex)
                        evIndex += 1
                        
                        evIndex = events.upperBoundary(value: bitPack, index: evIndex)
                        events.insert(thisResult.addEvent, at: evIndex)
                        evIndex += 1
                        events.insert(otherResult.addEvent, at: evIndex)

                        j += 1
                    case .end_b0, .end_b1:
                        let cross = crossResult.point

                        composition.addCommon(edge0: thisEdge, edge1: otherEdge, point: cross)
                        
                        // devide this edge
                        
                        // create new left part (new edge id), put 'remove' event
                        // update right part (keep old edge id), put 'add' event
                        
                        let thisNewId = edges.count
                        let thisResult = self.devide(edge: thisEdge, id: thisId, cross: cross, nextId: thisNewId)
                        
                        thisEdge = thisResult.leftPart
                        edges.append(thisResult.leftPart)
                        edges[thisId] = thisResult.rightPart    // update old edge (right part)
                        thisId = thisNewId                      // we are now left part with new id
                        
                        newScanId = thisNewId
                        
                        // insert events

                        let bitPack = cross.bitPack
                        
                        let index = events.findIndexAnyResult(value: bitPack)
                        
                        var evIndex = events.lowerBoundary(value: bitPack, index: index)
                        events.insert(thisResult.removeEvent, at: evIndex)
                        evIndex += 1
                        
                        evIndex = events.upperBoundary(value: bitPack, index: evIndex)
                        events.insert(thisResult.addEvent, at: evIndex)

                        j += 1
                    case .end_a0, .end_a1:
                        let cross = crossResult.point
                        
                        composition.addCommon(edge0: thisEdge, edge1: otherEdge, point: cross)
                        
                        // devide other(scan) edge

                        // create new left part (new edge id), put 'remove' event
                        // update right part (keep old edge id), put 'add' event

                        let otherNewId = edges.count
                        let otherResult = self.devide(edge: otherEdge, id: otherId, cross: cross, nextId: otherNewId)
                        
                        edges.append(otherResult.leftPart)
                        edges[otherId] = otherResult.rightPart
                        
                        scanList[j] = otherNewId
                        
                        // insert events

                        let bitPack = cross.bitPack
                        
                        let index = events.findIndexAnyResult(value: bitPack)
                        
                        var evIndex = events.lowerBoundary(value: bitPack, index: index)
                        events.insert(otherResult.removeEvent, at: evIndex)
                        evIndex += 1
                        
                        evIndex = events.upperBoundary(value: bitPack, index: evIndex)
                        events.insert(otherResult.addEvent, at: evIndex)
                        
                        j += 1
                    }
                } // while scanList
                
                scanList.append(newScanId)

            case .remove:
                // scan list is sorted
                if let index = scanList.firstIndex(of: event.edgeId) { // it must be one of the first elements
                    scanList.remove(at: index)
                } else {
                    assertionFailure("impossible")
                }
            } // switch
            
            #if DEBUG
            let set = Set(scanList)
            assert(set.count == scanList.count)
            #endif

        } // while

        return composition
    }

    private struct DivideResult {
        let leftPart: Edge
        let rightPart: Edge
        let removeEvent: SwipeLineEvent
        let addEvent: SwipeLineEvent
    }
    
    private func devide(edge: Edge, id: Int, cross: IntPoint, nextId: Int) -> DivideResult {
        let bitPack = cross.bitPack
        
        let leftPart = Edge(parent: edge, start: edge.start, end: cross)
        let rightPart = Edge(parent: edge, start: cross, end: edge.end)
        
        let evRemove = SwipeLineEvent(sortValue: bitPack, action: .remove, edgeId: nextId)
        let evAdd = SwipeLineEvent(sortValue: bitPack, action: .add, edgeId: id)

        return DivideResult(
            leftPart: leftPart,
            rightPart: rightPart,
            removeEvent: evRemove,
            addEvent: evAdd
        )
    }
    
}

private extension Array where Element == IntPoint {
    
    func edges(id: Int) -> [Edge] {
        let n = count
        var i = n - 1
        var a = IndexPoint(index: i, point: self[i])
        var result = [Edge]()
        result.reserveCapacity(n)

        var start = a.point.bitPack
        i = 0
        while i < n {
            let b = IndexPoint(index: i, point: self[i])
            let end = b.point.bitPack
            
            if start > end {
                result.append(Edge(shapeId: id, start: b.point, end: a.point, p0: a, p1: b))
            } else if start < end {
                result.append(Edge(shapeId: id, start: a.point, end: b.point, p0: a, p1: b))
            } // skip degenerate dots

            start = end
            a = b
            i += 1
        }
        
        return result
    }
}

private extension Array where Element == Edge {

    var events: [SwipeLineEvent] {
        var result = [SwipeLineEvent]()
        let capacity = 2 * (count + 4)
        result.reserveCapacity(capacity)
        
        for i in 0..<count {
            let edge = self[i]
            
            result.append(SwipeLineEvent(sortValue: edge.end.bitPack, action: .remove, edgeId: i))
            result.append(SwipeLineEvent(sortValue: edge.start.bitPack, action: .add, edgeId: i))
        }
     
        result.sort(by: {
            if $0.sortValue != $1.sortValue {
                return $0.sortValue > $1.sortValue
            } else {
                let a = $0.action.rawValue
                let b = $1.action.rawValue
                return a < b
            }
        })
        
        return result
    }
    
}
