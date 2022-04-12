//
//  PhotosViewController.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 09.04.2022.
//

import UIKit
import SwiftyVK


class PhotosViewController: UIViewController {

    var photos = [Photo]()
    let cellName = "photosCell"
    var photoCount: Int = 0
    var photosWasLoad = false
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    lazy var downloader = PhotoDownloader(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPhotos()
        photosCollectionView.register(PhotosCell.self, forCellWithReuseIdentifier: cellName)
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.reloadData()
        
        self.navigationItem.title = "Mobile Up Gallery"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        let logOutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logOut))
        logOutButton.tintColor = .label
        navigationItem.rightBarButtonItem = logOutButton

    }
    
    @objc func logOut () {
        VK.sessions.default.logOut()
        self.dismiss(animated: true)
    }
    
    
    func loadPhotos() {
        downloader.loadPhotos {(success: Bool) -> Void in
            if success {
                DispatchQueue.main.async {
                    self.photosWasLoad = true
                    self.photosCollectionView.reloadData()
                
                
            }}
        }
        
    }
    
    
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tryCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? PhotosCell
        guard let cell = tryCell else {
            fatalError("nil in cell")
        }
        
        guard photosWasLoad else {cell.cellImageView.image = UIImage(named: "noImage")
            return cell
        }
        cell.cellImageView.image = UIImage(named: "noImage")
        let urlString = self.photos[indexPath.row].hiResImage.url
        let url = URL(string: urlString)
        
        cell.cellImageView.downloaded(from: url!)
        cell.cellImageView.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widhtCell = (collectionView.frame.width / CGFloat(2)) - 1
        let heightCell = widhtCell

        return CGSize(width: widhtCell , height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.detailURL = self.photos[indexPath.row].hiResImage.url
        detailVC.date = photos[indexPath.row].date
        navigationItem.backButtonTitle = ""
        
        guard let navigationController = navigationController else {
            fatalError("nil Controller")
        }
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(detailVC, animated: true)
        
    }
    
    
}


