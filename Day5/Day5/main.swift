//
//  main.swift
//  Day5
//
//  Created by Michiel Horvers on 05/12/2021.
//

import Foundation

let lines = Line.load(from: rawInput)

// MARK: - Part 1

var raster = lines.raster
var dangerPoints = raster.filter({ $0.value >= 2 })
print("--- Part 1 ---\nDangerous points: \(dangerPoints.count)\n")

// MARK: - Part 2

raster = lines.fullRaster
//lines.printRaster(raster)
dangerPoints = raster.filter({ $0.value >= 2 })
print("--- Part 2---\nDangerous points: \(dangerPoints.count)")
