//
//  DifferenceUnitTests.swift
//  
//
//  Created by Nail Sharipov on 12.12.2022.
//

import XCTest
import iGeometry
@testable import iShapeOverlay


final class DifferenceUnitTests: XCTestCase {
    
    private let solver = SimpleSolver()
    private let detector = Collision.Detector()
    private let fixer = Fixer()
    
    private struct Result {
        let pinResult: Collision.PinResult
        let regions: [[IntPath]]
    }
    
    private let results: [Result] = [
        // 0
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(10.0, 10.0), CGPoint(10.0, -10.0), CGPoint(5.0, -10.0), CGPoint(5.0, 0.0), CGPoint(-5.0, 0.0)
                ].int)
            ]]
        ),
        // 1
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(-5.0, 10.0)
                ].int)
            ]]
        ),
        // 2
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(-5.0, 10.0)
                ].int)
            ]]
        ),
        // 3
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(-5.0, 10.0)
                ].int)
            ]]
        ),
        // 4
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0)
                ].int)
            ]]
        ),
        // 5
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(0.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 0.0)
                ].int)
            ]]
        ),
        // 6
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, -2.5)
                ].int),
                IntPath(unsafe: [
                    CGPoint(5.0, 10.0), CGPoint(-10.0, 2.5), CGPoint(-10.0, 10.0)
                ].int)
            ]]
        ),
        // 7
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, -5.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(0.0, 0.0), CGPoint(-10.0, 0.0), CGPoint(-10.0, 10.0), CGPoint(10.0, 10.0), CGPoint(10.0, -10.0), CGPoint(0.0, -10.0)
                ].int)
            ]]
        ),
        // 8
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 10.0)
                ].int)
            ]]
        ),
        // 9
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, -10.0), CGPoint(0.0, 10.0), CGPoint(10.0, 10.0), CGPoint(10.0, -10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(0.0, 10.0)
                ].int)
            ]]
        ),
        // 10
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(0.0, -10.0), CGPoint(-5.0, 5.0), CGPoint(10.0, 10.0)
                ].int)
            ]]
        ),
        // 11
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, -10.0), CGPoint(20.0, 10.0), CGPoint(20.0, -10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(20.0, 10.0), CGPoint(0.0, 0.0), CGPoint(0.0, 10.0)
                ].int)
            ]]
        ),
        // 12
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(10.0, 10.0), CGPoint(10.0, 5.0), CGPoint(0.0, 0.0), CGPoint(10.0, -5.0)
                ].int)
            ]]
        ),
        // 13
        Result(
            pinResult: .modified,
            regions: []
        ),
        // 14
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, -10.0), CGPoint(5.0, -10.0), CGPoint(10.0, -5.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(10.0, 5.0), CGPoint(5.0, 10.0), CGPoint(10.0, 10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, 10.0), CGPoint(-10.0, 5.0), CGPoint(-10.0, 10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, -5.0)
                ].int)
            ]]
        ),
        // 15
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(0.0, 10.0), CGPoint(0.0, -5.0), CGPoint(5.0, -5.0), CGPoint(5.0, 0.0), CGPoint(10.0, 0.0)
                ].int)
            ]]
        ),
        // 16
        Result(
            pinResult: .modified,
            regions: []
        ),
        // 17
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 5.0), CGPoint(-5.0, 5.0)
                ].int)
            ]]
        ),
        // 18
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 5.0), CGPoint(-5.0, 5.0)
                ].int)
            ]]
        ),
        // 19
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(10.0, 10.0), CGPoint(10.0, 5.0), CGPoint(0.0, 5.0), CGPoint(10.0, 0.0), CGPoint(10.0, -10.0)
                ].int)
            ]]
        ),
        // 20
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, -5.0), CGPoint(-5.0, -5.0), CGPoint(-5.0, 5.0), CGPoint(5.0, 5.0), CGPoint(5.0, -5.0), CGPoint(10.0, -5.0)
                ].int)
            ]]
        ),
        // 21
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, 0.0), CGPoint(0.0, -5.0), CGPoint(0.0, 5.0)
                ].int)
            ]]
        ),
        // 22
        Result(
            pinResult: .success,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, 0.0), CGPoint(0.0, 5.0), CGPoint(10.0, 10.0)
                ].int)
            ]]
        ),
        // 23
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(10.0, -10.0), CGPoint(-10.0, -10.0), CGPoint(-10.0, 10.0), CGPoint(10.0, 10.0), CGPoint(10.0, 5.0), CGPoint(0.0, 5.0), CGPoint(10.0, 0.0)
                ].int)
            ]]
        ),
        // 24
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, -5.0), CGPoint(0.0, -5.0), CGPoint(0.0, 0.0), CGPoint(5.0, 0.0)
                ].int)
            ]]
        ),
        // 25
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -5.0), CGPoint(5.0, -5.0), CGPoint(5.0, -10.0), CGPoint(10.0, -10.0), CGPoint(10.0, 10.0), CGPoint(5.0, 10.0), CGPoint(5.0, 15.0), CGPoint(15.0, 15.0)
                ].int)
            ]]
        ),
        // 26
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -5.0), CGPoint(15.0, -5.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(15.0, 5.0), CGPoint(5.0, 5.0), CGPoint(5.0, 15.0), CGPoint(15.0, 15.0)
                ].int)
            ]]
        ),
        // 27
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -5.0), CGPoint(5.0, -5.0), CGPoint(15.0, -2.5)
                ].int),
                IntPath(unsafe: [
                    CGPoint(15.0, 5.0), CGPoint(5.0, 5.0), CGPoint(5.0, 15.0), CGPoint(15.0, 15.0)
                ].int)
            ]]
        ),
        // 28
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, 5.0), CGPoint(5.0, 15.0), CGPoint(15.0, 15.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -5.0), CGPoint(5.0, -5.0), CGPoint(5.0, -10.0), CGPoint(15.0, -10.0)
                ].int)
            ]]
        ),
        // 29
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, -10.0), CGPoint(5.0, -5.0), CGPoint(10.0, 0.0), CGPoint(5.0, 0.0), CGPoint(5.0, 15.0), CGPoint(15.0, 15.0)
                ].int)
            ]]
        ),
        // 30
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -10.0), CGPoint(15.0, -10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(15.0, 15.0), CGPoint(5.0, 10.0), CGPoint(5.0, 15.0)
                ].int)
            ]]
        ),
        // 31
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 10.0), CGPoint(5.0, 10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, 5.0), CGPoint(-10.0, 10.0), CGPoint(-5.0, 10.0)
                ].int)
            ]]
        ),
        // 32
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 4.0), CGPoint(2.0, 6.0), CGPoint(0.0, 8.0), CGPoint(0.0, 10.0), CGPoint(5.0, 10.0)
                ].int)
            ]]
        ),
        // 33
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-5.0, 5.0), CGPoint(-10.0, 5.0), CGPoint(-10.0, 10.0), CGPoint(-5.0, 10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 0.0), CGPoint(-5.0, 0.0)
                ].int)
            ]]
        ),
        // 34
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-11.619, 5.0), CGPoint(-16.296300000000002, 5.0), CGPoint(-15.0, 10.0), CGPoint(-8.125, 10.0), CGPoint(-10.0, 7.0)
                ].int)
            ]]
        ),
        // 35
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(0.0, 5.0), CGPoint(-5.0, 5.0), CGPoint(-5.0, 10.0), CGPoint(0.0, 10.0)
                ].int)
            ]]
        ),
        // 36
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, 5.0), CGPoint(0.0, 5.0), CGPoint(0.0, 10.0), CGPoint(5.0, 10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, 5.0), CGPoint(-7.5, 5.0), CGPoint(-7.5, 10.0), CGPoint(-5.0, 10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(12.5, 5.0), CGPoint(10.0, 5.0), CGPoint(10.0, 10.0), CGPoint(12.5, 10.0)
                ].int)
            ]]
        ),
        // 37
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, -2.5), CGPoint(-7.5, -2.5), CGPoint(-7.5, 2.5), CGPoint(-5.0, 2.5), CGPoint(-5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 2.5), CGPoint(5.0, 2.5)
                ].int),
                IntPath(unsafe: [
                    CGPoint(12.5, -2.5), CGPoint(10.0, -2.5), CGPoint(10.0, 2.5), CGPoint(12.5, 2.5)
                ].int)
            ]]
        ),
        // 38
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 15.0), CGPoint(-5.0, 15.0), CGPoint(-5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 15.0), CGPoint(5.0, 15.0)
                ].int)
            ]]
        ),
        // 39
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 15.0), CGPoint(-5.0, 15.0), CGPoint(-5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 15.0), CGPoint(5.0, 15.0)
                ].int)
            ]]
        ),
        // 40
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(7.0, -15.0), CGPoint(-20.0, -15.0), CGPoint(-20.0, 20.0), CGPoint(-15.0, 20.0), CGPoint(-15.0, -10.0), CGPoint(7.0, -10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(5.0, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 15.0), CGPoint(-5.0, 15.0), CGPoint(-5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 20.0), CGPoint(5.0, 20.0)
                ].int)
            ]]
        ),
        // 41
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(4.0833, -15.0), CGPoint(-20.0, -15.0), CGPoint(-20.0, 20.0), CGPoint(-15.0, 20.0), CGPoint(-15.0, -10.0), CGPoint(4.5, -10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(4.9167000000000005, -5.0), CGPoint(-10.0, -5.0), CGPoint(-10.0, 15.0), CGPoint(-5.0, 15.0), CGPoint(-5.0, 0.0), CGPoint(0.0, 0.0), CGPoint(0.0, 20.0), CGPoint(5.0, 20.0), CGPoint(5.0, -4.0004)
                ].int)
            ]]
        ),
        // 42
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(15.0, -9.0), CGPoint(10.0, -10.0), CGPoint(10.0, -5.625), CGPoint(12.0, -5.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-10.0, -14.0), CGPoint(-16.8, -14.0), CGPoint(-4.0, -10.0), CGPoint(10.0, -10.0)
                ].int)
            ]]
        ),
        // 43
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(5.0, 10.0), CGPoint(0.0, 10.0), CGPoint(0.0, 15.0), CGPoint(5.0, 15.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(5.0, -5.0), CGPoint(-5.0, -5.0), CGPoint(-5.0, 0.0), CGPoint(5.0, 0.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(-5.0, 10.0), CGPoint(-10.0, 10.0), CGPoint(-10.0, 15.0), CGPoint(-5.0, 15.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(15.0, -15.0), CGPoint(-15.0, -15.0), CGPoint(-15.0, -10.0), CGPoint(15.0, -10.0)
                ].int),
                IntPath(unsafe: [
                    CGPoint(15.0, -5.0), CGPoint(10.0, -5.0), CGPoint(10.0, 15.0), CGPoint(15.0, 15.0)
                ].int)
            ]]
        ),
        // 44
        Result(
            pinResult: .success,
            regions: []
        ),
        // 45
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(-1.0, -0.0001), CGPoint(-3.0, -0.0001), CGPoint(-3.0, 2.9999000000000002), CGPoint(3.0, 2.9999000000000002), CGPoint(3.0, -0.0001), CGPoint(1.0, -0.0001), CGPoint(1.0, 0.0), CGPoint(0.0, 1.0), CGPoint(-1.0, 0.0)
                ].int)
            ]]
        ),
        // 46
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(1.6986, -1.0), CGPoint(-3.0, -1.0), CGPoint(-3.0, 4.0), CGPoint(3.0, 4.0), CGPoint(3.0, -0.5388000000000001), CGPoint(2.3624, -0.6512), CGPoint(2.3617, -0.652), CGPoint(2.3317, -0.6573), CGPoint(2.3299000000000003, -0.6595000000000001), CGPoint(2.3071, -0.6635), CGPoint(2.3054, -0.6656000000000001), CGPoint(2.2826, -0.6696000000000001), CGPoint(2.2798000000000003, -0.6729), CGPoint(2.2641, -0.6757000000000001), CGPoint(2.2602, -0.6804), CGPoint(2.2518000000000002, -0.6819000000000001), CGPoint(2.043, -0.7187), CGPoint(2.0412, -0.7209), CGPoint(2.0184, -0.7249), CGPoint(1.9140000000000001, -0.7433000000000001)
                ].int)
            ]]
        ),
        // 47
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(0.0, -0.1), CGPoint(-0.2, -0.1), CGPoint(-0.2, 0.1), CGPoint(-0.1143, 0.0555), CGPoint(-0.1296, 0.0228), CGPoint(-0.011000000000000001, 0.0019), CGPoint(0.0, 0.0)
                ].int)
            ]]
        ),
        // 48
        Result(
            pinResult: .success,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(0.0, -0.1), CGPoint(-0.2, -0.1), CGPoint(-0.1095, 0.0193), CGPoint(-0.0109, 0.0019)
                ].int)
            ]]
        ),
        // 49
        Result(
            pinResult: .modified,
            regions: [[
                IntPath(unsafe: [
                    CGPoint(0.0, -0.1), CGPoint(-0.2, -0.1), CGPoint(-0.1203, 0.0212), CGPoint(-0.0109, 0.0019), CGPoint(0.0, 0.0)
                ].int)
                ],
                [
                    IntPath(unsafe: [
                        CGPoint(0.0, -0.1), CGPoint(-0.2, -0.1), CGPoint(-0.1203, 0.0212), CGPoint(-0.0109, 0.002), CGPoint(-0.0109, 0.0019), CGPoint(-0.0014, 0.00030000000000000003), CGPoint(0.0, 0.0)
                    ].int)
                ]
            ]
        )
    ]
            
            
    
    func test_00() throws {
        run(index: 0)
    }
    
    func test_01() throws {
        run(index: 1)
    }
    
    func test_02() throws {
        run(index: 2)
    }
    
    func test_03() throws {
        run(index: 3)
    }
    
    func test_04() throws {
        run(index: 4)
    }
    
    func test_05() throws {
        run(index: 5)
    }
    
    func test_06() throws {
        run(index: 6)
    }
    
    func test_07() throws {
        run(index: 7)
    }
    
    func test_08() throws {
        run(index: 8)
    }
    
    func test_09() throws {
        run(index: 9)
    }
    
    func test_10() throws {
        run(index: 10)
    }
    
    func test_11() throws {
        run(index: 11)
    }
    
    func test_12() throws {
        run(index: 12)
    }
    
    func test_13() throws {
        run(index: 13)
    }
    
    func test_14() throws {
        run(index: 14)
    }
    
    func test_15() throws {
        run(index: 15)
    }
    
    func test_16() throws {
        run(index: 16)
    }
    
    func test_17() throws {
        run(index: 17)
    }
    
    func test_18() throws {
        run(index: 18)
    }
    
    func test_19() throws {
        run(index: 19)
    }
    
    func test_20() throws {
        run(index: 20)
    }
    
    func test_21() throws {
        run(index: 21)
    }
    
    func test_22() throws {
        run(index: 22)
    }
    
    func test_23() throws {
        run(index: 23)
    }
    
    func test_24() throws {
        run(index: 24)
    }
    
    func test_25() throws {
        run(index: 25)
    }
    
    func test_26() throws {
        run(index: 26)
    }
    
    func test_27() throws {
        run(index: 27)
    }
    
    func test_28() throws {
        run(index: 28)
    }
    
    func test_29() throws {
        run(index: 29)
    }
    
    func test_30() throws {
        run(index: 30)
    }
    
    func test_31() throws {
        run(index: 31)
    }
    
    func test_32() throws {
        run(index: 32)
    }
    
    func test_33() throws {
        run(index: 33)
    }
    
    func test_34() throws {
        run(index: 34)
    }
    
    func test_35() throws {
        run(index: 35)
    }
    
    func test_36() throws {
        run(index: 36)
    }
    
    func test_37() throws {
        run(index: 37)
    }
    
    func test_38() throws {
        run(index: 38)
    }
    
    func test_39() throws {
        run(index: 39)
    }
    
    func test_40() throws {
        run(index: 40)
    }
    
    func test_41() throws {
        run(index: 41)
    }
    
    func test_42() throws {
        run(index: 42)
    }
    
    func test_43() throws {
        run(index: 43)
    }
    
    func test_44() throws {
        run(index: 44)
    }
    
    func test_45() throws {
        run(index: 45)
    }
    
    func test_46() throws {
        run(index: 46)
    }
    
    func test_47() throws {
        run(index: 47)
    }
    
    func test_48() throws {
        run(index: 48)
    }
    
    func test_49() throws {
        run(index: 49)
    }
    
    private func run(index: Int) {
        let data = SubtractTests.data[index]

        let pathA = fixer.solve(path: data.shapeA).first ?? []
        let pathB = fixer.solve(path: data.shapeB, clockWise: false).first ?? []

        let target = results[index]
        
        self.execute(pathA: pathA, pathB: pathB, target: target)
    }
    
    private func execute(pathA: [IntPoint], pathB: [IntPoint], target: Result) {
        for i in 0..<pathA.count {
            let shiftA = pathA.shift(offset: i)
            for j in 0..<pathB.count {
                let shiftB = pathB.shift(offset: j)
                
                let bundle = detector.findPins(
                    pathA: shiftA,
                    pathB: shiftB,
                    shapeCleaner: .def
                )

                XCTAssertEqual(bundle.pinResult, target.pinResult)
                
                let result = solver.difference(
                    pathA: bundle.pathA[0],
                    pathB: bundle.pathB[0],
                    navigator: Navigator(pins: bundle.pins)
                )
               
                var isAnySame = target.regions.isEmpty
                
                for region in target.regions {
                    let isSame = result.list.isSame(region)
                    
                    if !isSame {
                        for i in 0..<result.list.count {
                            let item = result.list[i]
                            debugPrint("\(i): \(item.points.prettyPrint)")
                        }
                        return
                    } else {
                        isAnySame = true
                        break
                    }
                }
                
                XCTAssertTrue(isAnySame)
            }
        }
    }
    
}
