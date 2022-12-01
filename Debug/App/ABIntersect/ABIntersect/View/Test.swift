//
//  Test.swift
//  ABIntersect
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry
import DebugUtil
import CoreGraphics

struct TestData {
    
    let shapeA: [IntPoint]
    let shapeB: [IntPoint]
    
}

final class Test {

    private let index = PersistInt(key: "TestIndex")
    
    var current: TestData {
        let i = index.value % data.count
        return data[i]
    }

    func next() {
        _ = index.increase(amount: 1, round: data.count)
    }
    
    private let data: [TestData] = [
        TestData (
            shapeA: [
                IntPoint(point: CGPoint(x: -100, y:    0)),
                IntPoint(point: CGPoint(x:  100, y:    0)),
                IntPoint(point: CGPoint(x:  100, y: -100)),
                IntPoint(point: CGPoint(x: -100, y: -100))
            ],
            shapeB: [
                IntPoint(point: CGPoint(x: -50, y:    50)),
                IntPoint(point: CGPoint(x: -50, y:   -50)),
                IntPoint(point: CGPoint(x:  50, y:  -50)),
                IntPoint(point: CGPoint(x:  50, y:   50))
            ]
        ),
        TestData (
            shapeA: [
                IntPoint(point: CGPoint(x: -100, y:    0)),
                IntPoint(point: CGPoint(x:  100, y:    0)),
                IntPoint(point: CGPoint(x:  100, y: -100)),
                IntPoint(point: CGPoint(x: -100, y: -100))
            ],
            shapeB: [
                IntPoint(point: CGPoint(x: -50, y:     0)),
                IntPoint(point: CGPoint(x: -50, y:   -50)),
                IntPoint(point: CGPoint(x:  50, y:   -50)),
                IntPoint(point: CGPoint(x:  50, y:    50))
            ]
        )
    ]

}
