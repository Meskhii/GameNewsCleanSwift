//
//  UITableView+Extension.swift
//  GameNews
//
//  Created by Admin on 30.05.2021.
//

import UIKit

extension UITableView {

    func registerClass<T: UITableViewCell>(class: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.cellIdentifier)
    }

    func registerNib<T: UITableViewCell>(class: T.Type) {
        self.register(T.nib(), forCellReuseIdentifier: T.cellIdentifier)
    }

    func registerHeaderFooterNib<T: UIView>(class: T.Type) {
        let name = String(describing: self)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }

    func deque<T: UITableViewCell>(class: T.Type, for indexpath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexpath) as! T // swiftlint:disable:this force_cast

    }

}

extension UITableView: UITableViewDequauable {
    public func dequeueReusable(dataProvider: AppCellDataProvider, for indexPath: IndexPath) -> AppTableViewCell {
        return dequeueReusableCell(withIdentifier: dataProvider.identifierCell, for: indexPath) as! AppTableViewCell // swiftlint:disable:this force_cast
    }

    public func dequeueReusable(dataProvider: AppCellDataProvider) -> AppTableViewCell {
        return dequeueReusableCell(withIdentifier: dataProvider.identifierCell) as! AppTableViewCell // swiftlint:disable:this force_cast
    }

    open func dequeueReusable<T: AppTableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifierValue, for: indexPath) as! T // swiftlint:disable:this force_cast
    }

    open func dequeueReusable<T: AppTableViewCell>(cell: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.identifierValue) as? T
    }
}

extension UITableView {
    public func register(types: AppTableViewCell.Type...) {
        register(types: types.map { $0 })
    }

    public func register(types: [AppTableViewCell.Type]) {
        types.forEach {
            register($0.nib, forCellReuseIdentifier: $0.identifierValue)
        }
    }
}
