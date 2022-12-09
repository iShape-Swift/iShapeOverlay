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
        Result(pins:[
            Pin(CGPoint(x: -5, y: 10), .end_in_back),
            Pin(CGPoint(x:  5, y: 10), .start_out_back)
        ]),
        Result(pins:[
            Pin(CGPoint(x: -10, y: -5), .end_in_back),
            Pin(CGPoint(x: -10, y:  5), .start_out_back)
        ]),
        Result(pins:[
            Pin(CGPoint(x: -5, y: -10), .start_out_back),
            Pin(CGPoint(x:  5, y: -10), .end_in_back)
        ]),
        Result(pins:[
            Pin(CGPoint(x: 10, y: -5), .start_out_back),
            Pin(CGPoint(x: 10, y:  5), .end_in_back)
        ]),
        Result(pins:[
            Pin(CGPoint(x:-10, y: 10), .end_in_back),
            Pin(CGPoint(x: 10, y: 10), .start_out_back)
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
    
    private func run(index: Int) {
        let data = PinTests.data[index]
        
        let pathA = data.shapeA
        let pathB = data.shapeB
        
        for i in 0..<pathA.count {
            for j in 0..<pathB.count {
                let result = detector.findPins(
                    pathA: pathA.shift(offset: i),
                    pathB: data.shapeB.shift(offset: j),
                    fixer: fixer
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

extension Array where Element == IntPoint {
    
    func shift(offset: Int) -> [IntPoint] {
        guard offset != 0 else { return self }
        var array = [IntPoint]()
        let n = count
        array.reserveCapacity(n)
        for i in 0..<n {
            array.append(self[(i + offset) % n])
        }
        return array
    }
    
}
