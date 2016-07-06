//
//  File.swift
//  SnowFlake
//
//  Created by Romain Pouclet on 2016-07-05.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Foundation

protocol FileType {
    var path: String { get }
    var hash: String? { get }
}

struct File: FileType {
    let path: String
    let hash: String?
}

func ==<T: FileType>(lhs: T, rhs: T) -> Bool {
    return lhs.hash == rhs.hash
}