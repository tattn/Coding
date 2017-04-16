//
//  CodingTests.swift
//  CodingTests
//
//  Created by Tatsuya Tanaka on 2017/04/16.
//  Copyright © 2017年 tattn. All rights reserved.
//

import XCTest
@testable import Coding

class CodingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testArchiveSimpleStruct() {
        struct SimpleStruct: Coding {
            let string: String
            let integer: Int
            let double: Double
            
            enum Key: String {
                case string
                case integer
                case double
            }
            
            func encode(with coder: Encoder<Key>) {
                coder.encode(string, for: .string)
                coder.encode(integer, for: .integer)
                coder.encode(double, for: .double)
            }
            
            static func decode(with decoder: Decoder<Key>) -> SimpleStruct? {
                guard let string = decoder.decodeString(for: .string) else { return nil }
                let integer = decoder.decodeInteger(for: .integer)
                let double = decoder.decodeDouble(for: .double)
                return SimpleStruct(string: string, integer: integer, double: double)
            }
        }
        
        let simpleStruct = SimpleStruct(string: "Hello", integer: 123, double: 3.14)
        let data = simpleStruct.archive()
        let result = SimpleStruct.unarchive(with: data)
        
        XCTAssertEqual(simpleStruct.string, result?.string)
        XCTAssertEqual(simpleStruct.integer, result?.integer)
        XCTAssertEqual(simpleStruct.double, result?.double)
    }
    
    func testArchiveStructInStruct() {
        struct Parent: Coding {
            struct Child: Coding {
                let string: String
                let integer: Int
                let double: Double
                
                enum Key: String {
                    case string
                    case integer
                    case double
                }
                
                func encode(with coder: Encoder<Key>) {
                    coder.encode(string, for: .string)
                    coder.encode(integer, for: .integer)
                    coder.encode(double, for: .double)
                }
                
                static func decode(with decoder: Decoder<Key>) -> Child? {
                    guard let string = decoder.decodeString(for: .string) else { return nil }
                    let integer = decoder.decodeInteger(for: .integer)
                    let double = decoder.decodeDouble(for: .double)
                    return Child(string: string, integer: integer, double: double)
                }
            }
            
            let child: Child
            
            enum Key: String {
                case child
            }
            
            func encode(with coder: Encoder<Key>) {
                coder.encode(child, for: .child)
            }
            
            static func decode(with decoder: Decoder<Key>) -> Parent? {
                guard let child = decoder.decode(Parent.Child.self, for: .child) else { return nil }
                return Parent(child: child)
            }
        }
        
        let child = Parent.Child(string: "Hello", integer: 123, double: 3.14)
        let parent = Parent(child: child)
        let data = parent.archive()
        let result = Parent.unarchive(with: data)
        
        XCTAssertEqual(parent.child.string, result?.child.string)
        XCTAssertEqual(parent.child.integer, result?.child.integer)
        XCTAssertEqual(parent.child.double, result?.child.double)
    }
}
