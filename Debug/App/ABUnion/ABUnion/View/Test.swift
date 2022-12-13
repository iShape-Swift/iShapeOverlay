//
//  Test.swift
//  ABUnion
//
//  Created by Nail Sharipov on 13.12.2022.
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

