//
//  APIClient.swift
//  ImageDownloader
//
//  Created by Ahmed Henawey on 18/02/2020.
//  Copyright © 2020 Ahmed Henawey. All rights reserved.
//

import Foundation

protocol APIClient {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancelable
}

protocol Cancelable {
    func resume()
}

extension URLSession: APIClient {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancelable {
        let task: URLSessionDataTask = dataTask(with: url, completionHandler: completionHandler)
        return task
    }
}

extension URLSessionDataTask: Cancelable {}
