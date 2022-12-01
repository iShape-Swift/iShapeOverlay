//
//  ContactSet.swift
//  
//
//  Created by Nail Sharipov on 29.11.2022.
//

extension Collision {
    
    struct ContactSet {
        
        private let module: Int
        private let idList: [Int]
        
        init(module: Int, contacts: [Contact]) {
            self.module = module
            let list = contacts.map({ $0.edge * module + $0.vertex }).sorted(by: { $0 < $1 })
            if list.count > 1 {
                var a = list[0]
                var result = [Int]()
                result.append(a)
                for i in 1..<list.count {
                    let b = list[i]
                    if a != b {
                        result.append(b)
                        a = b
                    }
                }
                idList = result
            } else {
                idList = list
            }
        }
        
        func isContain(edge: Int, vertex: Int) -> Bool {
            guard !idList.isEmpty else { return false }
            let id = edge * module + vertex
            let index = idList.findIndexExactResult(value: id)
            return index >= 0
        }
    }
    
}

private extension Array where Element == Int {
    
    func findIndexExactResult(value a: Int) -> Int {
        var left = 0
        var right = count - 1

        var j = -1
        var i = (left + right) / 2
        var x = self[i]
        
        while i != j {
            if x > a {
                right = i - 1
            } else if x < a {
                left = i + 1
            } else {
                return i
            }
            
            j = i
            i = (left + right) / 2

            x = self[i]
        }

        return -1
    }

}
