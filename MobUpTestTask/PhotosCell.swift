//
//  PhotosCell.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 10.04.2022.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no Image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

