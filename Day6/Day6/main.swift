//
//  main.swift
//  Day6
//
//  Created by Michiel Horvers on 06/12/2021.
//

import Foundation


// MARK: - Part 1

var fish = input.components(separatedBy: ",").compactMap( Int.init )

/*
// Suitable for 80 days.. but definitely NOT for 256 days 🤯
for _ in 1...80 {
    var newList = [Int]()
    for i in 0..<fish.count {
        if fish[i] == 0 {
            newList.append(6)
            newList.append(8)

        } else {
            newList.append(fish[i] - 1)
        }
    }
    fish = newList
}

print("Total fish after 80 days: \(fish.count)\n")
//Total fish after 80 days: 383160
*/

var pool = FishPool(fish: fish)
pool.evolve(days: 80)
print("Total fish after 80 days: \(pool.count)")

// MARK: - Part 2

pool = FishPool(fish: fish)
pool.evolve(days: 256)
print("Total fish after 256 days: \(pool.count)")
