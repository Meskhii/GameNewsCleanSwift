//
//  UITableViewDequauable.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import UIKit

public protocol UITableViewDequauable {
    func dequeueReusable(dataProvider: AppCellDataProvider, for indexPath: IndexPath) -> AppTableViewCell
    func dequeueReusable<T: AppTableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T
    func dequeueReusable<T: AppTableViewCell>(cell: T.Type) -> T?
}
