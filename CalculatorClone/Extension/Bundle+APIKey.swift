//
//  Bundle+APIKey.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation

extension Bundle {
    static func getAPIKey(for openKey: String) -> String? {
        guard
            let url = Bundle.main.url(forResource: "ApiKey", withExtension: "plist"),
            let data = try? Data(contentsOf: url)
        else { print("ApiKey.plist not found"); return nil }
        
        do {
            if
                let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String],
                let apiKey = dict[openKey] {
                return apiKey
            } else {
                print("ApiKey[\(openKey)] not found"); return nil
            }
        } catch {
            print("Failed reading ApiKey.plist. \(error)"); return nil
        }
    }
}
