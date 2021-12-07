//
//  main.swift
//  Day7
//
//  Created by Michiel Horvers on 07/12/2021.
//

import Foundation

// MARK: - Part 1

var positions = input.components(separatedBy: ",").compactMap(Int.init)
var lowest = positions.sorted(by: { $0 < $1 }).first!
var highest = positions.sorted(by: { $0 < $1 }).last!

var fuelCost: [Int] = [Int](repeating: 0, count: (highest - lowest) + 1)

for i in lowest...highest {
    var fuel = 0
    for pos in positions {
        fuel += abs(pos - i)
    }
    fuelCost[i] = fuel
}

var cheapest = fuelCost.sorted(by: { $0 < $1 }).first!
print("--- Part 1---\nCheapest fuel cost: \(cheapest)\n")

// MARK: - Part 2

positions = input.components(separatedBy: ",").compactMap(Int.init)
lowest = positions.sorted(by: { $0 < $1 }).first!
highest = positions.sorted(by: { $0 < $1 }).last!

fuelCost = [Int](repeating: 0, count: (highest - lowest) + 1)

for i in lowest...highest {
    var fuel = 0
    for pos in positions {
        let delta = abs(pos - i)
        fuel += delta * (delta + 1) / 2
    }
    fuelCost[i] = fuel
}

cheapest = fuelCost.sorted(by: { $0 < $1 }).first!
print("--- Part 2---\nCheapest fuel cost: \(cheapest)\n")
