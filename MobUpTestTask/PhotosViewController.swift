//
//  PhotosViewController.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 09.04.2022.
//

import UIKit
import SwiftyVK
import WebKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class PhotosViewController: UIViewController {


    @IBOutlet weak var myPhoto: UIImageView!
    var photos = [Photo]()
    lazy var downloader = PhotoDownloader(viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPhotos()

        // Do any additional setup after loading the view.
    }
    
    func loadPhotos() {
        downloader.loadPhotos {(success: Bool) -> Void in
            if success {DispatchQueue.main.async {
                let urlString = self.photos[0].hiResImage.url
                let url = URL(string: urlString)
                self.myPhoto.downloaded(from: url!)
            }}
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
