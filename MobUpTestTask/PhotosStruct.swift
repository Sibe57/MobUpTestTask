//
//  File.swift
//  MobUpTestTask
//
//  Created by Федор Еронин on 09.04.2022.
//

import Foundation


struct Photo: Decodable {
    let date: Double
    let data: [PhotoData]
    
    var hiResImage: PhotoData {
        var max = 0
        var index = 0
        for i in data.indices {
            if data[i].width > max {
                max = data[i].width
                index = i
            }
        }
        return data[index]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Double.self, forKey: .date)
        data = try container.decode([PhotoData].self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case data = "sizes"
    }
}

struct PhotoData: Decodable {
    let height: Int
    let width: Int
    let url: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        url = try container.decode(String.self, forKey: .url)
    }
    
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url
    }
    
}

struct ResponseReciver: Decodable {
    
    let items: [Photo]
    let count: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Photo].self, forKey: .items)
        count = try container.decode(Int.self, forKey: .count)
        
    }
    enum CodingKeys: String, CodingKey {
        case items
        case count
        
    }
    
}
