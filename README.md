Coding
===

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Platform](https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20watchos%20%7C%20tvos-yellow.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
[![Swift Version](https://img.shields.io/badge/Swift-3-F16D39.svg)](https://developer.apple.com/swift)


Coding is more Swifty NSCoding.
It can archive even pure Swift class and struct.

# How to use

```swift
struct DataModel: Coding {
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
    
    static func decode(with decoder: Decoder<Key>) -> DataModel? {
        guard let string = decoder.decodeString(for: .string) else { return nil }
        let integer = decoder.decodeInteger(for: .integer)
        let double = decoder.decodeDouble(for: .double)
        return DataModel(string: string, integer: integer, double: double)
    }
}

let model: DataModel = DataModel(string: "Hello", integer: 123, double: 3.14)
let data: Data = model.archive()
let unarchivedModel: DataModel = DataModel.unarchive(with: data)
```

# Installation

## Carthage

```ruby
github "tattn/Coding"
```

# Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

# License

Coding is released under the MIT license. See LICENSE for details.
