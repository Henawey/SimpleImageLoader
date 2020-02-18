//
//  ImageTableViewCell.swift
//  ImageDownloader
//
//  Created by Ahmed Henawey on 18/02/2020.
//  Copyright © 2020 Ahmed Henawey. All rights reserved.
//

import UIKit

final class ImageTableViewCell: UITableViewCell {
    private lazy var iconImageView: UIImageView = UIImageView()

    override func prepareForReuse() {
        iconImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage?) {
        iconImageView.image = image
    }
}
