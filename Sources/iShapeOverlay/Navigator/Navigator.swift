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

        var aList = [IndexStone](repeating: .empty, count: n)
        var bList = [IndexStone](repeating: .empty, count: n)
        for i in 0..<n {
            let pin = pins[i]
            aList[i] = IndexStone(pinId: i, other: i, pin: pin)
            bList[i] = IndexStone(pinId: i, other: 0, pin: pin)
        }
        
        aList.sort(by: { $0.pin.a < $1.pin.a })
        
        for i in 0..<n {
            let b = aList[i].other
            bList[b].other = i
        }
        
        bList.sort(by: { $0.pin.b < $1.pin.b })
        
        for i in 0..<n {
            let a = bList[i].other
            aList[a].other = i
        }

        self.pathA = aList
        self.pathB = bList
        self.visited = [Bool](repeating: false, count: n)
    }
}
