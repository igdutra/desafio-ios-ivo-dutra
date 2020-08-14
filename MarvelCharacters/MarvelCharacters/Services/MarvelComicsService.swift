//
//  MarvelComicsService.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 14/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol MarvelComicsServiceProtocol {
    func requestComics(forCharacter id: Int, completion: @escaping ([Comic]?) -> Void)
    func fetchSingleImage(at url: URL, _ completion: @escaping (UIImage) -> Void)
}

/// Services Layer for MarvelCharacters
class MarvelComicsService: MarvelComicsServiceProtocol {

    // MARK: - Properties

    var baseMarvelPath: String
    var publicKey: String = ""
    var privateKey: String = ""
    var ts: String = ""
    var hash: String = ""
    var offset: Int

    // MARK: - Init

    init() {
        offset = 0 // Incremented each request
        baseMarvelPath = "https://gateway.marvel.com/v1/public/characters/{characterId}/comics"
        guard let publicKey = ProcessInfo.processInfo.environment["publicAPIKey"],
            let privateKey = ProcessInfo.processInfo.environment["privateAPIKey"] else { return }
        self.publicKey = publicKey
        self.privateKey = privateKey
        ts = NSDate().timeIntervalSince1970.description.replacingOccurrences(of: ".", with: "")
        hash = "\(ts)\(privateKey)\(publicKey)".md5
    }

    // MARK: - Request

    /// Request a list containing the specified comics from Marvel Universe
    func requestComics(forCharacter id: Int, completion: @escaping ([Comic]?) -> Void) {

        // This dictionary is used to construct the URL using URLComponents
        let query: [String: String] = [
           "ts": ts,
           "apikey": publicKey,
           "hash": hash,
           "offset": String(offset)
        ]

        let comicsPath = baseMarvelPath.replacingOccurrences(of: "{characterId}", with: String(id))
        let url = (URL(string: comicsPath)?.withQueries(query))!

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in

            let jsonDecoder = JSONDecoder()

            if let data = data {
                do {
                    let marvelAPI = try jsonDecoder.decode(MarvelComicsAPI.self, from: data)
                    guard let comics = marvelAPI.data?.results else { return }
                    completion(comics)
                } catch let err {
                    print(err, "\nError while decoding JSON")
                    completion(nil)
                }
            } else {
                print("No data returned")
                completion(nil)
            }

        }

        task.resume()
    }

    // MARK: - Fetch Image

    // OBS: Should be improved.

     /// Fetches one image.
    func fetchSingleImage(at url: URL, _ completion: @escaping (UIImage) -> Void) {

        // Request the image
        let imageTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else { return }

            // The image should be saved at the correct position from the images array
            completion(image)
        }

        imageTask.resume()
    }

}
