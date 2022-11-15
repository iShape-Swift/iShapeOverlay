//
//  Event.swift
//  
//
//  Created by Nail Sharipov on 10.11.2022.
//

extension Fixer {
    
    struct Event {
        enum Action: Int {
            case add = 1
            case remove = 0
        }
        
        let sortValue: Int64
        let action: Action
        var edgeId: Int
        
    }
}

