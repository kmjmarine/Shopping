//
//  ShopSearchManager.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/02.
//

import Foundation
import Alamofire

protocol ShopSearchManagerProtocol {
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping([Shop]) -> Void
    )
}

struct ShopSearchManager: ShopSearchManagerProtocol {
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([Shop]) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/shop.json") else { return }
        
        let parameters = ShopRequestModel(start: start, display: display, query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id" : "YFZn4OE569U0SPwcG8XS",
            "X-Naver-Client-Secret" : "_9hmNuGhH7"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseDecodable(of: ShopResponseModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.items)
            case .failure(let error):
                print(error)
            }
        }
        .resume()
    }
}
