//
//  PinTests.swift
//  
//
//  Created by Nail Sharipov on 01.12.2022.
//
#if DEBUG

import iGeometry

public final class PinTests {
    
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
        ),
        // 1
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: -10, y: 5),
                Point(x: -10, y: -5)
            ].int
        ),
        // 2
        TestData(
                shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: -5, y: -10),
                Point(x: 5, y: -10)
            ].int
        ),
        // 3
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: 10, y: -5),
                Point(x: 10, y: 5)
            ].int
        ),
        // 4
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: 10, y: 10),
                Point(x: -10, y: 10)
            ].int
        ),
        // 5
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: -10, y: 10),
                Point(x: -10, y: -10)
            ].int
        ),
        // 6
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: -10, y: -10),
                Point(x: 10, y: -10)
            ].int
        ),
        // 7
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 0),
                Point(x: 10, y: -10),
                Point(x: 10, y: 10)
            ].int
        ),
        // 8
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 10, y: 5),
                Point(x: 10, y: 10),
                Point(x: -10, y: 10),
                Point(x: -10, y: 5)
            ].int
        ),
        // 9
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -5, y: 10),
                Point(x: -10, y: 10),
                Point(x: -10, y: -10),
                Point(x: -5, y: -10)
            ].int
        ),
        // 10
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -10, y: -5),
                Point(x: -10, y: -10),
                Point(x: 10, y: -10),
                Point(x: 10, y: -5)
            ].int
        ),
        // 11
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 5, y: -10),
                Point(x: 10, y: -10),
                Point(x: 10, y: 10),
                Point(x: 5, y: 10)
            ].int
        ),
        // 12
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 10, y: 0),
                Point(x: 10, y: 10),
                Point(x: 0, y: 10)
            ].int
        ),
        // 13
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 10),
                Point(x: -10, y: 10),
                Point(x: -10, y: 0)
            ].int
        ),
        // 14
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -10, y: 0),
                Point(x: -10, y: -10),
                Point(x: 0, y: -10)
            ].int
        ),
        // 15
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: -10),
                Point(x: 10, y: -10),
                Point(x: 10, y: 0)
            ].int
        ),
        // 16
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: 10),
                Point(x: -10, y: 10),
                Point(x: -10, y: -10),
                Point(x: 10, y: -10),
                Point(x: 10, y: 0)
            ].int
        ),
        // 17
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -10, y: 0),
                Point(x: -10, y: -10),
                Point(x: 10, y: -10),
                Point(x: 10, y: 10),
                Point(x: 0, y: 10)
            ].int
        ),
        // 18
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 0, y: -10),
                Point(x: 10, y: -10),
                Point(x: 10, y: 10),
                Point(x: -10, y: 10),
                Point(x: -10, y: 0)
            ].int
        ),
        // 19
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 10, y: 0),
                Point(x: 10, y: 10),
                Point(x: -10, y: 10),
                Point(x: -10, y: -10),
                Point(x: 0, y: -10)
            ].int
        ),
        // 20
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -5, y: 10),
                Point(x: -5, y: 20),
                Point(x: -15, y: 20),
                Point(x: -15, y: 10)
            ].int
        ),
        // 21
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -5, y: 0),
                Point(x: -5, y: 10),
                Point(x: -15, y: 10),
                Point(x: -15, y: 0)
            ].int
        ),
        // 22
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 15, y: 10),
                Point(x: 15, y: 20),
                Point(x: 5, y: 20),
                Point(x: 5, y: 10)
            ].int
        ),
        // 23
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 15, y: 0),
                Point(x: 15, y: 10),
                Point(x: 5, y: 10),
                Point(x: 5, y: 0)
            ].int
        ),
        // 24
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 10, y: 10),
                Point(x: 10, y: 20),
                Point(x: -10, y: 20),
                Point(x: -10, y: 10)
            ].int
        ),
        // 25
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 5, y: -10),
                Point(x: 5, y: 10),
                Point(x: -5, y: 10),
                Point(x: -5, y: -10)
            ].int
        ),
        // 26
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -10, y: 0),
                Point(x: -10, y: 10),
                Point(x: -20, y: 10),
                Point(x: -20, y: 0)
            ].int
        ),
        // 27
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: 0),
                Point(x: -10, y: 0)
            ].int,
            shapeB: [
                Point(x: -15, y: 30),
                Point(x: -15, y: -30),
//                Point(x: 11, y: -30),
//                Point(x: 9, y: 30)

                Point(x: 10 + IntGeom.defGeom.float(int: 1), y: -30),
                Point(x: 10 - IntGeom.defGeom.float(int: 1), y:  30)
            ].int
        ),
        // 28
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: -15, y: 30),
                Point(x: -15, y: -30),
                Point(x: 10 + IntGeom.defGeom.float(int: 1), y: -30),
                Point(x: 10 - IntGeom.defGeom.float(int: 1), y: 30)
            ].int
        ),
        // 29
        TestData(
            shapeA: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int,
            shapeB: [
                Point(x: 20, y: -5),
                Point(x: 20, y: 5),
                Point(x: 10, y: 5),
                Point(x: 10, y: 0),
                Point(x: 10, y: -5)
            ].int
        ),
        // 30
        TestData(
            shapeA: [
                Point(x: 20, y: -5),
                Point(x: 20, y: 5),
                Point(x: 10, y: 5),
                Point(x: 10, y: 0),
                Point(x: 10, y: -5)
            ].int,
            shapeB: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int
        ),
        // 31
        TestData(
            shapeA: [
                Point(x: 20, y: -5),
                Point(x: 20, y: 5),
                Point(x: 10, y: 5),
                Point(x: 10, y: 0),
                Point(x: 10, y: -5)
            ].int,
            shapeB: [
                Point(x: -10, y: 10),
                Point(x: 10, y: 10),
                Point(x: 10, y: 0),
                Point(x: 10, y: -10),
                Point(x: -10, y: -10)
            ].int
        ),
        // 32
        TestData(
            shapeA: [
                IntPoint(x: 4410, y: 2200),
                IntPoint(x: 4638, y: 2160),
                IntPoint(x: 12909, y: 0),

                IntPoint(x: -10000, y: 0),
                IntPoint(x: -10000, y: 10000),
                IntPoint(x: 4410, y: 10000)
            ].scale(value: 1),
            shapeB: [
                IntPoint(x: 6970, y: 15000),
                IntPoint(x: 0, y: 15000),
                IntPoint(x: 233, y: 2937),
                IntPoint(x: 6970, y: 1749),
            ].scale(value: 1)
        ),
        // 33
        TestData(
            shapeA: [
                IntPoint(x: 100000, y: 50000),
                IntPoint(x: 100000, y: 200000),
                IntPoint(x: -100000, y: 200000),
                IntPoint(x: -100000, y: -200000),
                IntPoint(x: 100000, y: -200000),
                IntPoint(x: 100000, y: -50000),
                IntPoint(x: 150000, y: -50000),
                IntPoint(x: 150000, y: -250000),
                IntPoint(x: -150000, y: -250000),
                IntPoint(x: -150000, y: 250000),
                IntPoint(x: 150000, y: 250000),
                IntPoint(x: 150000, y: 50000)
            ].scale(value: 1),
            shapeB: [
                IntPoint(x: -200000, y: 50000),
                IntPoint(x: -200000, y: -50000),
                IntPoint(x: 200000, y: -50000),
                IntPoint(x: 200000, y: 50000)
            ].scale(value: 1)
        ),
        // 34
        TestData(
            shapeA: [
                IntPoint(x: 0, y: 100000),
                IntPoint(x: 200000, y: 100000),
                IntPoint(x: 200000, y: -100000),
                IntPoint(x: 0, y: -100000)
            ].scale(value: 1),
            shapeB: [
                IntPoint(x: -200000, y: -100000),
                IntPoint(x: 100000, y: -100000),
                IntPoint(x: 200000, y: 100000)
            ].scale(value: 1)
        ),
        // 35
        TestData(
            shapeA: [
                IntPoint(x: -18, y: -7),
                IntPoint(x: -18, y: -6848),
                IntPoint(x: -10000, y: -6848),
                IntPoint(x: -10000, y: 10000),
                IntPoint(x: 5000, y: 10000),
                IntPoint(x: 4450, y: 5515),
                IntPoint(x: -18, y: 134)
            ].scale(value: 10),
            shapeB: [
                IntPoint(x: 19379, y: -3004),
                IntPoint(x: 17040, y: 3424),
                IntPoint(x: 11116, y: 6844),
                IntPoint(x: 4379, y: 5656),

                IntPoint(x: -18, y: 416),
                IntPoint(x: -18, y: -6424),
                IntPoint(x: 4379, y: -11664),
                IntPoint(x: 11116, y: -12852),
                IntPoint(x: 17040, y: -9432)
            ].scale(value: 10)
        ),
        // 36
        TestData(
            shapeA: [
                IntPoint(x: -10066, y: 10168),
                IntPoint(x: -10032, y: 10188),
                IntPoint(x: -7692, y: 16615),
                IntPoint(x: -5000, y: 20000),
                IntPoint(x: -5000, y: 10310),
                IntPoint(x: -9264, y: 10310)
            ].scale(value: 1),
            shapeB: [
                IntPoint(x: -7615, y: 16615),
                IntPoint(x: -15879, y: 16615),
                IntPoint(x: -15879, y: 6767),
                IntPoint(x: -9955, y: 10188)
            ].scale(value: 1)
        )
    ]

}

#endif
