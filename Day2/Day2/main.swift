//
//  main.swift
//  Day2
//
//  Created by Michiel Horvers on 02/12/2021.
//

import Foundation

let moves = Move.load(from: rawInput)

// MARK: Part 1

var horizontal = 0
var depth = 0

for move in moves {
    switch move.direction {

    case .forward:
        horizontal += move.units
    case .down:
        depth += move.units
    case .up:
        depth -= move.units
    }
}

print("--- Part 1 ---")
print("Final position:\nHorizontal: \(horizontal)\tDepth: \(depth)\nMultiply: \(horizontal * depth)\n\n")

// MARK: Part 2

var aim = 0
horizontal = 0
depth = 0

for move in moves {
    switch move.direction {

    case .forward:
        horizontal += move.units
        depth += aim * move.units
    case .down:
        aim += move.units
    case .up:
        aim -= move.units
    }
}

print("--- Part 2 ---")
print("Final position:\nHorizontal: \(horizontal)\tDepth: \(depth)\nMultiply: \(horizontal * depth)\n\n")
