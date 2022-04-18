//
//  ViewController.swift
//  MobileUp's test task
//
//  Created by Федор Еронин on 07.04.2022.
//

import SwiftyVK


class AuthViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        authButton.layer.cornerRadius = 8
        authButton.layer.masksToBounds = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if VK.sessions.default.accessToken != nil {
            self.photosShow()
        }
    }
    
    
    func auth() {
        DispatchQueue.global().async {
            VK.sessions.default.logIn(
                onSuccess: { _ in
                    DispatchQueue.main.async {
                        self.photosShow()
                    }
                },
                onError: {_ in DispatchQueue.main.async {
                    self.loginAlert()
                    }
                }
            )
        }
    }
    
    func photosShow() {
        let root = PhotosViewController(nibName: "PhotosView", bundle: nil)
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func loginAlert() {
            let alert = UIAlertController(title: "Ошибка авторизации", message: "Авторзация отменена", preferredStyle: .alert)
            let alertOK = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertOK)
            self.present(alert, animated: true, completion: nil)
    }

    @IBAction func authButtonAction(_ sender: UIButton) {
        if VK.sessions.default.accessToken == nil {
                    auth()
        } else {}
    }
    
}
