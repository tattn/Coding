//
//  CodingProxy.swift
//  Coding
//
//  Created by Tatsuya Tanaka on 2017/04/16.
//  Copyright © 2017年 tattn. All rights reserved.
//

import Foundation

class CodingProxy<Base: Coding>: NSObject, NSCoding where Base.Key.RawValue == String {
    let object: Base

    init(object: Base) {
        self.object = object
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        object.encode(with: Encoder(coder: aCoder))
    }

    required init?(coder aDecoder: NSCoder) {
        guard let object = Base.decode(with: Decoder(coder: aDecoder)) else { return nil }
        self.object = object
        super.init()
    }
}
