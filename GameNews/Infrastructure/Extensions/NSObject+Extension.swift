//
//  NSObject+Extension.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import Foundation

extension NSObject {
    public var className: String {
        return String(describing: type(of: self))
    }

    public class var className: String {
        return String(describing: self)
    }
}
