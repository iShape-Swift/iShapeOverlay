//
//  IntersectTests.swift
//  
//
//  Created by Nail Sharipov on 02.12.2022.
//

#if DEBUG

import iGeometry
import CoreGraphics

public final class IntersectTests {
    
    public static let data: [TestData] = [
        TestData(
            shapeA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ].int,
            shapeB: [
                CGPoint(x: -5, y: 15),
                CGPoint(x: -5, y:-15),
                CGPoint(x:  5, y:-15),
                CGPoint(x:  5, y: 15)
            ].int
        ),
        TestData(
            shapeA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ].int,
            shapeB: [
                CGPoint(x: -5, y: 15),
                CGPoint(x: -5, y:  0),
                CGPoint(x:  5, y:  0),
                CGPoint(x:  5, y: 15)
            ].int
        ),
        TestData(
            shapeA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ].int,
            shapeB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 5, y: 10),
                CGPoint(x: -5, y: 10)
            ].int
        )
    ]
}

#endif
