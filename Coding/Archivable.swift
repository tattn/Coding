//
//  Archivable.swift
//  Coding
//
//  Created by Tatsuya Tanaka on 2017/04/16.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public protocol Archivable {
    func archive() -> Data
}

public protocol UnArchivable {
    static func unarchive(with data: Data) -> Self?
}
