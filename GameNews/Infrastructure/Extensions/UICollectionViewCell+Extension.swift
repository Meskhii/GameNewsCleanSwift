//
//  UICollectionViewCell+Extension.swift
//  GameNews
//
//  Created by Admin on 30.05.2021.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
