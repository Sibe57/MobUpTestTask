//
//  PhotosCell.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 10.04.2022.
//
import SwiftyVK

class PhotosCell: UICollectionViewCell {
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = UIImage(named: "noImage")
    }
    
}
