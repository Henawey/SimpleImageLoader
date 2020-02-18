//
//  ViewController.swift
//  ImageDownloader
//
//  Created by Ahmed Henawey on 18/02/2020.
//  Copyright © 2020 Ahmed Henawey. All rights reserved.
//

import UIKit

protocol Viewing: AnyObject {
    func reloadIndexPath(_ indexPath: IndexPath)
}

final class ViewController: UITableViewController, Viewing {
    var presenter: Presenting!

    static func build() -> ViewController {
        let viewController = ViewController(style: .plain)
        let cache = AnyCache(cache: MemoryCache())
        let imageLoader = ImageLoader(cacheManager: cache, apiClient: URLSession.shared)
        let presenter = Presenter(imageLoader: imageLoader)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }

    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.rowHeight = 150
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
    }

    func reloadIndexPath(_ indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { presenter.numberOfRows }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { presenter.downloadImage(for: indexPath) }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         presenter.imageCellForIndexPath(indexPath, from: tableView)
    }
}
