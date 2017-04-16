//
//  Coding.swift
//  Coding
//
//  Created by Tatsuya Tanaka on 2017/04/16.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public protocol Coding: Archivable, UnArchivable {
    associatedtype Key: RawRepresentable
    func encode<T>(with coder: Encoder<T>) where T == Key, Key.RawValue == String
    static func decode<T>(with decoder: Decoder<Key>) -> Self? where T == Key, Key.RawValue == String
}

extension Coding where Self.Key.RawValue == String {
    private var proxy: CodingProxy<Self> {
        return CodingProxy(object: self)
    }

    func archive() -> Data {
        NSKeyedArchiver.setClassName(String(describing: type(of: self)), for: CodingProxy<Self>.self)
        return NSKeyedArchiver.archivedData(withRootObject: proxy)
    }

    static func unarchive(with data: Data) -> Self? {
        NSKeyedUnarchiver.setClass(CodingProxy<Self>.self, forClassName: String(describing: self))
        return (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as NSData) as? CodingProxy<Self>)??.object
    }
}
