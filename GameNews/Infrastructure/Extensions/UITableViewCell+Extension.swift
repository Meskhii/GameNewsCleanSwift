//
//  UITableViewCell+Extension.swift
//  GameNews
//
//  Created by Admin on 30.05.2021.
//

import UIKit

extension UITableViewCell {

    static var cellIdentifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }

}
