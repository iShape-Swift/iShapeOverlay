//
//  Navigator.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

extension Navigator {

    mutating func nextIntersect() -> Stone {
        let n = pathA.count
        for i in 0..<n {
            let st = pathA[i]
            guard !visited[st.pinId] else { continue }
            let t = st.type
            
            if t == .into || t == .end_in || t == .false_out {
                visited[st.pinId] = true
                return Stone(a: i, b: st.other, p: .zero, m: st.stone, direction: .ba)
            }
        }
        
        return .empty
    }
    
    mutating func nextIntersect(stone: Stone) -> Stone {
        let n = visited.count
        switch stone.direction {
        case .ab:
            var b = 0
            var s = IndexStone.zero
            var isNotVisited = true
            
            repeat {
                b = (stone.b + 1) % n
                s = pathB[b]
                isNotVisited = !visited[s.pinId]
                visited[s.pinId] = true
                
                assert(s.type != .out || s.type != .start_out || s.type != .false_out)
            } while (s.type != .end_in || s.type != .into) && isNotVisited
            
            if visited[s.pinId] {
                return .empty
            } else {
                return Stone(a: s.other, b: b, p: s.point, m: s.stone, direction: .ba)
            }
        case .ba:
            var a = 0
            var s = IndexStone.zero
            var isNotVisited = true
            
            repeat {
                a = (stone.a + 1) % n
                s = pathA[a]
                isNotVisited = !visited[s.pinId]
                visited[s.pinId] = true
                
                assert(s.type != .into || s.type != .start_in || s.type != .false_in)
            } while (s.type != .end_out || s.type != .out) && isNotVisited
            
            if visited[s.pinId] {
                return .empty
            } else {
                return Stone(a: a, b: s.other, p: s.point, m: s.stone, direction: .ab)
            }
        }
    }

    
}
