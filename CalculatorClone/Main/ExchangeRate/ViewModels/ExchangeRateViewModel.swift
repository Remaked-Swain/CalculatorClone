//
//  ExchangeRateViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation
import Combine

class ExchangeRateViewModel: ObservableObject {
    @Published var baseCurrency: CurrencyCode = .KRW
    @Published var baseCurrencyAmount: Double = 0
    @Published var comparisonCurrency: CurrencyCode = .USD
    @Published var convertedCurrencyAmount: Double = 0
    @Published var exchangeRateModel: ExchangeRateModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let module = ExchangeRateModule()
    
    var keypads: [[ButtonType]] {
        return [
            [.allClear, .negative, .percent],
            [.digit(.seven), .digit(.eight), .digit(.nine)],
            [.digit(.four), .digit(.five), .digit(.six)],
            [.digit(.one), .digit(.two), .digit(.three)],
            [.digit(.zero), .decimal]
        ]
    }
    
    init() {
        addSubscription()
    }
    
    private func addSubscription() {
        module.$exchangeRateModel
            .sink { [weak self] receivedExchangeRateModel in
                self?.exchangeRateModel = receivedExchangeRateModel
            }
            .store(in: &cancellables)
        
        // 사용자가 환율에 따른 통화량 계산을 위해 textField를 조작할 경우 변화를 감지하고 환율계산하는 메서드가 호출, 계산결과를 저장
        $baseCurrencyAmount
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] receiveAmount in
                guard let self = self, let convertAmount = self.convertAmount(amount: receiveAmount, baseCurrencyCode: baseCurrency.rawValue, comparisonCurrencyCode: comparisonCurrency.rawValue) else { return }
                self.convertedCurrencyAmount = convertAmount
            }
            .store(in: &cancellables)
    }
}

extension ExchangeRateViewModel {
    func convertAmount(amount: Double, baseCurrencyCode: CurrencyCode.RawValue, comparisonCurrencyCode: CurrencyCode.RawValue) -> Double? {
        // 환율표에서 환율정보를 가져오기, 실패하면 nil 반환
        guard let baseRate = exchangeRateModel?.conversionRates?[baseCurrencyCode],
              let comparisonRate = exchangeRateModel?.conversionRates?[comparisonCurrencyCode]
        else { return nil }
        
        // 환율정보가 확인되었으니 환전 시 금액을 계산하여 반환
        let convertedAmount = amount * (comparisonRate / baseRate)
        return convertedAmount
    }
    
    func buttonTapped(for buttonType: ButtonType) {
        
    }
}
