//: [Previous](@previous)

extension CollectionType where Index: BidirectionalIndexType {

    func reversed() -> [Generator.Element] {
        
        var output: [Generator.Element] = []
        
        var index = self.endIndex
        
        while index != self.startIndex {
        
            output.append(self[index.predecessor()])
            index = index.predecessor()
        }
        
        return output
    }
}

extension String {
    
    func reversed() -> String {
        return String(self.characters.reversed())
    }
}

let reversed = "abc".reversed()
let reversedArr = [1, 2, 3, 4].reversed()

//: [Next](@next)