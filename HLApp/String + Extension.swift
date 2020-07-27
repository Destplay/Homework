//
//  String + Extension.swift
//  HLApp
//
//  Created by Роман on 04.06.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
    func toInt() -> Int {
        
        return Int(self) ?? 0
    }
    
    func toArray() -> Array<Int> {

        return self.compactMap(\.wholeNumberValue)
    }
    
    func isValidINN() -> Bool {
        guard let _ = Int(self) else { return false }
        guard self ~= "^([0-9]{10}|[0-9]{12})$" else { return false }

        if self.count == 10 {
            let intArray = self.toArray()
            let localValue = (((2 * intArray[0] + 4 * intArray[1] + 10 * intArray[2] +
                                3 * intArray[3] + 5 * intArray[4] + 9 * intArray[5] +
                                4 * intArray[6] + 6 * intArray[7] + 8 * intArray[8]) % 11) % 10)
            
            return intArray[9] == localValue
        }
        
        if self.count == 12 {
            let intArray = self.toArray()
            let localValueA = (((7 * intArray[0] + 2 * intArray[1] + 4 * intArray[2] +
                                 10 * intArray[3] + 3 * intArray[4] + 5 * intArray[5] +
                                 9 * intArray[6] + 4 * intArray[7] + 6 * intArray[8] +
                                 8 * intArray[9]) % 11) % 10)
            let localValueB = (((3 * intArray[0] + 7 * intArray[1] + 2 * intArray[2] +
                                 4 * intArray[3] + 10 * intArray[4] + 3 * intArray[5] +
                                 5 * intArray[6] + 9 * intArray[7] + 4 * intArray[8] +
                                 6 * intArray[9] + 8 * intArray[10]) % 11) % 10)
            return intArray[10] == localValueA && intArray[11] == localValueB
        }

        return false
    }
}
