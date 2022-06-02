//
//  ShopRequestModel.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/02.
//

import Foundation

struct ShopRequestModel: Codable {
    let start: Int
    let display: Int
    let query: String
}
