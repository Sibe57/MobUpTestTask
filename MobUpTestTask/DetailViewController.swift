//
//  DetailViewController.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 12.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailURL: String?
    var date: Double?
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
        setDate()
        shareButton()
        zoomSetUp()

        
    }
    
    
    func loadImages() {
        detailImageView.image = UIImage(named: "noImage")
        if let detailURL = detailURL, let detailURL  = URL(string: detailURL) {
            detailImageView.downloaded(from: detailURL, contentMode: .scaleAspectFill)
        }
    }
    
    func setDate() {
        if let date = date {
            let date = Date(timeIntervalSince1970: date)
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM yyyy"
            title = formatter.string(from: date)
        } else { title = "Дата неизвестна"}
    }
        
        
    func shareButton() {
        let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItem = shareButton
    }
        
    @objc func shareAction() {
        guard let image = detailImageView.image else {fatalError("nil image")}
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            _, succes, _, _ in if succes == true {
                self.successAlert()
                
            }
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    func successAlert() {
        let alert = UIAlertController(title: nil, message: "Успешно сохранено", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func zoomSetUp() {
        detailScrollView.delegate = self
        detailScrollView.minimumZoomScale = 1.0
        detailScrollView.maximumZoomScale = 2.5
        detailScrollView.bouncesZoom = false
        detailScrollView.bounces = false
    }
    
}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImageView
    }
}
