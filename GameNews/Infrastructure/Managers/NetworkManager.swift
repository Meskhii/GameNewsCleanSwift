//
//  NetworkManager.swift
//  GameNews
//
//  Created by Admin on 08.06.2021.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func get<T: Codable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in

            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print(error)
            }

        }.resume()
    }
}
