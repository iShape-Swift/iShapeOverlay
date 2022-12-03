import XCTest
import iGeometry
@testable import iShapeOverlay

final class PinTests: XCTestCase {
    
    private let detector = Collision.Detector()

    private struct Result {
        let pins: [PinPoint]
    }

    private let results: [Result] = [
        Result(pins:[
            PinPoint(p: Point(x: -5, y: 10), type: .end_in, mA: MileStone(index: 0, offset: 5.0), mB: MileStone(index: 2, offset: 0.0)),
            PinPoint(p: Point(x:  5, y: 10), type: .start_out, mA: MileStone(index: 0, offset: 15.0), mB: MileStone(index: 1, offset: 0.0))
        ]),
        Result(pins:[
            PinPoint(p: Point(x: -10, y: 5), type: .end_in, mA: MileStone(index: 3, offset: 5.0), mB: MileStone(index: 2, offset: 0.0)),
            PinPoint(p: Point(x: -10, y: 5), type: .start_out, mA: MileStone(index: 3, offset: 15.0), mB: MileStone(index: 1, offset: 0.0))
        ]),
        Result(pins:[
            PinPoint(p: Point(x: -5, y: -10), type: .start_out, mA: MileStone(index: 2, offset: 15.0), mB: MileStone(index: 1, offset: 0.0)),
            PinPoint(p: Point(x:  5, y: -10), type: .end_in, mA: MileStone(index: 2, offset: 5.0), mB: MileStone(index: 2, offset: 0.0))
        ]),
        Result(pins:[
            PinPoint(p: Point(x: 10, y: -5), type: .start_out, mA: MileStone(index: 1, offset: 15.0), mB: MileStone(index: 1, offset: 0.0)),
            PinPoint(p: Point(x: 10, y:  5), type: .end_in, mA: MileStone(index: 1, offset: 5.0), mB: MileStone(index: 2, offset: 0.0))
        ]),
        Result(pins:[
            PinPoint(p: Point(x:-10, y: 10), type: .end_in, mA: MileStone(index: 0, offset: 0.0), mB: MileStone(index: 2, offset: 0.0)),
            PinPoint(p: Point(x: 10, y: 10), type: .start_out, mA: MileStone(index: 1, offset: 0.0), mB: MileStone(index: 1, offset: 0.0))
        ])
    ]
    
    
    func test_00() throws {
        for i in 0...4 {
            let data = PinTests.data[i]

            let pins = detector.findPins(pathA: data.shapeA, pathB: data.shapeB)
            print(pins)
            
            XCTAssertTrue(pins.isSame(array: results[i].pins))
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

private extension Point {
    var int: IntPoint {
        IntGeom.defGeom.int(point: self)
    }
}

private extension PinPoint {
    
    init(p: Point, type: PinType, mA: MileStone, mB: MileStone) {
        self.init(p: p.int, type: type, mA: mA, mB: mB)
    }
    
}

private extension MileStone {
    init(index: Int, offset: Float) {
        let a = IntGeom.defGeom.int(float: offset)
        self.init(index: index, offset: a * a)
    }
}
