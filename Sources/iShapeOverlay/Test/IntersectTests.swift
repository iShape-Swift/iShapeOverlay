//
//  IntersectTests.swift
//  
//
//  Created by Nail Sharipov on 02.12.2022.
//

#if DEBUG

import iGeometry

public final class IntersectTests {
    
    public static let data: [TestData] = [
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: 5, y: 10),
                Point(x: -5, y: 10)
            ].int
        )
    ]
}

#endif
