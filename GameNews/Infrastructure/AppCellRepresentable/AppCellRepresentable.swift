//
//  AppCellRepresentable.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import UIKit

public protocol AppCellRepresentable: class {
    static var nib: UINib { get }
    static var identifierCell: Identifierable { get }
}

public extension AppCellRepresentable {
    static var identifierValue: String {
        return identifierCell.identifierCell
    }
}
