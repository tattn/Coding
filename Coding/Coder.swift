//
//  Coder.swift
//  Coding
//
//  Created by Tatsuya Tanaka on 2017/04/16.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

public class Encoder<Key: RawRepresentable> where Key.RawValue == String {
    private let coder: NSCoder

    init(coder: NSCoder) {
        self.coder = coder
    }

    public func encode(_ value: Archivable & UnArchivable, for key: Key) {
        coder.encode(value.archive(), forKey: key.rawValue)
    }

    public func encode(_ value: Any, for key: Key) {
        coder.encode(value, forKey: key.rawValue)
    }

    public func encode(_ value: Bool, for key: Key) {
        coder.encode(value, forKey: key.rawValue)
    }

    public func encode(_ value: Int, for key: Key) {
        coder.encode(value, forKey: key.rawValue)
    }

    public func encode(_ value: Float, for key: Key) {
        coder.encode(value, forKey: key.rawValue)
    }

    public func encode(_ value: Double, for key: Key) {
        coder.encode(value, forKey: key.rawValue)
    }

    public func encode(_ value: UnsafePointer<UInt8>?, length: Int, for key: Key) {
        coder.encodeBytes(value, length: length, forKey: key.rawValue)
    }
}

public class Decoder<Key: RawRepresentable> where Key.RawValue == String {
    private let coder: NSCoder

    init(coder: NSCoder) {
        self.coder = coder
    }

    public func contains(_ key: Key) -> Bool {
        return coder.containsValue(forKey: key.rawValue)
    }

    public func decode<T: UnArchivable>(for key: Key) -> T? {
        guard contains(key),
            let archivedData = coder.decodeObject(forKey: key.rawValue) as? Data else { return nil }
        return T.unarchive(with: archivedData)
    }

    public func decode<T: UnArchivable>(_ class: T.Type, for key: Key) -> T? {
        return decode(for: key)
    }

    public func decodeObject(for key: Key) -> Any? {
        return coder.decodeObject(forKey: key.rawValue)
    }

    public func decodeString(for key: Key) -> String? {
        return coder.decodeObject(forKey: key.rawValue) as? String
    }

    public func decodeBool(for key: Key) -> Bool {
        return coder.decodeBool(forKey: key.rawValue)
    }

    public func decodeInteger(for key: Key) -> Int {
        return coder.decodeInteger(forKey: key.rawValue)
    }

    public func decodeFloat(for key: Key) -> Float {
        return coder.decodeFloat(forKey: key.rawValue)
    }

    public func decodeDouble(for key: Key) -> Double {
        return coder.decodeDouble(forKey: key.rawValue)
    }
    
    public func decodeBytes(for key: Key) -> (UnsafePointer<UInt8>?, Int) {
        var length: Int = 0
        let pointer = coder.decodeBytes(forKey: key.rawValue, returnedLength: &length)
        return (pointer, length)
    }
}
