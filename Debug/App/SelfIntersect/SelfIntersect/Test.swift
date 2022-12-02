//
//  Test.swift
//  SelfIntersect
//
//  Created by Nail Sharipov on 09.11.2022.
//

import iGeometry
import DebugUtil
import CoreGraphics

final class Test {

    private let index = PersistInt(key: "TestIndex")
    
    var current: [IntPoint] {
        let i = index.value % data.count
        return data[i]
    }

    func next() {
        _ = index.increase(amount: 1, round: data.count)
    }
    
    init() {
        index.value = 0
    }
    
    private let data: [[IntPoint]] = [
        [
            IntPoint(point: CGPoint(x: -150, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y:  100)),
            IntPoint(point: CGPoint(x:   50, y: -100)),
            IntPoint(point: CGPoint(x: -150, y: -100)),
            IntPoint(point: CGPoint(x:   25, y:  -50)),
            IntPoint(point: CGPoint(x: -150, y:    0)),
            IntPoint(point: CGPoint(x:  -25, y:   50))
        ],
        [
            IntPoint(point: CGPoint(x: -150, y:  100)),
            IntPoint(point: CGPoint(x:   50, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y: -100)),
            IntPoint(point: CGPoint(x: -150, y: -100)),
            IntPoint(point: CGPoint(x:  -25, y:  -50)),
            IntPoint(point: CGPoint(x: -150, y:    0)),
            IntPoint(point: CGPoint(x:   25, y:   50))
        ],
        [
            IntPoint(point: CGPoint(x:   50, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y: -100)),
            IntPoint(point: CGPoint(x: -125, y: -100)),
            IntPoint(point: CGPoint(x:   75, y:    0)),
            IntPoint(point: CGPoint(x: -150, y:    0))
        ],
        [
            IntPoint(point: CGPoint(x: -100, y:   50)),
            IntPoint(point: CGPoint(x:  150, y:  -75)),
            IntPoint(point: CGPoint(x:   25, y:  -75)),
            IntPoint(point: CGPoint(x:   75, y:   25)),
            IntPoint(point: CGPoint(x: -150, y:  -50))
        ],
        [
            IntPoint(point: CGPoint(x: -100, y:    0)),
            IntPoint(point: CGPoint(x:    0, y:  100)),
            IntPoint(point: CGPoint(x:  100, y:    0)),
            IntPoint(point: CGPoint(x:    0, y: -100))
        ],
        [
            IntPoint(point: CGPoint(x: -100, y:  100)),
            IntPoint(point: CGPoint(x:  100, y:  100)),
            IntPoint(point: CGPoint(x: -100, y: -100)),
            IntPoint(point: CGPoint(x:  100, y: -100))
        ],
        [
            IntPoint(point: CGPoint(x:  100, y: -100)),
            IntPoint(point: CGPoint(x:  100, y:  100)),
            IntPoint(point: CGPoint(x: -100, y:  100)),
            IntPoint(point: CGPoint(x:  100, y:    0))
        ],
        [
            IntPoint(point: CGPoint(x:  100, y: -100)),
            IntPoint(point: CGPoint(x:  100, y:  100)),
            IntPoint(point: CGPoint(x: -100, y: -100)),
            IntPoint(point: CGPoint(x: -100, y:  100))
        ],
        [
            IntPoint(point: CGPoint(x: -150, y:    0)),
            IntPoint(point: CGPoint(x:  150, y:    0)),
            IntPoint(point: CGPoint(x:  150, y: -100)),
            IntPoint(point: CGPoint(x:   50, y:    0)),
            IntPoint(point: CGPoint(x:   50, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y: -100)),
            IntPoint(point: CGPoint(x: -150, y: -100)),
        ],
        [
            IntPoint(point: CGPoint(x: -150, y:  -150)),
            IntPoint(point: CGPoint(x:  100, y:   100)),
            IntPoint(point: CGPoint(x:  150, y:  -150)),
            IntPoint(point: CGPoint(x: -250, y:    50)),
            IntPoint(point: CGPoint(x:  250, y:    50))
        ],
        [
            IntPoint(point: CGPoint(x: -150, y:  -150)),
            IntPoint(point: CGPoint(x: -150, y:     0)),
            IntPoint(point: CGPoint(x: -150, y:   150)),
            IntPoint(point: CGPoint(x: -150, y:   150)),
            IntPoint(point: CGPoint(x:    0, y:   150)),
            IntPoint(point: CGPoint(x:  150, y:   150))
        ],
        [
            IntPoint(point: CGPoint(x: -150, y:  100)),
            IntPoint(point: CGPoint(x:    0, y:  -50)),
            IntPoint(point: CGPoint(x:  150, y:  100)),
            IntPoint(point: CGPoint(x:  150, y: -100)),
            IntPoint(point: CGPoint(x:    0, y:   50)),
            IntPoint(point: CGPoint(x: -150, y: -100))
        ],
        [
            IntPoint(point: CGPoint(x: -150, y:    0)),
            IntPoint(point: CGPoint(x:  150, y:    0)),
            IntPoint(point: CGPoint(x:  150, y: -100)),
            IntPoint(point: CGPoint(x:   50, y: -100)),
            IntPoint(point: CGPoint(x:   50, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y:  100)),
            IntPoint(point: CGPoint(x:  -50, y: -100)),
            IntPoint(point: CGPoint(x: -150, y: -100)),
        ],
        [
            IntPoint(point: CGPoint(x:    0, y:   50)),
            IntPoint(point: CGPoint(x:    0, y:  -50)),
            IntPoint(point: CGPoint(x:   50, y:  -50)),
            IntPoint(point: CGPoint(x:   50, y:  100)),
            IntPoint(point: CGPoint(x: -100, y:  100)),
            IntPoint(point: CGPoint(x: -100, y:    0)),
            IntPoint(point: CGPoint(x:  100, y:    0)),
            IntPoint(point: CGPoint(x:  100, y: -100)),
            IntPoint(point: CGPoint(x:  -50, y: -100)),
            IntPoint(point: CGPoint(x:  -50, y:   50))
        ],
        
//        Test.circle(radius: 100, count: 9).map({ IntPoint(point: $0) }),
        [
            IntPoint(point: CGPoint(x: -100, y: -100)),
            IntPoint(point: CGPoint(x: -100, y:  100)),
            IntPoint(point: CGPoint(x:  100, y:  100)),
            IntPoint(point: CGPoint(x:  100, y: -100))
        ]
    ]

    private static func circle(radius r: CGFloat, count n: Int, offset: CGPoint = .zero, angle: CGFloat = 0) -> [CGPoint] {
        let da = 2 * CGFloat.pi / CGFloat(n)
        var result = [CGPoint](repeating: .zero, count: n)
        var a: CGFloat = angle
        for i in 0..<n {
            result[i] = CGPoint(
                x: r * cos(a) + offset.x,
                y: r * sin(a) + offset.y
            )
            a -= da
        }
        return result
    }
}
