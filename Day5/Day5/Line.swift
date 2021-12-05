//
//  Line.swift
//  Day5
//
//  Created by Michiel Horvers on 05/12/2021.
//

import Foundation

struct Point: Hashable {
    var x: Int
    var y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }

    init(string: String) {
        let components = string.components(separatedBy: ",").map({ Int($0)! })
        self.x = components[0]
        self.y = components[1]
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

struct Line {
    let start: Point
    let end: Point

    static func load(from input: String) -> [Line] {
        let entries = input.components(separatedBy: .newlines)
        var lines = [Line]()

        for entry in entries {
            let components = entry.components(separatedBy: .whitespaces)
            // Expect [start]["->"][end]
            guard components.count == 3 && components[1] == "->" else { continue }

            lines.append(Line(start: Point(string: components[0]), end: Point(string: components[2])))
        }

        return lines
    }

    var maxX: Int {
        return max(start.x, end.x)
    }

    var maxY: Int {
        return max(start.y, end.y)
    }
}

extension Array where Element == Line {
    /// horizontal/vertical raster
    var raster: [Point : Int] {
        var raster: [Point : Int] = [:]

        // iterate over the lines and increase the coords they hit
        for line in self {
            if line.start.x == line.end.x {
                let lower = Swift.min(line.start.y, line.end.y)
                let upper = Swift.max(line.start.y, line.end.y)

                for y in lower...upper {
                    if let curr = raster[Point(x: line.start.x, y: y)] {
                        raster[Point(x: line.start.x, y: y)] = curr + 1
                    } else {
                        raster[Point(x: line.start.x, y: y)] = 1
                    }
                }

            } else if line.start.y == line.end.y {
                let lower = Swift.min(line.start.x, line.end.x)
                let upper = Swift.max(line.start.x, line.end.x)

                for x in lower...upper {
                    if let curr = raster[Point(x: x, y: line.start.y)] {
                        raster[Point(x: x, y: line.start.y)] = curr + 1
                    } else {
                        raster[Point(x: x, y: line.start.y)] = 1
                    }
                }
            }
        }

        return raster
    }

    /// prints the raster
    func printRaster(_ raster: [Point : Int]) {
        let maxX = raster.keys.sorted(by: { $0.x > $1.x }).first!.x
        let maxY = raster.keys.sorted(by: { $0.y > $1.y }).first!.y

        for y in 0...maxY {
            var line = ""
            for x in 0...maxX {
                if let counter = raster[Point(x: x, y: y)] {
                    line += String(counter)
                } else {
                    line += "."
                }
            }
            print(line)
        }
    }

    /// The horizontal/vertical/diagonal raster
    var fullRaster: [Point : Int] {
        var raster: [Point : Int] = [:]

        for line in self {
            let deltaX = abs(line.end.x - line.start.x)
            let deltaY = abs(line.end.y - line.start.y)

            let stepX: Int
            if (line.end.x - line.start.x) < 0 {
                stepX = -1
            } else if (line.end.x - line.start.x) > 0 {
                stepX = 1
            } else {
                stepX = 0
            }

            let stepY: Int
            if (line.end.y - line.start.y) < 0 {
                stepY = -1
            } else if (line.end.y - line.start.y) > 0 {
                stepY = 1
            } else {
                stepY = 0
            }

            let steps = Swift.max(deltaX, deltaY)
            for i in 0...steps {
                let point = Point(x: line.start.x + i * stepX, y: line.start.y + i * stepY)
                if let curr = raster[point] {
                    raster[point] = curr + 1
                } else {
                    raster[point] = 1
                }

            }
        }

        return raster
    }
}
