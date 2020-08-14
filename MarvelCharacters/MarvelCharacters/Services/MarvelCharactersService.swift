//
//  MarvelCharactersService.swift
//  MarvelCharacters
//
//  Created by Ivo Dutra on 12/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

protocol MarvelCharactersServiceProtocol {
    var offset: Int { get set }
    func requestCharacters(completion: @escaping ([Character]?) -> Void)
    func fetchSingleImage(at url: URL, _ completion: @escaping (UIImage) -> Void)
}

/// Services Layer for MarvelCharacters
class MarvelCharactersService: MarvelCharactersServiceProtocol {

    // MARK: - Properties

    let baseMarvelURL: URL
    var publicKey: String = ""
    var privateKey: String = ""
    var ts: String = ""
    var hash: String = ""
    var offset: Int

    // MARK: - Init

    init() {
        offset = 0 // Incremented each request
        baseMarvelURL = URL(string: "https://gateway.marvel.com/v1/public/characters")!
        guard let publicKey = ProcessInfo.processInfo.environment["publicAPIKey"],
            let privateKey = ProcessInfo.processInfo.environment["privateAPIKey"] else { return }
        self.publicKey = publicKey
        self.privateKey = privateKey
        ts = NSDate().timeIntervalSince1970.description.replacingOccurrences(of: ".", with: "")
        hash = "\(ts)\(privateKey)\(publicKey)".md5
    }

    // MARK: - Request

    /// Request a list containing characters from Marvel Universe
    func requestCharacters(completion: @escaping ([Character]?) -> Void) {

        // This dictionary is used to construct the URL using URLComponents
        let query: [String: String] = [
           "ts": ts,
           "apikey": publicKey,
           "hash": hash,
           "offset": String(offset)
        ]
        let url = baseMarvelURL.withQueries(query)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            // Handle Errors
            if let error = error {
                self.handleClientError(error)
                return
            }

            // Handle Response
            // 200-299 status codes are Successful responses
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }

            let jsonDecoder = JSONDecoder()

            if let data = data {
                do {
                    let marvelAPI = try jsonDecoder.decode(MarvelCharactersAPI.self, from: data)
                    guard let characters = marvelAPI.data?.results else { return }
                    completion(characters)
                } catch let err {
                    print(url)
                    print(err)
                }
            } else {
                print("No data returned")
                completion(nil)
            }

        }

        task.resume()
    }

    // MARK: - Fetch Image

     /// Fetches one image
    func fetchSingleImage(at url: URL, _ completion: @escaping (UIImage) -> Void) {

        // Request the image
        let imageTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else { return }

            // The image should be saved at the correct position from the images array
            completion(image)
        }

        imageTask.resume()
    }

    // MARK: - Errors

    func handleClientError(_ error: Error) {

    }

    func handleServerError(_ response: URLResponse?) {

    }

}
