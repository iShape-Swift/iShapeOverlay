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
        perIndex.value % SubtractTests.data.count
    }
    
    var current: TestData {
        SubtractTests.data[index]
    }

    func next() {
        _ = perIndex.increase(amount: 1, round: SubtractTests.data.count)
    }

    func prev() {
        _ = perIndex.increase(amount: -1, round: SubtractTests.data.count)
    }

}
