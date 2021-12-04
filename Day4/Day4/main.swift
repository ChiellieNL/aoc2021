//
//  main.swift
//  Day4
//
//  Created by Michiel Horvers on 04/12/2021.
//

import Foundation

let boards = Board.load(from: rawBoards)

// MARK: - Part 1
/*
for i in 0..<numbers.count {
    for board in boards {
        if let score = board.hasBingo(with: Array(numbers[0...i])) {
            print("BINGO! Score: \(numbers[i] * score)")
            exit(0)
        }
    }
}
 */

// MARK: - Part 1 & 2

let winScore = boards.compactMap({ $0.bingoResult(with: numbers) })
print("First winner wins with score: \(winScore.sorted(by: { $0.winsAt < $1.winsAt }).first!.score )")
print("Last winner wins with score: \(winScore.sorted(by: { $0.winsAt > $1.winsAt }).first!.score )")
