//
//  ContactSet.swift
//  
//
//  Created by Nail Sharipov on 29.11.2022.
//

extension Collision {

#if DEBUG
    struct ContactSet {
        
        private let module: Int
        private var idMap = [Int: [Int]]()
        
        @inlinable
        mutating func put(edge: Int, vertex: Int) {
            if var array = idMap[edge] {
                if !array.contains(vertex) {
                    array.append(vertex)
                    idMap[edge] = array
                }
            } else {
                idMap[edge] = [vertex]
            }
        }
        
        init(module: Int) {
            self.module = module
        }

        @inlinable
        func isContain(edge: Int, vertex: Int) -> Bool {
            if let array = idMap[edge] {
                return array.contains(vertex)
            } else {
                return false
            }
        }
    }

#else
    struct ContactSet {
        
        private let module: Int
        private var idSet = Set<Int>()
        
        @inlinable
        mutating func put(edge: Int, vertex: Int) {
            let id = edge * module + vertex
            idSet.insert(id)
        }
        
        init(module: Int) {
            self.module = module
        }

        @inlinable
        func isContain(edge: Int, vertex: Int) -> Bool {
            let id = edge * module + vertex
            return idSet.contains(id)
        }
    }

#endif
}
