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
    
    enum PinResult {
        case success
        case modified
        case badPolygons
        case conflict
    }
    
    struct PinBundle {
        let pinResult: PinResult
        let pathA: [[IntPoint]]
        let pathB: [[IntPoint]]
        let pins: [PinPoint]
    }
    
    struct Detector {}
}

extension Collision.Detector {
    
    func findPins(pathA: [IntPoint], pathB: [IntPoint], shapeCleaner: ShapeCleaner) -> Collision.PinBundle {
        guard pathA.count > 2 && pathB.count > 2 else {
            return .init(pinResult: .badPolygons, pathA: [], pathB: [], pins: [])
        }
        
        let fixer = Fixer()
        
        var pathA = pathA
        var pathB = pathB
        var isAnyModified = false
        var isModified = false
        
        var composition = Collision.Composition(countA: 0, countB: 0)
       
        repeat {
            isModified = false
            composition = self.composition(pathA: pathA, pathB: pathB)
            let result = composition.eliminateConflictDots(pathA: pathA, pathB: pathB)

            if result.updateA.isModified || result.updateB.isModified {
                isModified = true
                isAnyModified = true
                
                let listA: [[IntPoint]]
                let listB: [[IntPoint]]

                if result.updateA.isModified {
                    let list = fixer.solve(path: result.updateA.path, removeSameLine: false)
                    listA = shapeCleaner.clean(list: list)
                } else {
                    listA = [pathA]
                }

                if result.updateB.isModified {
                    let list = fixer.solve(path: result.updateB.path, clockWise: false, removeSameLine: false)
                    listB = shapeCleaner.clean(list: list)
                } else {
                    listB = [pathB]
                }
                
                if listA.count == 1 && listB.count == 1 {
                    pathA = listA[0]
                    pathB = listB[0]
                } else if listA.isEmpty || listB.isEmpty {
                    return Collision.PinBundle(pinResult: .modified, pathA: listA, pathB: listB, pins: [])
                } else {
                    return Collision.PinBundle(pinResult: .conflict, pathA: listA, pathB: listB, pins: [])
                }
            }
        } while isModified
        
        let pins = composition.pins(pathA: pathA, pathB: pathB)
        
        let pinResult: Collision.PinResult = isAnyModified ? .modified : .success
        
        return Collision.PinBundle(pinResult: pinResult, pathA: [pathA], pathB: [pathB], pins: pins)
        
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

        var composition = Collision.Composition(countA: pathA.count, countB: pathB.count)
        
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

                        let index = events.findIndexAnyResult(value: thisResult.removeEvent.sortValue)
                        
                        let remEvIndex0 = events.lowerBoundary(value: thisResult.removeEvent.sortValue, index: index)
                        events.insert(thisResult.removeEvent, at: remEvIndex0)

                        let remEvIndex1 = events.lowerBoundary(value: otherResult.removeEvent.sortValue, index: index)
                        events.insert(otherResult.removeEvent, at: remEvIndex1)

                        let addEvIndex0 = events.upperBoundary(value: thisResult.addEvent.sortValue, index: index)
                        events.insert(thisResult.addEvent, at: addEvIndex0)

                        let addEvIndex1 = events.upperBoundary(value: otherResult.addEvent.sortValue, index: index)
                        events.insert(otherResult.addEvent, at: addEvIndex1)

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
                        
                        let index = events.findIndexAnyResult(value: thisResult.removeEvent.sortValue)
                        
                        let remEvIndex = events.lowerBoundary(value: thisResult.removeEvent.sortValue, index: index)
                        events.insert(thisResult.removeEvent, at: remEvIndex)
                        
                        let addEvIndex = events.upperBoundary(value: thisResult.addEvent.sortValue, index: index)
                        events.insert(thisResult.addEvent, at: addEvIndex)

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

                        let index = events.findIndexAnyResult(value: otherResult.removeEvent.sortValue)
                        
                        let remEvIndex = events.lowerBoundary(value: otherResult.removeEvent.sortValue, index: index)
                        events.insert(otherResult.removeEvent, at: remEvIndex)
                        
                        let addEvIndex = events.upperBoundary(value: otherResult.addEvent.sortValue, index: index)
                        events.insert(otherResult.addEvent, at: addEvIndex)
                        
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
        let leftPart = Edge(parent: edge, a: edge.start, b: cross)
        let rightPart = Edge(parent: edge, a: cross, b: edge.end)

#if DEBUG
        // left
        let evRemove = SwipeLineEvent(sortValue: leftPart.end.bitPack, action: .remove, edgeId: nextId, point: leftPart.end)
        // right
        let evAdd = SwipeLineEvent(sortValue: rightPart.start.bitPack, action: .add, edgeId: id, point: rightPart.start)
#else
        // left
        let evRemove = SwipeLineEvent(sortValue: leftPart.end.bitPack, action: .remove, edgeId: nextId)
        // right
        let evAdd = SwipeLineEvent(sortValue: rightPart.start.bitPack, action: .add, edgeId: id)
#endif

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
            
#if DEBUG
            result.append(SwipeLineEvent(sortValue: edge.end.bitPack, action: .remove, edgeId: i, point: edge.end))
            result.append(SwipeLineEvent(sortValue: edge.start.bitPack, action: .add, edgeId: i, point: edge.start))
#else
            result.append(SwipeLineEvent(sortValue: edge.end.bitPack, action: .remove, edgeId: i))
            result.append(SwipeLineEvent(sortValue: edge.start.bitPack, action: .add, edgeId: i))
#endif
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
