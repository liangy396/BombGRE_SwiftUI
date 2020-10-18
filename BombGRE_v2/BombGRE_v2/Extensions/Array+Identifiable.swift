//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Liang Yang on 4/16/20.
//  Copyright © 2020 Liang Yang. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
