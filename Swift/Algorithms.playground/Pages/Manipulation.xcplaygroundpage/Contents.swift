//: [Previous](@previous)

extension CollectionType where Index.Distance == Int {

    func reversed() -> [Generator.Element] {
        
        var input = Array(self)
        var output: [Generator.Element] = []
        
        for var index = input.count - 1; index > -1; index-- {
            
            output.append(input[index])
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

//: [Next](@next)