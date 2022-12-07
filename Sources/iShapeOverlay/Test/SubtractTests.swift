//
//  SubtractTests.swift
//  
//
//  Created by Nail Sharipov on 03.12.2022.
//

#if DEBUG

import iGeometry

public final class SubtractTests {
    
    public static let data: [TestData] = [
        // 0
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 5.0, y: -15.0),
                Point(x: 5.0, y: 0.0),
                Point(x: -5.0, y: 0.0),
                Point(x: -5.0, y: -15.0)
            ].int
        ),
        
        // 1
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: -15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: -5.0, y: 15.0)
            ].int
        ),
        // 2
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: -15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: -5.0, y: 10.0)
            ].int
        ),
        // 3
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: -10.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: -5.0, y: 10.0)
            ].int
        ),
        // 4
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: -10.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: -10.0, y: 10.0)
            ].int
        ),
        // 5
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: -10.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: -20.0, y: 10.0)
            ].int
        ),
        // 6
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: -15.0, y: 0.0)
            ].int
        ),
        // 7
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: -15.0),
                Point(x: 0.0, y: 0.0),
                Point(x: -15.0, y: 0.0)
            ].int
        ),
        // 8
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 0.0, y: 10.0)
            ].int
        ),
        // 9
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: -10.0),
                Point(x: 5.0, y: -10.0),
                Point(x: 0.0, y: 10.0)
            ].int
        ),
        // 10
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 5.0),
                Point(x: 0.0, y: -10.0),
                Point(x: 10.0, y: 10.0)
            ].int
        ),
        // 11
        TestData(
            shapeA: [
                Point(x: 0.0, y: 10.0),
                Point(x: 20.0, y: 10.0),
                Point(x: 20.0, y: -10.0),
                Point(x: 0.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -20.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 20.0, y: 10.0)
            ].int
        ),
        // 12
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 10.0, y: -5.0),
                Point(x: 10.0, y: 5.0)
            ].int
        ),
        // 13
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 5.0, y: -10.0),
                Point(x: -5.0, y: -10.0),
                Point(x: 0.0, y: -15.0)
            ].int
        ),
        // 14
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 10.0),
                Point(x: -10.0, y: 5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -5.0, y: -10.0),
                Point(x: 5.0, y: -10.0),
                Point(x: 10.0, y: -5.0),
                Point(x: 10.0, y: 5.0),
                Point(x: 5.0, y: 10.0)
            ].int
        ),
        // 15
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 0.0, y: 10.0),
                Point(x: 0.0, y: 0.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 10.0),
                Point(x: 0.0, y: -5.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 5.0, y: 10.0)
            ].int
        ),
        // 16
        TestData(
            shapeA: [
                Point(x: -5.0, y: 0.0),
                Point(x: 5.0, y: 0.0),
                Point(x: 0.0, y: -5.0),
                Point(x: -5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -10.0, y: 10.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -5.0, y: -5.0),
                Point(x: -5.0, y: 5.0),
                Point(x: 5.0, y: 5.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 10.0, y: -5.0),
                Point(x: 10.0, y: 10.0)
            ].int
        ),
        // 17
        TestData(
            shapeA: [
                Point(x: -10.0, y: 5.0),
                Point(x: 10.0, y: 5.0),
                Point(x: 10.0, y: -5.0),
                Point(x: -10.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 10.0),
                Point(x: -5.0, y: -5.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 5.0, y: -10.0),
                Point(x: 15.0, y: -10.0),
                Point(x: 15.0, y: 10.0)
            ].int
        ),
        // 18
        TestData(
            shapeA: [
                Point(x: -10.0, y: 5.0),
                Point(x: 10.0, y: 5.0),
                Point(x: 10.0, y: -5.0),
                Point(x: -10.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 10.0),
                Point(x: -5.0, y: -5.0),
                Point(x: 10.0, y: -5.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 15.0, y: 0.0),
                Point(x: 15.0, y: 10.0)
            ].int
        ),
        // 19
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 5.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 0.0, y: -10.0),
                Point(x: 0.0, y: -15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 5.0)
            ].int
        ),
        // 20
        TestData(
            shapeA: [
                Point(x: -10.0, y: 5.0),
                Point(x: 10.0, y: 5.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 5.0),
                Point(x: 5.0, y: 5.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 15.0, y: -5.0),
                Point(x: 15.0, y: 10.0),
                Point(x: -15.0, y: 10.0),
                Point(x: -15.0, y: -5.0),
                Point(x: -5.0, y: -5.0)
            ].int
        ),
        // 21
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 10.0, y: 0.0),
                Point(x: 0.0, y: 5.0),
                Point(x: 0.0, y: -5.0)
            ].int
        ),
        // 22
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 10.0, y: 10.0),
                Point(x: 0.0, y: 5.0),
                Point(x: 5.0, y: 0.0)
            ].int
        ),
        // 23
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 5.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 10.0, y: -5.0),
                Point(x: 15.0, y: 5.0)
            ].int
        ),
        // 24
        TestData(
            shapeA: [
                Point(x: -5.0, y: 0.0),
                Point(x: 5.0, y: 0.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -10.0, y: 10.0),
                Point(x: -10.0, y: -10.0),
                Point(x: 0.0, y: -10.0),
                Point(x: 0.0, y: 5.0),
                Point(x: 5.0, y: 5.0),
                Point(x: 5.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 10.0)
            ].int
        ),
        // 25
        TestData(
            shapeA: [
                Point(x: 5.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: -5.0),
                Point(x: 5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -10.0, y: 10.0),
                Point(x: -10.0, y: 5.0),
                Point(x: 5.0, y: 5.0),
                Point(x: 5.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 10.0)
            ].int
        ),
        // 26
        TestData(
            shapeA: [
                Point(x: 5.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: -5.0),
                Point(x: 5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 5.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 15.0, y: -5.0),
                Point(x: 15.0, y: 5.0)
            ].int
        ),
        // 27
        TestData(
            shapeA: [
                Point(x: 5.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: -5.0),
                Point(x: 5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 5.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 25.0, y: 0.0),
                Point(x: 15.0, y: 5.0)
            ].int
        ),
        // 28
        TestData(
            shapeA: [
                Point(x: 5.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: -5.0),
                Point(x: 5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: 5.0, y: 15.0),
                Point(x: 5.0, y: -10.0),
                Point(x: 15.0, y: -10.0),
                Point(x: 15.0, y: 5.0)
            ].int
        ),
        // 29
        TestData(
            shapeA: [
                Point(x: 5.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: -5.0),
                Point(x: 5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -10.0, y: 0.0),
                Point(x: -10.0, y: -10.0),
                Point(x: 5.0, y: -5.0),
                Point(x: 10.0, y: 0.0)
            ].int
        ),
        // 30
        TestData(
            shapeA: [
                Point(x: 5.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: -5.0),
                Point(x: 5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: -5.0, y: 5.0),
                Point(x: -20.0, y: -10.0),
                Point(x: 15.0, y: -10.0),
                Point(x: 18.0, y: 16.5)
            ].int
        ),
        // 31
        TestData(
            shapeA: [
                Point(x: 5.0, y: 10.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: 10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 0.0, y: 0.0)
            ].int
        ),
        // 32
        TestData(
            shapeA: [
                Point(x: 5.0, y: 10.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -2.0, y: 2.0),
                Point(x: 2.0, y: 6.0),
                Point(x: -2.0, y: 10.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 0.0, y: 0.0)
            ].int
        ),
        // 33
        TestData(
            shapeA: [
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 5.0),
                Point(x: -20.0, y: 5.0),
                Point(x: -20.0, y: -15.0),
                Point(x: 10.0, y: -15.0),
                Point(x: 10.0, y: 20.0),
                Point(x: -20.0, y: 20.0),
                Point(x: -20.0, y: 10.0),
                Point(x: 5.0, y: 10.0),
                Point(x: 5.0, y: -10.0),
                Point(x: -15.0, y: -10.0),
                Point(x: -15.0, y: 0.0),
                Point(x: 0.0, y: 0.0)
            ].int
        ),
        // 34
        TestData(
            shapeA: [
                Point(x: -18.5, y: -3.5),
                Point(x: -15.0, y: 10.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -10.0, y: 7.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 5.0),
                Point(x: -20.0, y: 5.0),
                Point(x: -20.0, y: -15.0),
                Point(x: 10.0, y: -15.0),
                Point(x: 10.0, y: 20.0),
                Point(x: -20.0, y: 20.0),
                Point(x: -20.0, y: 10.0),
                Point(x: 5.0, y: 10.0),
                Point(x: 5.0, y: -10.0),
                Point(x: -15.0, y: -10.0),
                Point(x: -15.0, y: 0.0),
                Point(x: 0.0, y: 0.0)
            ].int
        ),
        // 35
        TestData(
            shapeA: [
                Point(x: -5.0, y: 15.0),
                Point(x: 0.0, y: 15.0),
                Point(x: 0.0, y: 3.0),
                Point(x: -5.0, y: 3.0)
            ].int,
            shapeB: [
                Point(x: 5.0, y: 5.0),
                Point(x: -15.0, y: 5.0),
                Point(x: -15.0, y: -15.0),
                Point(x: 15.0, y: -15.0),
                Point(x: 15.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0),
                Point(x: -10.0, y: 0.0),
                Point(x: 5.0, y: 0.0)
            ].int
        ),
        // 36
        TestData(
            shapeA: [
                Point(x: -7.5, y: 10.0),
                Point(x: 12.5, y: 10.0),
                Point(x: 12.5, y: 5.0),
                Point(x: -7.5, y: 5.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 37
        TestData(
            shapeA: [
                Point(x: -7.5, y: 2.5),
                Point(x: 12.5, y: 2.5),
                Point(x: 12.5, y: -2.5),
                Point(x: -7.5, y: -2.5)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 38
        TestData(
            shapeA: [
                Point(x: -10.0, y: 15.0),
                Point(x: 10.0, y: 15.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -11.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 39
        TestData(
            shapeA: [
                Point(x: -10.0, y: 15.0),
                Point(x: 10.0, y: 15.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -14.0, y: -4.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 40
        TestData(
            shapeA: [
                Point(x: -23.0, y: 20.0),
                Point(x: 7.0, y: 20.0),
                Point(x: 7.0, y: -16.0),
                Point(x: -20.0, y: -15.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 41
        TestData(
            shapeA: [
                Point(x: -23.0, y: 20.0),
                Point(x: 7.0, y: 20.0),
                Point(x: 4.0, y: -16.0),
                Point(x: -20.0, y: -15.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 42
        TestData(
            shapeA: [
                Point(x: -20.0, y: -15.0),
                Point(x: 12.0, y: -5.0),
                Point(x: 15.0, y: -9.0),
                Point(x: -15.0, y: -15.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -14.0),
                Point(x: -20.0, y: -14.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 43
        TestData(
            shapeA: [
                Point(x: -5.0, y: 0.0),
                Point(x: 10.0, y: 0.0),
                Point(x: 10.0, y: 10.0),
                Point(x: -10.0, y: 10.0),
                Point(x: -10.0, y: -10.0),
                Point(x: 15.0, y: -10.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -15.0, y: -15.0),
                Point(x: -15.0, y: 15.0),
                Point(x: 15.0, y: 15.0),
                Point(x: 15.0, y: -5.0),
                Point(x: -5.0, y: -5.0)
            ].int,
            shapeB: [
                Point(x: 0.0, y: 0.0),
                Point(x: 0.0, y: 20.0),
                Point(x: -15.0, y: 20.0),
                Point(x: -15.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 30.0),
                Point(x: -25.0, y: 30.0),
                Point(x: -25.0, y: -20.0),
                Point(x: 20.0, y: -20.0),
                Point(x: 20.0, y: 20.0),
                Point(x: 15.0, y: 20.0),
                Point(x: 15.0, y: -15.0),
                Point(x: -20.0, y: -15.0),
                Point(x: -20.0, y: 25.0),
                Point(x: 5.0, y: 25.0),
                Point(x: 5.0, y: -5.0),
                Point(x: -10.0, y: -5.0),
                Point(x: -10.0, y: 15.0),
                Point(x: -5.0, y: 15.0),
                Point(x: -5.0, y: 0.0)
            ].int
        ),
        // 44
        TestData(
            shapeA: [
                Point(x: -10.0, y: 10.0),
                Point(x: 10.0, y: 10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: -10.0, y: -10.0)
            ].int,
            shapeB: [
                Point(x: -10.0, y: 10.0),
                Point(x: -10.0, y: -10.0),
                Point(x: 10.0, y: -10.0),
                Point(x: 10.0, y: 10.0)
            ].int
        ),
        // 45
        TestData(
            shapeA: [
                Point(x: 1, y: -0.0001),
                Point(x: 0, y: 0.9999),
                Point(x: -1, y: -0.0001),
                Point(x: -3, y:  -0.0001),
                Point(x: -3, y:  2.9999),
                Point(x: 3, y:  2.9999),
                Point(x: 3, y:  -0.0001)
            ].int,
            shapeB: [
                Point(x: 1, y: 0),
                Point(x: 0, y: 1),
                Point(x: -1, y: 0),
                Point(x: 0, y: -1)
            ].int
        ),
        // 46
        TestData(
            shapeA: [
                IntPoint(x: 20173, y: -7262),
                IntPoint(x: 19201, y: -7433),
                IntPoint(x: 17047, y: -10000),
                IntPoint(x: -30000, y: -10000),
                IntPoint(x: -30000, y: 40000),
                IntPoint(x: 30000, y: 40000),
                IntPoint(x: 30000, y: -5388),
                IntPoint(x: 23624, y: -6512),
                IntPoint(x: 23617, y: -6520),
                IntPoint(x: 23317, y: -6573),
                IntPoint(x: 23299, y: -6595),
                IntPoint(x: 23071, y: -6635),
                IntPoint(x: 23054, y: -6656),
                IntPoint(x: 22826, y: -6696),
                IntPoint(x: 22798, y: -6729),
                IntPoint(x: 22641, y: -6757),
                IntPoint(x: 22602, y: -6804),
                IntPoint(x: 22518, y: -6819),
                IntPoint(x: 20430, y: -7187),
                IntPoint(x: 20412, y: -7209),
                IntPoint(x: 20184, y: -7249)
            ].scale(value: 1),
            shapeB: [
                IntPoint(x: 34140, y: -16093),
                IntPoint(x: 31800, y: -9665),
                IntPoint(x: 25877, y: -6245),
                IntPoint(x: 19140, y: -7433),
                IntPoint(x: 14743, y: -12673),
                IntPoint(x: 14743, y: -19514),
                IntPoint(x: 19140, y: -24754),
                IntPoint(x: 25877, y: -25941),
                IntPoint(x: 31800, y: -22521)
            ].scale(value: 1)
        ),
        // 47
        TestData(
            shapeA: [
                IntPoint(x: -2000, y:  1000),
                IntPoint(x:  -109, y:    19),
                IntPoint(x:     0, y:     0),
                IntPoint(x:     0, y: -1000),
                IntPoint(x: -2000, y: -1000),
           ].scale(value: 1),
            shapeB: [
                IntPoint(x:     0, y: 3000),
                IntPoint(x: -1296, y:  228),
                IntPoint(x:  5441, y: -959)
            ].scale(value: 1)
       ),
        // 48
        TestData(
            shapeA: [
                IntPoint(x:  667, y:   2515),
                IntPoint(x:   668, y:  2517),
                IntPoint(x:   667, y:  2515),
                IntPoint(x:  -109, y:    19),
                IntPoint(x:     0, y: -1000),
                IntPoint(x: -2000, y: -1000),
                IntPoint(x: -1095, y:   193),
           ].scale(value: 1),
            shapeB: [
               IntPoint(x:     0, y: 3000),
               IntPoint(x: -1296, y:  228),
               IntPoint(x: -1095, y:  193),
               IntPoint(x:  -109, y:   19),
               IntPoint(x:     0, y:    0),
               IntPoint(x:  5441, y: -959),
               IntPoint(x:   667, y: 2515)
            ].scale(value: 1)
        ),
        // 49
        TestData(
            shapeA: [
                IntPoint(x:   -73, y:  1931),
                IntPoint(x:  -109, y:    19),
                IntPoint(x:     0, y:     0),
                IntPoint(x:     0, y: -1000),
                IntPoint(x: -2000, y: -1000),
           ].scale(value: 1),
            shapeB: [
                IntPoint(x:     0, y: 3000),
                IntPoint(x: -1296, y:  228),
                IntPoint(x:  5441, y: -959)
            ].scale(value: 1)
       )
    ]

}

#endif
