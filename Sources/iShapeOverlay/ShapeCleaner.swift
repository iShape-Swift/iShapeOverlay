//
//  ShapeCleaner.swift
//  
//
//  Created by Nail Sharipov on 09.12.2022.
//

import iGeometry

public struct ShapeCleaner {
    
    public static let def = ShapeCleaner()
    
    public let minArea: Int64
    
    init(minArea: Int64 = 16) {
        self.minArea = minArea
    }

    func clean(list: [[IntPoint]]) -> [[IntPoint]] {
        var result = [[IntPoint]]()
        result.reserveCapacity(list.count)
        for points in list {
            let absArea = abs(points.area)
            if absArea >= minArea {
                result.append(points)
            } else {
                debugPrint("path: \(points) - cleaned")
            }
        }
        return result
    }
    
}
