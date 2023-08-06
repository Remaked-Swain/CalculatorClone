//
//  ExchangeRateModule.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation
import Combine

class ExchangeRateModule {
    @Published var exchangeRateModel: ExchangeRateModel?
    
    private var subscription: Cancellable?
    
    private let openKey: String = "EXCHANGE_RATE_API"
    
    init() {
        loadData()
    }
    
    private func checkFileManager() {
        
    }
    
    func loadData(base: CurrencyCode.RawValue = "KRW") {
        guard let apiKey = Bundle.getAPIKey(for: openKey) else { return }
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(base)") else { return }
        
        subscription = NetworkingManager.download(url: url)
            .decode(type: ExchangeRateModel.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] receivedExchangeRateModel in
                    self?.exchangeRateModel = receivedExchangeRateModel
                    self?.subscription?.cancel()
                })
    }
}
