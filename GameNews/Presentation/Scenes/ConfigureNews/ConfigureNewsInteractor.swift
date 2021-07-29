//
//  ConfigureNewsInteractor.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import Foundation

protocol ConfigureNewsBusinessLogic {
    func fetchWebPageOptions()
}

class ConfigureNewsInteractor {
    var presenter: ConfigureNewsPresentationLogic?
}

extension ConfigureNewsInteractor: ConfigureNewsBusinessLogic {
    func fetchWebPageOptions() {
        var worker: ConfigureNewsWorker!
        var webPageOptions = [WebPagesModel]()

        worker = ConfigureNewsWorker()

        webPageOptions = worker.mockFetchedWebPages()

        presenter?.presentWebPages(data: webPageOptions)
    }
}
