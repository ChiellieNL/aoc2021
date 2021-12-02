//
//  Move.swift
//  Day2
//
//  Created by Michiel Horvers on 02/12/2021.
//

import Foundation

enum Direction: String {
    case forward
    case down
    case up
}

struct Move {
    let direction: Direction
    let units: Int

    static func load(from input: String) -> [Move] {
        let moves = input.components(separatedBy: .newlines)
        var list = [Move]()

        for move in moves {
            let values = move.components(separatedBy: .whitespaces)
            guard values.count == 2 else {
                print("Warning: invalud components for \(move)")
                continue
            }

            if let direction = Direction(rawValue: values[0]),
                let units = Int(values[1]) {
                list.append(Move(direction: direction, units: units))
                
            } else {
                print("Warning: invalud components for \(move)")
            }
        }

        return list
    }
}
