//
//  BookmarksRouter.swift
//  GameNews
//
//  Created by user200006 on 6/14/21.
//

import UIKit
import SafariServices

protocol BookmarksRoutingLogic {
    func openSelectedNewsInWebView(articleURL: String)
}

class BookmarksRouter {
    weak var viewController: UIViewController?
}

extension BookmarksRouter: BookmarksRoutingLogic {
    func openSelectedNewsInWebView(articleURL: String) {
        let selectedArticleURL = URL(string: articleURL)!
        let safariVC = SFSafariViewController(url: selectedArticleURL)

        viewController?.present(safariVC, animated: true)
    }
}
