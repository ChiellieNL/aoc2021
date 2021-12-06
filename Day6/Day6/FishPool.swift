//
//  FishPool.swift
//  Day6
//
//  Created by Michiel Horvers on 06/12/2021.
//

import Foundation

struct FishPool {
    var ages: [Int]

    init(fish: [Int]) {
        ages = [Int](repeating: 0, count: 9)
        for i in 0..<fish.count {
            ages[fish[i]] += 1
        }
    }

    private mutating func newDay() {
        var newAges = [Int](repeating: 0, count: 9)
        // decrease each age
        for i in 1...8 {
            newAges[i - 1] = ages[i]
        }

        // all ages of 0 will be reset to 6...
        newAges[6] += ages[0]
        // ...and create a new fish at age 8
        newAges[8] = ages[0]

        ages = newAges
    }

    mutating func evolve(days: Int) {
        for _ in 0..<days {
            newDay()
        }
    }

    var count: Int {
        ages.reduce(0, +)
    }
}
