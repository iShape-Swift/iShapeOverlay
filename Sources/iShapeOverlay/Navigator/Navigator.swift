//
//  Navigator.swift
//  
//
//  Created by Nail Sharipov on 02.12.2022.
//

struct Navigator {

    let pathA: [IndexStone]
    let pathB: [IndexStone]
    var visited: [Bool]
    
    init(pins: [PinPoint]) {
        let n = pins.count

        var aList = [IndexStone](repeating: .zero, count: n)
        var bList = [IndexStone](repeating: .zero, count: n)
        for i in 0..<n {
            let pin = pins[i]
            aList[i] = IndexStone(pinId: i, other: i, point: pin.p, type: pin.type, stone: pin.mA)
            bList[i] = IndexStone(pinId: i, other: 0, point: pin.p, type: pin.type, stone: pin.mB)
        }
        
        aList.sort(by: {
            if $0.stone == $1.stone {
                return $0.type.rawValue < $1.type.rawValue
            } else {
                return $0.stone < $1.stone
            }
        })
        
        for i in 0..<n {
            let b = aList[i].other
            bList[b].other = i
        }
        
        bList.sort(by: {
            if $0.stone == $1.stone {
                return $0.type.rawValue < $1.type.rawValue
            } else {
                return $0.stone < $1.stone
            }
        })
        
        for i in 0..<n {
            let a = bList[i].other
            aList[a].other = i
        }

        self.pathA = aList
        self.pathB = bList
        self.visited = [Bool](repeating: false, count: n)
    }
}
