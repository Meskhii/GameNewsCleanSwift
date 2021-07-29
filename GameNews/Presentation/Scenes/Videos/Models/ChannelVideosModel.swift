//
//  ChannelVideosModel.swift
//  GameNews
//
//  Created by Admin on 09.06.2021.
//

import Foundation

struct ChannelVideosModel: Codable {
    let items: [ChannelSnippet?]
}

struct ChannelSnippet: Codable {
    let snippet: ChannelSnippetItems?
}

struct ChannelSnippetItems: Codable {
    let title: String?
    let thumbnails: ChannelThumbnails?
    let resourceId: ChannelResourceId?
}

struct ChannelResourceId: Codable {
    let videoId: String?
}

struct ChannelThumbnails: Codable {
    let imgUrl: ChannelVideoImageUrl?

    private enum CodingKeys: String, CodingKey {
        case imgUrl = "medium"
    }
}

struct ChannelVideoImageUrl: Codable {
    let url: String?
}
