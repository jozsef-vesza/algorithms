//: [Previous](@previous)

extension CollectionType where Index.Distance == Int {

    func rev() -> [Generator.Element] {
        
        var input = Array(self)
        var output: [Generator.Element] = []
        
        for var index = input.count - 1; index > -1; index-- {
            
            output.append(input[index])
        }
        
        return output
    }
}

extension String {
    
    func reverseString() -> String {
        return String(self.characters.rev())
    }
}

let reversed = "abc".reverseString()

//: [Next](@next)