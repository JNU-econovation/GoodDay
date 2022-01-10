//
//  CSVParser.swift
//  GoodDay
//
//  Created by 임채승 on 2022/01/09.
//

import Foundation

class CSVParser {
    func parseCSV(filePath: String) {
        let fileManager = FileManager()
        do {
            let contents = try fileManager.contents(atPath: filePath)
            print(contents)
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
}
