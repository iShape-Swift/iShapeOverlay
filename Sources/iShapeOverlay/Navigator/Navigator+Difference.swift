//
//  Navigator+Difference.swift
//  
//
//  Created by Nail Sharipov on 12.12.2022.
//

extension Navigator {

    mutating func nextDifference() -> Stone {

        let bMask = [.into, .end_in_same, .end_in_back, .false_out_same, .false_out_back].mask
        
        let n = visited.count
        for i in 0..<n {
            let s = pathB[i]
            guard !visited[s.pinId] else { continue }
            let t = s.pin.type
            
            if bMask.isContain(t) {
                visited[s.pinId] = true
                return Stone(a: s.other, b: i, pinId: s.pinId, pin: s.pin, direction: .pathB)
            }
        }
        
        return .empty
    }
    
    mutating func nextDifference(stone: Stone, endId: Int) -> Stone {
        let n = visited.count
        
        let aMask = [.out, .end_out_back, .end_out_same, .start_out_same, .start_out_back, .false_out_back].mask
        let bMask = [.into, .end_in_back, .end_in_same, .false_out_same].mask
        
        switch stone.direction {
        case .pathB:
            var b = stone.b
            var s = IndexStone.empty
            var isOut = false
            repeat {
                b = (b + 1) % n
                s = pathB[b]
                
                let t = s.pin.type

                if t != .false_out_back {
                    visited[s.pinId] = true
                }
                
                isOut = aMask.isContain(t)

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

            } while !isInto && stone.pinId != s.pinId && endId != s.pinId
            
            return Stone(a: a, b: s.other, pinId: s.pinId, pin: s.pin, direction: .pathB)
        }
    }

    
}
