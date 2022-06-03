//
//  Shop.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/02.
//

import Foundation

struct Shop: Codable {
    let title: String
    let link: String
    private let image: String
    let lprice: String
    let hprice: String
    let mallName: String
    let maker: String
    let brand: String
    
    var isLiked: Bool
    
    var imageURL: URL? { URL(string: image) }

    private enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName, maker, brand
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? "-"
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        lprice = try container.decodeIfPresent(String.self, forKey: .lprice) ?? "0"
        hprice = try container.decodeIfPresent(String.self, forKey: .hprice) ?? "0"
        mallName = try container.decodeIfPresent(String.self, forKey: .mallName) ?? "-"
        maker = try container.decodeIfPresent(String.self, forKey: .maker) ?? ""
        brand = try container.decodeIfPresent(String.self, forKey: .brand) ?? ""
        
        isLiked = false
    }
    
    init(
        title: String,
        link: String,
        imageURL: String,
        lprice: String,
        hprice: String,
        mallName: String,
        maker: String,
        brand: String,
        isLiked: Bool = false
    ) {
        self.title = title
        self.link = link
        self.image = imageURL
        self.lprice = lprice
        self.hprice = hprice
        self.mallName = mallName
        self.maker = maker
        self.brand = brand
        self.isLiked = isLiked
    }
}
