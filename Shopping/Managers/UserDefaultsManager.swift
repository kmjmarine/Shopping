//
//  UserDefaultsManager.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/03.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getShops() -> [Shop]
    func addShop(_ newValue: Shop)
    func removeShop(_ value: Shop)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case shop
    }
    
    func getShops() -> [Shop] {
        guard let data = UserDefaults.standard.data(forKey: Key.shop.rawValue) else { return [ ] }
        
        return (try? PropertyListDecoder().decode([Shop].self, from: data)) ?? [ ]
    }
    
    func addShop(_ newValue: Shop) {
        var currentShops: [Shop] = getShops()
        currentShops.insert(newValue, at: 0)
        
        saveMovie(currentShops)
    }
    
    func removeShop(_ value: Shop) {
        let currentShops: [Shop] = getShops()
        let newValue = currentShops.filter { $0.title != value.title }
        
        saveMovie(currentShops)
    }
    
    private func saveMovie(_ newValue: [Shop]) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(newValue),
            forKey: Key.shop.rawValue
        )
    }
}
