//
//  Presenter.swift
//  ImageDownloader
//
//  Created by Ahmed Henawey on 18/02/2020.
//  Copyright © 2020 Ahmed Henawey. All rights reserved.
//

import UIKit

protocol Presenting {
    var numberOfRows: Int { get }
    func downloadImage(for indexPath: IndexPath)
    func imageCellForIndexPath(_ indexPath: IndexPath, from tableView: UITableView) -> ImageTableViewCell
}

final class Presenter: Presenting {
    weak var view: Viewing?

    private let baseImageURL = "https://homepages.cae.wisc.edu/~ece533/images/"
    private let images = ["airplane", "arctichare", "baboon", "barbara", "boat", "cat", "fruits", "frymire", "girl", "goldhill", "lenacolor", "monarch", "mountain", "peppers", "pool", "sails", "serrano", "tulips", "watch", "zelda"]
    private let `extension` = "png"
    
    private let imageLoader: ImageLoading

    init(imageLoader: ImageLoading) {
        self.imageLoader = imageLoader
    }

    private func imageWithExtension(imageName: String, `extension`: String) -> String {
        return imageName + "." + `extension`
    }

    var numberOfRows: Int {
        images.count
    }

    private func imageURL(for imageName: String) -> URL? {
        return URL(string: baseImageURL + imageName)
    }
    
    func downloadImage(for indexPath: IndexPath) {
        let imageName = images[indexPath.row]
        let fullName = imageWithExtension(imageName: imageName, extension: `extension`)
        guard let url = imageURL(for: fullName) else { return }
        imageLoader.loadImage(for: url, name: imageName) { [weak self] dowloadedImageName, image  in
            if imageName == dowloadedImageName {
                self?.view?.reloadIndexPath(indexPath)
            }
        }
    }

    func imageCellForIndexPath(_ indexPath: IndexPath, from tableView: UITableView) -> ImageTableViewCell {
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell
        if images.indices.contains(indexPath.row) {
            let imageName = images[indexPath.row]
            let image = imageLoader.loadImage(for: imageName)
            imageCell.configure(image: image)
        }
        return imageCell
    }
}
