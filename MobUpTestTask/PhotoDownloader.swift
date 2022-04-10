//
//  PhotoDownloader.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 09.04.2022.
//

import Foundation
import SwiftyVK
import UIKit

class PhotoDownloader {
    var myVC: PhotosViewController
    
    let ownerID = "46598070"
    let albumID = "profile"
    let photoSizes = "1"
    let rev = "1"
    
    
    
    init (viewController: PhotosViewController) {
        myVC = viewController
    }
    
    enum RequestError: Error {
        case networkError
        case parsingError
    }
    
    func photoRequest(completion: @escaping (Result<Bool, RequestError>) -> Void) {
        print("sending")
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
    
    

    
    


