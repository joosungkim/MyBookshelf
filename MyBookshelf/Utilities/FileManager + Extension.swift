//
//  FileManager + Extension.swift
//  MyBookshelf
//
//  Created by JS Kim on 2021/04/04.
//

import Foundation

extension FileManager {
    static var documentDirectoryURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

