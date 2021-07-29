//
//  ConfigureNewsWorker.swift
//  GameNews
//
//  Created by Admin on 10.06.2021.
//

import Foundation

class ConfigureNewsWorker {

    func mockFetchedWebPages() -> [WebPagesModel] {

        var mockData = [WebPagesModel]()

        mockData.append(WebPagesModel(webPageLogo: "ign_logo",
                                       webPageName: "IGN News",
                                       isWebPageChecked: true))

        mockData.append(WebPagesModel(webPageLogo: "eurogamer_logo",
                                       webPageName: "Eurogamer",
                                       isWebPageChecked: true))

        mockData.append(WebPagesModel(webPageLogo: "gameinformer_logo",
                                       webPageName: "Gameinformer",
                                       isWebPageChecked: true))

        mockData.append(WebPagesModel(webPageLogo: "gamespot_logo",
                                       webPageName: "Gamespot",
                                       isWebPageChecked: true))

        mockData.append(WebPagesModel(webPageLogo: "pcgamer_logo",
                                       webPageName: "PCGamer",
                                       isWebPageChecked: true))

        return mockData
    }

}
