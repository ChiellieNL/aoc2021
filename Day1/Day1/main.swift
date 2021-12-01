//
//  main.swift
//  Day1
//
//  Created by Michiel Horvers on 01/12/2021.
//

import Foundation

// MARK: - Part 1

var increased = 0

for i in 1..<input.count {
    if input[i] > input[i - 1] {
        increased += 1
    }
}

print("Measurements that are larger than the previous: \(increased)")


// MARK: - Part 2

increased = 0

for i in 3..<input.count {
    let previousSum = input[i - 3] + input[i - 2] + input[i - 1]
    let sum = input[i - 2] + input[i - 1] + input[i]

    if sum > previousSum {
        increased += 1
    }
}

print("Sums that are larger than the previous sum: \(increased)")
