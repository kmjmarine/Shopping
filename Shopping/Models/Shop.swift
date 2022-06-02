//
//  Shop.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/02.
//

import Foundation

struct Shop: Codable {
    let title: String
//    let link: String
    private let image: String
//    let lprice: Int
//    let hprice: Int
//    let mallName: String
//    let maker: String
//    let brand: String
    
    var isLiked: Bool
    
    var imageURL: URL? { URL(string: image) }

    private enum CodingKeys: String, CodingKey {
        case title, image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        
        isLiked = false
    }
    
    init(
        title: String,
        imageURL: String,
        isLiked: Bool = false
    ) {
        self.title = title
        self.image = imageURL
        self.isLiked = isLiked
    }
}
