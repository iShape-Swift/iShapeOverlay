//
//  File.swift
//  
//
//  Created by Nail Sharipov on 15.09.2022.
//

import iGeometry
import CoreGraphics

extension IntPoint: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case x
        case y
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let x = try container.decode(Int64.self, forKey: .x)
        let y = try container.decode(Int64.self, forKey: .y)
        
        self.init(x: x, y: y)
    }
}

public extension IntPoint {

    init(point: CGPoint, geom: IntGeom = IntGeom.defGeom) {
        let x = geom.int(float: CGFloat(point.x))
        let y = geom.int(float: CGFloat(point.y))
        self.init(x: x, y: y)
    }
    
}
