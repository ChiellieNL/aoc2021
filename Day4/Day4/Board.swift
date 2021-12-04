//
//  Board.swift
//  Day4
//
//  Created by Michiel Horvers on 04/12/2021.
//

import Foundation

struct Board {
    /// numbers for this board
    let numbers: [Int]

    /// Creates an array of boards from the specified inpu
    static func load(from input: String) -> [Board] {
        let lines = input.components(separatedBy: .newlines)
        var boards = [Board]()

        var i = 0
        while i < lines.count {
            var numbs = [Int]()
            for _ in 0..<5 {
                numbs.append(contentsOf: lines[i].components(separatedBy: .whitespaces).compactMap({ Int($0) }))
                i += 1
            }
            boards.append(Board(numbers: numbs))
            if i < lines.count && lines[i].isEmpty {
                i += 1
            }
        }

        return boards
    }

    /// Returns the numbers for the specified row
    func row(at index: Int) -> [Int] {
        guard index >= 0 && index < 5 else { return [] }

        let offset = index * 5
        return Array(numbers[offset..<(offset + 5)])
    }

    /// Returns the numbers for the specified column
    func column(at index: Int) -> [Int] {
        guard index >= 0 && index < 5 else { return [] }

        var col = [Int] ()
        for i in 0..<5 {
            col.append(numbers[index + (i * 5)])
        }
        return col
    }

    /// Checks if this board will have bingo with the specific list of drawn numbers
    /// If so: it will return the sum of the missing numbers
    /// otherwise: it will return nil
    func hasBingo(with list: [Int]) -> Int? {
        for i in 0..<5 {
            if list.containsAll(in: row(at: i)) {
                // Bingo!
                return list.numbersMissing(in: numbers).sum
            }
            if list.containsAll(in: column(at: i)) {
                // Bingo!
                return list.numbersMissing(in: numbers).sum
            }
        }

        return nil
    }

    /// Checks when this board would get a BINGO
    /// Returns a tuple with:
    ///     - winsAt: the round where it would get bingo
    ///     - score: The final score it would have at that point
    func bingoResult(with list: [Int]) -> (winsAt: Int, score: Int)? {
        // start with 5, can't win with less numbers can we 😉
        for i in 5..<list.count {
            if let score = hasBingo(with: Array(list[0...i])) {
                return (winsAt: i, score: list[i] * score)
            }
        }

        return nil
    }
}

extension Board: CustomStringConvertible {
    /// just a readable board description
    var description: String {
        var board = ""

        for i in 0..<5 {
            board += column(at: i).map({ String(format: "%02d", $0) }).joined(separator: " ")
            board += "\n"
        }

        return board
    }
}

extension Array where Element == Int {
    /// Returns whether self contains all of the numbers within the specified array
    func containsAll(in array: [Int]) -> Bool {
        return numbersMissing(in: array).isEmpty
    }

    /// Returns an array of numbers within the specified array, that aren't within self
    func numbersMissing(in array: [Int]) -> [Int] {
        var missing = [Int]()

        for i in 0..<array.count {
            if !self.contains(array[i]) {
                missing.append(array[i])
            }
        }

        return missing
    }

    /// Sum of the numbers within this array
    var sum: Int {
        reduce(0, +)
    }
}
