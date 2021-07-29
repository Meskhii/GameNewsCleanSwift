//
//  GamespotCellDataProvider.swift
//  GameNews
//
//  Created by Admin on 25.07.2021.
//

import UIKit

protocol NewsCellDataProvider: AppCellDataProvider {
    var title: String? { get }
    var imgURL: String? { get }
    var postTime: String? { get }
    var hrefURL: String? { get }
    var isBookmarked: Bool? { get set }
    var webPageLogo: String? { get }
    var webPageName: String? { get }
    var webPageURL: String? { get }
}
