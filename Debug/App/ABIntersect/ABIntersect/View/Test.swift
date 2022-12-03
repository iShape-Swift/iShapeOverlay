//
//  Test.swift
//  ABIntersect
//
//  Created by Nail Sharipov on 24.11.2022.
//

import iGeometry
import iShapeOverlay
import DebugUtil
import CoreGraphics

final class Test {

    private let perIndex = PersistInt(key: "TestIndex")
    
    init() {
//        perIndex.value = 0
    }
    
    var index: Int {
        perIndex.value % IntersectTests.data.count
    }
    
    var current: TestData {
        IntersectTests.data[index]
    }

    func next() {
        _ = perIndex.increase(amount: 1, round: IntersectTests.data.count)
    }

    func prev() {
        _ = perIndex.increase(amount: -1, round: IntersectTests.data.count)
    }

}
