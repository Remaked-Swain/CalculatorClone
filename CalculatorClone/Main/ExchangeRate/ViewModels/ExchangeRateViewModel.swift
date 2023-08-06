//
//  ExchangeRateViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation

class ExchangeRateViewModel: ObservableObject {
    @Published var baseCurrency: CurrencyCode = .KRW
    @Published var textField: String = ""
    @Published var comparisonCurrency: CurrencyCode = .USD
}
