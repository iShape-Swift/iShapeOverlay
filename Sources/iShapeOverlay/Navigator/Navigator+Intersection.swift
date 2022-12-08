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
            
            if t == .into || t == .end_in || t == .false_out_back {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .ba)
            } else if t == .start_out_same || t == .start_out_back || t == .out {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .ab)
            }
        }
        
        return .empty
    }
    
    mutating func nextIntersect(stone: Stone, endId: Int) -> Stone {
        let n = visited.count
        switch stone.direction {
        case .ba:
            var b = stone.b
            var s = IndexStone.empty
            var isOut = false
            repeat {
                b = (b + 1) % n
                s = pathB[b]
                visited[s.pinId] = true
                
                let t = s.pin.type
                
                isOut = t == .end_out || t == .out || t == .start_out_same || t == .start_out_back || t == .false_out_same
                
                assert(t != .into || t != .start_in_same || t != .false_in_same || t != .false_in_back)
            } while !isOut && stone.pinId != s.pinId && endId != s.pinId
            
            return Stone(a: s.other, b: b, pinId: s.pinId, pin: s.pin, direction: .ab)
        case .ab:
            var a = stone.a
            var s = IndexStone.empty
            var isInto = false
            
            repeat {
                a = (a - 1 + n) % n
                s = pathA[a]
                visited[s.pinId] = true
                
                let t = s.pin.type
                
                isInto = t == .end_in || t == .into || t == .false_out_same
                
                assert(t != .out || t != .start_out_same || t != .false_out_same  || t != .false_out_back)
            } while !isInto && stone.pinId != s.pinId
            
            return Stone(a: a, b: s.other, pinId: s.pinId, pin: s.pin, direction: .ba)
        }
    }

    
}
