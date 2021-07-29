//
//  SelectedGameNewsPresenter.swift
//  GameNews
//
//  Created by Admin on 07.06.2021.
//

import Foundation

protocol SelectedGameNewsPresentationLogic: AnyObject {
    func presentSelectedGameNews(with data: [GameNewsModel])
}

class SelectedGameNewsPresenter {
    weak var selectedGameNewsViewController: SelectedGameNewsDisplayLogic?
}

extension SelectedGameNewsPresenter: SelectedGameNewsPresentationLogic {
    func presentSelectedGameNews(with data: [GameNewsModel]) {
        selectedGameNewsViewController?.display(data: data)
    }
}
