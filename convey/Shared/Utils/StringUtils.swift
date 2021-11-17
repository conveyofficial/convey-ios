//
//  StringUtils.swift
//  convey (iOS)
//
//  Created by Galen Quinn on 11/16/21.
//

import Foundation

extension String {
    var numberOfWords: Int {
        var count = 0
        let range = startIndex..<endIndex
        enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })
        return count
    }
}
