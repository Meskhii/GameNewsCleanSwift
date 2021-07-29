//
//  Identifierable.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import Foundation

public protocol Identifierable {
    var identifierCell: String { get }
}

extension String: Identifierable {
    public var identifierCell: String {
        return self
    }
}
