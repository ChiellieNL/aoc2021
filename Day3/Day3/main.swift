//
//  main.swift
//  Day3
//
//  Created by Michiel Horvers on 03/12/2021.
//

import Foundation

// MARK: - Helpers

/// Returns the most common number (either 0 or 1) at the specified index within the list
func mostCommon(at index: Int, in list: [String]) -> Character {
    let values = list.map({ $0[index] })
    let ones = values.filter({ $0 == "1" }).count
    let zeroes = list.count - ones
    return ones >= zeroes ? "1" : "0"
}

/// Converts a binary string (e.g. "1011") to an Int (e.g. 11)
func binaryToInt(binaryString: String) -> Int {
  return Int(strtoul(binaryString, nil, 2))
}

extension String {
    /// The old fashion String subscripting (e.g. string[1] returns the character at index 1)
    public subscript(_ index: Int) -> Character? {
        guard self.count > index else { return nil }

        let inx = self.index(self.startIndex, offsetBy: index)
        return self[inx]
    }
}


// MARK: - Part 1

var gamma = 0
var epsilon = 0
let totalValues = input.count
let size = input[0].count

for i in 0..<size {
    let bitValue = Int(truncating: NSDecimalNumber(decimal: pow(2, (size - 1) - i)))

    if mostCommon(at: i, in: input) == "1" {
        // 1 is the most common
        gamma += bitValue

    } else {
        // 0 is the most common
        epsilon += bitValue
    }
}

print("""
- Part 1 -
Gamma: \(gamma)
Epsilon: \(epsilon)
Power consumption: \(gamma * epsilon)

""")

// MARK: - Part 2

var list = input
var oxigen = 0

for i in 0..<size {
    let most = mostCommon(at: i, in: list)
    list = list.filter({ $0[i] == most })
    if list.count == 1 {
        oxigen = binaryToInt(binaryString: list[0])
        break
    }
}

list = input
var co2 = 0

for i in 0..<size {
    let most = mostCommon(at: i, in: list)
    let least = most == "1" ? Character("0") : Character("1")
    list = list.filter({ $0[i] == least })
    if list.count == 1 {
        co2 = binaryToInt(binaryString: list[0])
        break
    }
}

print("""
- Part 2 -
Oxigen: \(oxigen)
CO2: \(co2)
Power consumption: \(oxigen * co2)

""")
