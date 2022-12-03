//
//  Navigator.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

extension Navigator {

    mutating func nextIntersect() -> Stone {
        let n = visited.count
        for i in 0..<n {
            let s = pathB[i]
            guard !visited[s.pinId] else { continue }
            let t = s.pin.type
            
            if t == .into || t == .end_in || t == .false_out {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pin: s.pin, direction: .ba)
            }
        }
        
        return .empty
    }
    
    mutating func nextIntersect(stone: Stone) -> Stone {
        let n = visited.count
        switch stone.direction {
        case .ba:
            var b = stone.b
            var s = IndexStone.empty
            var isVisited = false
            var isOut = false
            repeat {
                b = (b + 1) % n
                s = pathB[b]
                isVisited = visited[s.pinId]
                visited[s.pinId] = true
                
                isOut = s.pin.type == .end_out || s.pin.type == .out
                
                assert(s.pin.type != .into || s.pin.type != .start_in || s.pin.type != .false_in)
            } while !isOut && !isVisited
            
            let dir: Direction = isVisited ? .stop : .ab
            
            return Stone(a: s.other, b: b, pin: s.pin, direction: dir)
        case .ab:
            var a = stone.a
            var s = IndexStone.empty
            var isVisited = false
            var isInto = false
            
            repeat {
                a = (a - 1 + n) % n
                s = pathA[a]
                isVisited = visited[s.pinId]
                visited[s.pinId] = true

                isInto = s.pin.type == .end_in || s.pin.type == .into
                
                assert(s.pin.type != .out || s.pin.type != .start_out || s.pin.type != .false_out)
            } while !isInto && !isVisited

            let dir: Direction = isVisited ? .stop : .ba
            
            return Stone(a: a, b: s.other, pin: s.pin, direction: dir)
        case .stop:
            assertionFailure("Impossible")
            return .empty
        }
    }

    
}
