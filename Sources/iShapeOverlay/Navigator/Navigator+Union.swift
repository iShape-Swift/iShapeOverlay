//
//  Union.swift
//  
//
//  Created by Nail Sharipov on 13.12.2022.
//

extension Navigator {
    
    mutating func nextUnion() -> Stone {
        
        let aMask = [.out, .end_out_back, .end_out_same, .start_out_back, .false_out_back].mask
        
        let n = visited.count
        for i in 0..<n {
            let s = pathB[i]
            guard !visited[s.pinId] else { continue }
            let t = s.pin.type
            
            if aMask.isContain(t) {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .pathA)
            }
        }
        
        return .empty
    }
    
    mutating func nextUnion(stone: Stone, endId: Int) -> Stone {
        let n = visited.count
        
        let aMask = [.out, .end_out_back, .end_out_same, .false_out_back].mask
        let bMask = [.into, .end_in_same, .start_in_back, .start_in_same].mask
        
        switch stone.direction {
        case .pathB:
            var b = stone.b
            var s = IndexStone.empty
            var isOut = false
            repeat {
                b = (b - 1 + n) % n
                s = pathB[b]
                visited[s.pinId] = true
                
                let t = s.pin.type
                
                isOut = aMask.isContain(t)
                
                assert(t != .into || t != .start_in_same || t != .false_in_same || t != .false_in_back)
            } while !isOut && stone.pinId != s.pinId && endId != s.pinId
            
            return Stone(a: s.other, b: b, pinId: s.pinId, pin: s.pin, direction: .pathA)
        case .pathA:
            var a = stone.a
            var s = IndexStone.empty
            var isInto = false
            
            repeat {
                a = (a + 1) % n
                s = pathA[a]
                visited[s.pinId] = true
                
                let t = s.pin.type
                
                isInto = bMask.isContain(t)
                
                assert(t != .out || t != .start_out_same || t != .false_out_same  || t != .false_out_back)
            } while !isInto && stone.pinId != s.pinId && endId != s.pinId
            
            return Stone(a: a, b: s.other, pinId: s.pinId, pin: s.pin, direction: .pathB)
        }
    }

    
}
