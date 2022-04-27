//
//  PhotosViewController.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 09.04.2022.
//

import SwiftyVK
import Kingfisher


class PhotosViewController: UIViewController {

    var photos = [Photo]()
    var photosHaveBeenLoaded = false
    let cellName = "photosCell"
    lazy var downloader = PhotoDownloader(viewController: self)
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up Collection View
        setUpCollectionView()
        
        //Set Up navigationBar
        setUpNavBar()
        
        //Async get photos
        DispatchQueue.global(qos: .userInitiated).async {
            self.loadPhotos()
        }

    }
    
    func setUpCollectionView() {
        photosCollectionView.register(PhotosCell.self, forCellWithReuseIdentifier: cellName)
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.reloadData()
    }
    
    func setUpNavBar() {
        self.navigationItem.title = "Mobile Up Gallery"
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        let logOutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(logOut))
        logOutButton.tintColor = .label
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    // VK logOut
    
    @objc func logOut () {
        VK.sessions.default.logOut()
        self.dismiss(animated: true)
    }
    
    //Get photos' URL from JSON
    
    func loadPhotos() {
        downloader.loadPhotos {(success: Bool) -> Void in
            if success
                {
                DispatchQueue.main.async {
                    self.photosHaveBeenLoaded = true
                    self.photosCollectionView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "Не удается скачать фото", message: "Проверьте подключение к сети Интренет", preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "OK", style: .default)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! PhotosCell
        
        //set image to cell (from internet or cache if availible)
        cell.cellImageView.image  = UIImage(named: "noImage")
        if photosHaveBeenLoaded {
            let url = URL(string: photos[indexPath.row].hiResImage.url)
            cell.cellImageView.kf.setImage(with: url)
            cell.cellImageView.contentMode = .scaleAspectFill

        }
        return cell
    }
    
    // set size of cell
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widhtCell = (collectionView.frame.width / CGFloat(2)) - 1
        let heightCell = widhtCell

        return CGSize(width: widhtCell , height: heightCell)
    }
    
    
    //send data to detail controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.detailURL = self.photos[indexPath.row].hiResImage.url
        detailVC.date = photos[indexPath.row].date
        detailVC.photosCount = photos.count
        detailVC.photos = photos
        navigationItem.backButtonTitle = ""
        
        guard let navigationController = navigationController else {
            fatalError("nil Controller")
        }
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(detailVC, animated: true)
    }
}
