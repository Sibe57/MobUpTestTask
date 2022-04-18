//
//  DetailViewController.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 12.04.2022.
//

import Kingfisher

class DetailViewController: UIViewController {
    
    var detailURL: String?
    var date: Double?
    var image: UIImage?
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImages()
        setDate()
        shareButton()
        zoomSetUp()
    }
    
    //set image to cell (from internet or cache if availible)
    func loadImages() {
        detailImageView.image = UIImage(named: "noImage")
        let url = URL(string: detailURL!)
        detailImageView.kf.setImage(with: url)
    }
    
    //set date on top of screen
    
    func setDate() {
        if let date = date {
            let date = Date(timeIntervalSince1970: date)
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM yyyy"
            title = formatter.string(from: date)
        } else { title = "Дата неизвестна"}
    }
        
    // create share Button with share func
    
    func shareButton() {
        let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItem = shareButton
    }
        
    @objc func shareAction() {
        guard let image = detailImageView.image else {fatalError("nil image")}
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            action, succes, _, _ in if action == .saveToCameraRoll && succes == true {
                self.successAlert()
            }
        }
        present(activityVC, animated: true, completion: nil)
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "Успех", message: "Сохранено в галлерее", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //zoom func in Scroll View
    
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
