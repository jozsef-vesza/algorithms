import Cocoa

let arr = [2, -2, 6, -6, 8]

func zeroSumArrayExists(input: [Int]) -> Bool {
    
    var sums = [Int : Int]()
    
    var sum = 0
    
    for (index, num) in input.enumerate() {
        
        sum += num
        
        if input[index] == 0 || sum == 0 || sums[sum] != nil {
            return true
        }
        
        sums[sum] = index
    }
    
    return false
}

func createSumArray(input: [Int]) -> [Int] {
    
    let output = input.map { num -> Int in
    
        let index = input.indexOf(num)!
        
        var sum = 0
        
        for i in 0 ... index {
            sum += input[i]
        }
        
        return sum
    }
    
    return output
}

func numberOfZeroSums(input: [Int]) -> Int {

    var numOfSums = 0
    
    for j in 0 ..< input.count {
    
        if input[j] == 0 {
            numOfSums += 1
        }
        
        for k in j + 1 ..< input.count {
        
            if input[k] == input[j] {
                numOfSums += 1
            }
        }
    }
    
    return numOfSums
}

let result = zeroSumArrayExists(arr)
let sumArray = createSumArray(arr)
let numOfSums = numberOfZeroSums(sumArray)

let complexArr = [0,-9,-2,9,8,-3,9,-1,-6,1,-1,-6,8,-3,-10,-4,-8,8,6,6,-8,-10,-7,-10,-8,-6,4,3,8,-10,0,-3,-9,9,-4,9,-7,-8,-5,-3,3,3,-1,-2,10,0,4,-9,-3,0]

let complexCntains = zeroSumArrayExists(complexArr)
let complexSum = createSumArray(complexArr)
let complexNum = numberOfZeroSums(complexSum)