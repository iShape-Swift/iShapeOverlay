//
//  Navigator+Intersect.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

extension Navigator {

    mutating func nextIntersect() -> Stone {

        let aMask = [.out].mask
        
        let bMask = [.into, .end_in_same, .end_in_back, .false_out_same, .false_out_back, ].mask
        
        let n = visited.count
        for i in 0..<n {
            let s = pathB[i]
            guard !visited[s.pinId] else { continue }
            let t = s.pin.type

            if aMask.isContain(t) {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .pathA)
            }
            
            if bMask.isContain(t) {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .pathB)
            }
        }
        
        return .empty
    }
    
    mutating func nextIntersect(stone: Stone, endId: Int) -> Stone {
        let n = visited.count
        
        let aMask = [.out, .end_out_back, .end_out_same, .start_out_same, .start_out_back, .false_out_same].mask
        let bMask = [.into, .end_in_back, .end_in_same, .false_out_same].mask
        
        switch stone.direction {
        case .pathB:
            var b = stone.b
            var s = IndexStone.empty
            var isOut = false
            repeat {
                b = (b + 1) % n
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
                a = (a - 1 + n) % n
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
