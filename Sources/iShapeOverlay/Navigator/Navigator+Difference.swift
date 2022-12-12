//
//  Navigator+Difference.swift
//  
//
//  Created by Nail Sharipov on 12.12.2022.
//

extension Navigator {

    mutating func nextDifference() -> Stone {
        let n = visited.count
        for i in 0..<n {
            let s = pathB[i]
            guard !visited[s.pinId] else { continue }
            let t = s.pin.type
            
            if t == .into || t == .end_in_same || t == .end_in_back || t == .false_out_same || t == .false_out_back {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .ba)
            }
        }
        
        return .empty
    }
    
    mutating func nextDifference(stone: Stone, endId: Int) -> Stone {
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
                
                isOut = t == .end_out_back || t == .end_out_same || t == .out || t == .start_out_same || t == .start_out_back
                
                assert(t != .into || t != .start_in_same || t != .false_in_same || t != .false_in_back)
            } while !isOut && stone.pinId != s.pinId && endId != s.pinId
            
            return Stone(a: s.other, b: b, pinId: s.pinId, pin: s.pin, direction: .ab)
        case .ab:
            var a = stone.a
            var s = IndexStone.empty
            var isInto = false
            
            repeat {
                a = (a + 1) % n
                s = pathA[a]
                visited[s.pinId] = true
                
                let t = s.pin.type
                
                isInto = t == .end_in_back || t == .end_in_same || t == .into || t == .false_out_same
                
                assert(t != .out || t != .start_out_same || t != .false_out_same  || t != .false_out_back)
            } while !isInto && stone.pinId != s.pinId
            
            return Stone(a: a, b: s.other, pinId: s.pinId, pin: s.pin, direction: .ba)
        }
    }

    
}
