//
//  ImageDownloader.swift
//  ImageDownloader
//
//  Created by Ahmed Henawey on 18/02/2020.
//  Copyright © 2020 Ahmed Henawey. All rights reserved.
//

import UIKit

protocol ImageLoading {
    func loadImage(for url: URL, name: String, compliation: @escaping (_ imageName: String, _ image: UIImage) -> ())
    func loadImage(for name: String) -> UIImage?
}

final class ImageLoader: ImageLoading {
    private let cacheManager: AnyCache<UIImage>
    private let apiClient: APIClient

    init(cacheManager: AnyCache<UIImage>, apiClient: APIClient) {
        self.cacheManager = cacheManager
        self.apiClient = apiClient
    }

    func loadImage(for url: URL, name: String, compliation: @escaping (_ imageName: String, _ image: UIImage) -> ()) {

        if let image = cacheManager.get(key: name) {
            compliation(name, image)
            return
        }

        apiClient.dataTask(with: url) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }

            if let data = data, httpResponse.statusCode == 200 {
                if httpResponse.url?.absoluteString == url.absoluteString {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)!
                        self?.cacheManager.set(key: name, type: image)
                        compliation(name, image)
                    }
                }
            } else {
                print("error")
            }
        }.resume()
    }

    func loadImage(for name: String) -> UIImage? {
        return cacheManager.get(key: name)
    }
}
