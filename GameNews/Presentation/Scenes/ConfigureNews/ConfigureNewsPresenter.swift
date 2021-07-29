//
//  ConfigureNewsPresenter.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

protocol ConfigureNewsPresentationLogic {
    func presentWebPages(data: [WebPagesModel])
}

class ConfigureNewsPresenter {
    weak var configureNewsViewController: ConfigureNewsDisplayLogic?
}

extension ConfigureNewsPresenter: ConfigureNewsPresentationLogic {
    func presentWebPages(data: [WebPagesModel]) {
        configureNewsViewController?.displayWebPageOptions(data: data)
    }
}
