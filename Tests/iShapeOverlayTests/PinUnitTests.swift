import XCTest
import iGeometry
@testable import iShapeOverlay

private struct Pin {
    let point: IntPoint
    let type: PinType
    
    init(_ point: CGPoint, _ type: PinType) {
        self.point = point.int
        self.type = type
    }
    
    init(_ pinPoint: PinPoint) {
        point = pinPoint.p
        type = pinPoint.type
    }
}

final class PinUnitTests: XCTestCase {
    
    private let detector = Collision.Detector()
    private let fixer = Fixer()
    
    private struct Result {
        let pins: [Pin]
    }
    
    private let results: [Result] = [
        // 0
        Result(pins:[
            Pin(CGPoint(x: -5, y: 10), .end_in_back),
            Pin(CGPoint(x:  5, y: 10), .start_out_back)
        ]),
        // 1
        Result(pins:[
            Pin(CGPoint(x: -10, y: -5), .end_in_back),
            Pin(CGPoint(x: -10, y:  5), .start_out_back)
        ]),
        // 2
        Result(pins:[
            Pin(CGPoint(x: -5, y: -10), .start_out_back),
            Pin(CGPoint(x:  5, y: -10), .end_in_back)
        ]),
        // 3
        Result(pins:[
            Pin(CGPoint(x: 10, y: -5), .start_out_back),
            Pin(CGPoint(x: 10, y:  5), .end_in_back)
        ]),
        // 4
        Result(pins:[
            Pin(CGPoint(x:-10, y: 10), .end_in_back),
            Pin(CGPoint(x: 10, y: 10), .start_out_back)
        ]),
        // 5
        Result(pins:[
            Pin(CGPoint(x:-10, y: 10), .start_out_back),
            Pin(CGPoint(x:-10, y:-10), .end_in_back)
        ]),
        // 6
        Result(pins:[
            Pin(CGPoint(x:-10, y:-10), .start_out_back),
            Pin(CGPoint(x: 10, y:-10), .end_in_back)
        ]),
        // 7
        Result(pins:[
            Pin(CGPoint(x: 10, y:-10), .start_out_back),
            Pin(CGPoint(x: 10, y: 10), .end_in_back)
        ]),
        // 8
        Result(pins:[
            Pin(CGPoint(x:-10, y:  5), .end_in_back),
            Pin(CGPoint(x: 10, y:  5), .start_out_back)
        ]),
        // 9
        Result(pins:[
            Pin(CGPoint(x: -5, y:-10), .end_in_back),
            Pin(CGPoint(x: -5, y: 10), .start_out_back)
        ]),
        // 10
        Result(pins:[
            Pin(CGPoint(x:-10, y: -5), .start_out_back),
            Pin(CGPoint(x: 10, y: -5), .end_in_back)
        ]),
        // 11
        Result(pins:[
            Pin(CGPoint(x:  5, y:-10), .start_out_back),
            Pin(CGPoint(x:  5, y: 10), .end_in_back)
        ]),
        // 12
        Result(pins:[
            Pin(CGPoint(x:  0, y: 10), .end_in_back),
            Pin(CGPoint(x: 10, y:  0), .start_out_back)
        ]),
        // 13
        Result(pins:[
            Pin(CGPoint(x:-10, y:  0), .end_in_back),
            Pin(CGPoint(x:  0, y: 10), .start_out_back)
        ]),
        // 14
        Result(pins:[
            Pin(CGPoint(x:-10, y:  0), .start_out_back),
            Pin(CGPoint(x:  0, y:-10), .end_in_back)
        ]),
        // 15
        Result(pins:[
            Pin(CGPoint(x:  0, y:-10), .start_out_back),
            Pin(CGPoint(x: 10, y:  0), .end_in_back)
        ]),
        // 16
        Result(pins:[
            Pin(CGPoint(x:  0, y: 10), .start_out_back),
            Pin(CGPoint(x: 10, y:  0), .end_in_back)
        ]),
        // 17
        Result(pins:[
            Pin(CGPoint(x:  0, y: 10), .end_in_back),
            Pin(CGPoint(x:-10, y:  0), .start_out_back)
        ]),
        // 18
        Result(pins:[
            Pin(CGPoint(x:  0, y:-10), .start_out_back),
            Pin(CGPoint(x:-10, y:  0), .end_in_back)
        ]),
        // 19
        Result(pins:[
            Pin(CGPoint(x: 10, y:  0), .start_out_back),
            Pin(CGPoint(x:  0, y:-10), .end_in_back)
        ]),
        // 20
        Result(pins:[
            Pin(CGPoint(x: -5, y: 10), .end_out_same),
            Pin(CGPoint(x:-10, y: 10), .start_in_same)
        ]),
        // 21
        Result(pins:[
            Pin(CGPoint(x:-10, y:  0), .into),
            Pin(CGPoint(x:-10, y: 10), .end_out_back),
            Pin(CGPoint(x: -5, y: 10), .start_out_back),
        ]),
        // 22
        Result(pins:[
            Pin(CGPoint(x:  5, y: 10), .start_in_same),
            Pin(CGPoint(x: 10, y: 10), .end_out_same)
        ]),
        // 23
        Result(pins:[
            Pin(CGPoint(x:  5, y: 10), .end_in_back),
            Pin(CGPoint(x: 10, y: 10), .start_in_back),
            Pin(CGPoint(x: 10, y:  0), .out),
        ]),
        // 24
        Result(pins:[
            Pin(CGPoint(x: 10, y: 10), .end_out_same),
            Pin(CGPoint(x:-10, y: 10), .start_in_same)
        ]),
        // 25
        Result(pins:[
            Pin(CGPoint(x:  5, y: 10), .start_out_back),
            Pin(CGPoint(x: -5, y:-10), .start_out_back),
            Pin(CGPoint(x: -5, y: 10), .end_in_back),
            Pin(CGPoint(x:  5, y:-10), .end_in_back),
        ]),
        // 26
        Result(pins:[
            Pin(CGPoint(x:-10, y: 10), .end_out_same),
            Pin(CGPoint(x:-10, y:  0), .start_in_same)
        ]),
        // 27
        Result(pins:[
            Pin(CGPoint(x: 10, y: 10), .end_out_back),
            Pin(CGPoint(x: 10, y:  0), .start_in_back)
        ]),
        // 28
        Result(pins:[
            Pin(CGPoint(x: 10, y: 10), .false_in_back)
        ]),
        // 29
        Result(pins:[
            Pin(CGPoint(x: 10, y:  5), .start_in_same),
            Pin(CGPoint(x: 10, y: -5), .end_out_same)
        ]),
        // 30
        Result(pins:[
            Pin(CGPoint(x: 10, y:  5), .end_in_back),
            Pin(CGPoint(x: 10, y: -5), .start_out_back),
        ]),
        // 31
        Result(pins:[
            Pin(CGPoint(x: 10, y:  5), .end_in_back),
            Pin(CGPoint(x: 10, y: -5), .start_out_back)
        ]),
        // 32
        Result(pins:[
            Pin(CGPoint(x:  0.464, y: 0.2159), .out),
            Pin(CGPoint(x:  0.441, y:   0.22), .false_out_same),
            Pin(CGPoint(x: 0.0097, y:    1.0), .into)
        ]),
        // 33
        Result(pins:[
            Pin(CGPoint(x:-10, y: -5), .out),
            Pin(CGPoint(x:-10, y:  5), .into),
            Pin(CGPoint(x:-15, y: -5), .into),
            Pin(CGPoint(x: 15, y: -5), .end_out_same),
            Pin(CGPoint(x:-15, y:  5), .out),
            Pin(CGPoint(x: 10, y: -5), .start_in_same),
            Pin(CGPoint(x: 10, y:  5), .end_out_same),
            Pin(CGPoint(x: 15, y:  5), .start_in_same)
        ]),
        // 34
        Result(pins:[
            Pin(CGPoint(x: 20, y: 10), .false_out_back),
            Pin(CGPoint(x: 10, y:-10), .end_in_back),
            Pin(CGPoint(x:  0, y:  0), .out),
            Pin(CGPoint(x:  0, y:-10), .start_in_back)
        ]),
        // 35
        Result(pins:[
            Pin(CGPoint(x: -0.018000000000000002, y: -6.424), .end_out_same),
            Pin(CGPoint(x: -0.018000000000000002, y:  0.134), .start_out_same),
            Pin(CGPoint(x:  4.4692, y:  5.6719), .into)
        ]),
        // 36
        Result(pins:[
            Pin(CGPoint(x: -0.9956, y: 1.0188000000000001), .start_in_back),
            Pin(CGPoint(x: -0.9955, y: 1.0188000000000001), .end_in_back),
            Pin(CGPoint(x: -0.7692, y: 1.6615), .out)
        ])
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
    
    private func run(index: Int) {
        let data = PinTests.data[index]
        
        let pathA = data.shapeA
        let pathB = data.shapeB
        
        for i in 0..<pathA.count {
            for j in 0..<pathB.count {
                let result = detector.findPins(
                    pathA: pathA.shift(offset: i),
                    pathB: data.shapeB.shift(offset: j),
                    shapeCleaner: .def
                )
                
                let origin = Set(result.pins.map({ Pin($0) }))
                let target = Set(results[index].pins)
                
                XCTAssertEqual(origin, target)
            }
        }
    }
    
}


private extension Array where Element == PinPoint {
    
    func isSame(array: [PinPoint]) -> Bool {
        let n = self.count
        guard array.count == n else {
            return false
        }

        for i in 0..<n {
            var j = i
            var isAllEqual = true
            for a in self {
                if a != array[j] {
                    isAllEqual = false
                    break
                }
                j = (j + 1) % n
            }
            if isAllEqual {
                return true
            }
        }
        return false
    }
    
}

private extension CGPoint {
    var int: IntPoint {
        IntGeom.defGeom.int(point: self)
    }
}

extension Pin: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(point)
        hasher.combine(type)
    }
    
}
