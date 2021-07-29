//
//  SteamNewsRouter.swift
//  GameNews
//
//  Created by Admin on 06.06.2021.
//

import UIKit

protocol SteamSearchGameRoutingLogic {
    func navigateToSelectedGameNews(with appId: String)
}

class SteamSearchGameRouter {
    weak var viewController: UIViewController?
}

extension SteamSearchGameRouter: SteamSearchGameRoutingLogic {

    func navigateToSelectedGameNews(with appId: String) {
        let storyboard = UIStoryboard(name: VCIds.selectedGameNewsVC, bundle: nil)
        guard let selectedGameNewsVC = storyboard.instantiateViewController(identifier: VCIds.selectedGameNewsVC) as? SelectedGameNewsViewController else {return}

        selectedGameNewsVC.appId = appId

        viewController?.navigationController?.pushViewController(selectedGameNewsVC, animated: true)
    }

}
