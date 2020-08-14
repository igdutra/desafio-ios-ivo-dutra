//
//  MarvelComicsAPI.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 14/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

// This file was generated from JSON Schema using quicktype

import Foundation

// This file was generated from JSON Schema using quicktype

// MARK: - MarvelComicsAPI
struct MarvelComicsAPI: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Comic]?
}

// MARK: - Result
struct Comic: Codable {
    let id, digitalID: Int
    let title: String
    let issueNumber: Int
    let variantDescription: VariantDescription
    let resultDescription: String?
    let modified, isbn, upc, diamondCode: String
    let ean: String
    let issn: Issn
    let format: Format
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants, collections, collectedIssues: [Series]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    let characters: Characters
    let stories: Stories
    let events: Characters

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        // swiftlint:disable line_length
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
        // swiftlint:enable  line_length
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]
    let returned: Int
}

// MARK: - Series
struct Series: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: DateType
    let date: String
}
// swiftlint:disable redundant_string_enum_value
enum DateType: String, Codable {
    case digitalPurchaseDate = "digitalPurchaseDate"
    case focDate = "focDate"
    case onsaleDate = "onsaleDate"
    case unlimitedDate = "unlimitedDate"
}

enum Format: String, Codable {
    case comic = "Comic"
    case hardcover = "Hardcover"
    case tradePaperback = "Trade Paperback"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// Extension defined at MarvelCharactersAPI

enum Issn: String, Codable {
    case empty = ""
    case the15498638 = "1549-8638"
    case the19325266 = "1932-5266"
    case the25740628 = "2574-0628"
}

// MARK: - Price
struct Price: Codable {
    let type: PriceType
    let price: Double
}

enum PriceType: String, Codable {
    case digitalPurchasePrice = "digitalPurchasePrice"
    case printPrice = "printPrice"
}

// MARK: - Stories

// Stories, StoriesItem and ItemType defined at MarvelCharactersAPI

// MARK: - TextObject
struct TextObject: Codable {
    let type: TextObjectType
    let language: Language
    let text: String
}

enum Language: String, Codable {
    case enUs = "en-us"
}

enum TextObjectType: String, Codable {
    case issuePreviewText = "issue_preview_text"
    case issueSolicitText = "issue_solicit_text"
    case the70ThWinnerDesc = "70th_winner_desc"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case detail = "detail"
    case inAppLink = "inAppLink"
    case purchase = "purchase"
    case reader = "reader"
}
// swiftlint:enable redundant_string_enum_value

enum VariantDescription: String, Codable {
    case davidFinchGatefoldVariant = "David Finch Gatefold Variant"
    case empty = ""
    case humbertoRamosWraparoundVariant = "Humberto Ramos Wraparound Variant"
}
