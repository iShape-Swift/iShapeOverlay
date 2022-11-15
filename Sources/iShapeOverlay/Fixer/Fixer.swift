//
//  Fixer+Solve.swift
//  
//
//  Created by Nail Sharipov on 09.11.2022.
//

import iGeometry

struct Fixer {

    @inlinable
    func solve(path: [IntPoint]) -> [[IntPoint]] {
        let edges = self.devide(path: path)

        return Linker(edges: edges).join()
    }
    
    private func devide(path: [IntPoint]) -> [Edge] {
        var edges = path.edges()
        
        var events = edges.events
        
        var scanList = [Int]()
        scanList.reserveCapacity(16)

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
                    let crossResult = thisEdge.cross(other: otherEdge)
                    
                    switch crossResult.type {
                    case .not_cross, .end_a0_b0, .end_a0_b1, .end_a1_b0, .end_a1_b1, .same_line:
                        j += 1
                    case .pure:
                        let cross = crossResult.point

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
        
        return edges
    }
    
    private struct DivideResult {
        let leftPart: Fixer.Edge
        let rightPart: Fixer.Edge
        let removeEvent: Fixer.Event
        let addEvent: Fixer.Event
    }
    
    private func devide(edge: Fixer.Edge, id: Int, cross: IntPoint, nextId: Int) -> DivideResult {
        let bitPack = cross.bitPack
        
        let leftPart = Fixer.Edge(start: edge.start, end: cross)
        let rightPart = Fixer.Edge(start: cross, end: edge.end)
        
        let evRemove = Event(sortValue: bitPack, action: .remove, edgeId: nextId)
        let evAdd = Event(sortValue: bitPack, action: .add, edgeId: id)

        return DivideResult(
            leftPart: leftPart,
            rightPart: rightPart,
            removeEvent: evRemove,
            addEvent: evAdd
        )
    }
}

private extension Array where Element == Fixer.Edge {

    var events: [Fixer.Event] {
        var result = [Fixer.Event]()
        let capacity = 2 * (count + 4)
        result.reserveCapacity(capacity)
        
        for i in 0..<count {
            let edge = self[i]
            
            result.append(Fixer.Event(sortValue: edge.end.bitPack, action: .remove, edgeId: i))
            result.append(Fixer.Event(sortValue: edge.start.bitPack, action: .add, edgeId: i))
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

// Binary search for reversed array
private extension Array where Element == Fixer.Event {

    /// Find index of first element equal original or first element bigger then original if no exact elements is present
    /// - Parameters:
    ///   - value: original element
    ///   - start: from where to start (mostly it's index of a)
    /// - Returns: index of lower boundary
    func lowerBoundary(value a: Int64, index: Int) -> Int {
        let last = count - 1
        var i = index
        if i > last {
            i = last
        } else if i < 0 {
            i = 0
        }
        var x = self[i].sortValue

        while i > 0 && x <= a  {
            i -= 1
            x = self[i].sortValue
        }
        
        while i < last && x > a  {
            i += 1
            x = self[i].sortValue
        }
        
        if x > a {
            i += 1
        }
        
        return i
    }
    
    /// Find index of first element bigger then original
    /// - Parameters:
    ///   - value: original element
    ///   - start: from where to start (mostly it's index of a)
    /// - Returns: index of upper boundary
    func upperBoundary(value a: Int64, index: Int) -> Int {
        let last = count - 1
        var i = index
        if i > last {
            i = last
        } else if i < 0 {
            i = 0
        }
        var x = self[i].sortValue

        while i > 0 && x < a  {
            i -= 1
            x = self[i].sortValue
        }

        while i < last && x >= a  {
            i += 1
            x = self[i].sortValue
        }
        
        if x >= a {
            i += 1
        }
        
        return i
    }

    
    /// Find index of element. If element is not found return index where it must be
    /// - Parameters:
    ///   - start: from where to start (mostly it's index of a)
    ///   - value: target element
    /// - Returns: index of element
    func findIndexAnyResult(value a: Int64) -> Int {
        var left = 0
        var right = count - 1

        var j = -1
        var i = left
        var x = self[i].sortValue
        
        while i != j {
            if x < a {
                right = i - 1
            } else if x > a {
                left = i + 1
            } else {
                return i
            }
            
            j = i
            i = (left + right) / 2

            x = self[i].sortValue
        }
        
        if x > a {
            i = i + 1
        }

        return i
    }

}

private extension Array where Element == IntPoint {
    
    func edges() -> [Fixer.Edge] {
        var a = self[count - 1]
        var result = [Fixer.Edge]()
        result.reserveCapacity(count + 4)

        var start = a.bitPack

        for b in self {
            let end = b.bitPack
            
            if start > end {
                result.append(Fixer.Edge(start: b, end: a))
            } else if start < end {
                result.append(Fixer.Edge(start: a, end: b))
            } // skip degenerate dots

            start = end
            a = b
        }
        
        return result
    }
}
