//
//  PhotoDownloader.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 09.04.2022.
//

import SwiftyVK

class PhotoDownloader {
    
    //Create instanse of ViewController
    var myVC: PhotosViewController
    
    //Set Up JSON request
    
    let ownerID = "-128666765"
    let albumID = "266276915"
    let photoSizes = "1"
    let rev = "0"
    
    
    
    init (viewController: PhotosViewController) {
        myVC = viewController
    }
    
    enum RequestError: Error {
        case networkError
        case parsingError
    }
    
    //Get and parse JSON from VK
    
    func photoRequest(completion: @escaping (Result<Bool, RequestError>) -> Void) {
        VK.API.Photos.get([
            .ownerId: ownerID,
            .albumId: albumID,
            .photoSizes: photoSizes,
            .rev: rev
        ]).onSuccess {response in
                do {
           let responseDecoded = try JSONDecoder().decode(ResponseReciver.self, from: response)
            self.myVC.photos = responseDecoded.items
                    completion(.success(true))
                } catch let parsingError {
                    completion(.failure(.parsingError))
                    print("parsingError \(#function): \(parsingError)" )
                    
                }
            }.onError { error in
                print("Request failed with: \(error)")
                completion(.failure(.networkError))
            }.send()
            
    }
    
    func loadPhotos(completion: @escaping (Bool) -> Void) {
        photoRequest {result in
            switch result {
            case let .failure(error):
                print("Error loading photos \(#function):\(error)")
                completion(false)
            case .success:
                    completion(true)
            }
        }
    }
}
