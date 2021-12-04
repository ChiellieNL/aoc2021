//
//  Board.swift
//  Day4
//
//  Created by Michiel Horvers on 04/12/2021.
//

import Foundation

struct Board {
    let numbers: [Int]

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

    func row(at index: Int) -> [Int] {
        guard index >= 0 && index < 5 else { return [] }

        let offset = index * 5
        return Array(numbers[offset..<(offset + 5)])
    }

    func column(at index: Int) -> [Int] {
        guard index >= 0 && index < 5 else { return [] }

        var col = [Int] ()
        for i in 0..<5 {
            col.append(numbers[index + (i * 5)])
        }
        return col
    }

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

    func bingoResult(with list: [Int]) -> (winsAt: Int, score: Int)? {
        for i in 0..<list.count {
            if let score = hasBingo(with: Array(list[0...i])) {
                return (winsAt: i, score: list[i] * score)
            }
        }

        return nil
    }
}

extension Board: CustomStringConvertible {
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
    func containsAll(in array: [Int]) -> Bool {
        return numbersMissing(in: array).isEmpty
    }

    func numbersMissing(in array: [Int]) -> [Int] {
        var missing = [Int]()

        for i in 0..<array.count {
            if !self.contains(array[i]) {
                missing.append(array[i])
            }
        }

        return missing
    }

    var sum: Int {
        reduce(0, +)
    }
}
