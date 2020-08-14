//
//  MarvelCharacterAPI.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype

// MARK: - MarvelAPI

/// Struct based on the Marvel's public characters API
struct MarvelCharactersAPI: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Character]?
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }

    // Get image URL
    func getImageURL() -> URL? {
        guard let thumbnailExtension = self.thumbnail.thumbnailExtension?.rawValue else { return nil }
        let httpsPath = self.thumbnail.path.replacingOccurrences(of: "http", with: "https")
        // Load only portrait_medium images
        return URL(string: (httpsPath + "/portrait_medium." + thumbnailExtension))
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]?
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]?
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: ItemType?
}

enum ItemType: String, Codable {
    case ad = "ad"
    case backcovers = "backcovers"
    case cover = "cover"
    case interiorStory = "interiorStory"
    case pinup = "pinup"
    case recap = "recap"
    case textArticle = "text article"
    // Default case for unknown cases
    case empty = ""
}

// So that a Unknown case do not crash the application
extension ItemType {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        // Convert current possible itemType to string
        let rawMaterial = try container.decode(String.self)
        // Try to initialize enum with its rawValue.
        // Case not listed, return empty
        self = ItemType(rawValue: rawMaterial) ?? .empty
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// RawValue is used, deactivate swiftLint rule
enum Extension: String, Codable {
    // swiftlint:disable redundant_string_enum_value
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
    // swiftlint:enable redundant_string_enum_value
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType?
    let url: String
}

enum URLType: String, Codable {
    case comiclink
    case detail
    case wiki
}
