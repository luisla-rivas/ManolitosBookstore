//
//  Extension+helper.swift
//  ManolitosBookstore
//
//  Created by Luis Lasierra on 24/2/23.
//

import SwiftUI

extension Color {
    static var launchColor: Color { Color("launchBackgroundColor") }
    static var myBackgroundColor: Color { Color("backgroundYellow") }
    static var myPriceColor: Color { Color("priceColor") }
    static var myBackgroundBlue: Color { Color("backgroundBlue") }
    static var myBackgroundPink: Color { Color("backgroundPink") }
    static var myBackgroundPurple: Color { Color("backgroundPurple") }
}


extension String {
    static let kUserMail = "userMail"
    static let kUserPwd = "userPwd"
}
 
extension Double? {
//    var euroFormat: String? {
//        let formatter = NumberFormatter()
//        formatter.currencyCode = Currency.eur.rawValue
//        formatter.minimumFractionDigits = 2
//        formatter.maximumFractionDigits = 2
//        formatter.decimalSeparator = ","
//        formatter.groupingSeparator = "."
//        return formatter.string(from: NSNumber(value: self))
//    }
    
    var inEuro: String {
        let formatter = NumberFormatter ( )
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ES-es")//.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        if let num = formatter.string(from: NSNumber(value: self ?? 0.0)) {
            return num
        } else {
            return "-"+formatter.currencySymbol
        }
    }
}

enum Currency: String, Codable {
    case eur
    case usd
}


extension DateFormatter {
    static let iso8601:DateFormatter = {
        let df = DateFormatter()
        //df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // "2021-02-05T18:40:55"
        df.dateFormat =  "yyyyMMdd'T'HHmmssZ"// "2021-02-05T18:40:55"
        return df
    }()
    
    static let short:DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale.current
        df.dateStyle = .medium
        df.dateStyle = .none
        return df
    }()
}
