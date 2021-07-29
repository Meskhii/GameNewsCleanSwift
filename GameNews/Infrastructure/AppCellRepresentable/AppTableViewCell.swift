//
//  AppTableViewCell.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import UIKit

open class AppTableViewCell: UITableViewCell, AppCellRepresentable {
    open weak var dataProvider: AppCellDataProvider?
    weak var delegate: NewsDelegate?

    open class var nib: UINib {
        return UINib(nibName: className, bundle: Bundle(for: self))
    }

    open class var identifierCell: Identifierable {
        return "unknown"
    }
}
