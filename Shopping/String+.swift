//
//  String+.swift
//  Shopping
//
//  Created by kmjmarine on 2022/06/02.
//

import Foundation

extension String {
    var htmlToString: String {
        guard let data = self.data(using: .utf8) else { return "" }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            ).string
        } catch {
            return ""
        }
    }
    
    var withComma: String {
        let value = Int(self)!
        
        let decimalFomatter = NumberFormatter()
        decimalFomatter.numberStyle = NumberFormatter.Style.decimal
        decimalFomatter.groupingSeparator = ","
        decimalFomatter.groupingSize = 3
        
        return decimalFomatter.string(from: NSNumber(value: value)) ??  self
    }
}
