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
            [.digit(.seven), .digit(.eight), .digit(.nine)],
            [.digit(.four), .digit(.five), .digit(.six)],
            [.digit(.one), .digit(.two), .digit(.three)],
            [.digit(.zero), .decimal, .allClear]
        ]
    }
    
    private var containsDecimal: Bool { return strAmount.contains(".") }
    
    private var strAmount: String = "0" {
        didSet {
            guard let amount = convertStringToDouble(strAmount) else { return }
            baseCurrencyAmount = amount
        }
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
        
        // 사용자가 환율에 따른 통화량 계산을 위해 baseCurrencyAmount를 조작할 경우 변화를 감지하고 환율계산하는 메서드가 호출, 계산결과를 저장
        $baseCurrencyAmount
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] receiveAmount in
                guard let self = self, let convertAmount = self.convertAmount(amount: receiveAmount, baseCurrencyCode: baseCurrency.rawValue, comparisonCurrencyCode: comparisonCurrency.rawValue) else { return }
                self.convertedCurrencyAmount = convertAmount
            }
            .store(in: &cancellables)
    }
}

// MARK: Internal Methods
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
        switch buttonType {
        case .digit(let digit): inputDigit(digit: digit);
        case .decimal: inputDecimal();
        case .allClear: inputAllClear();
        default: return
        }
    }
}

// MARK: Private Methods
extension ExchangeRateViewModel {
    private func convertStringToDouble(_ str: String) -> Double? {
        guard let number = Double(str) else { return nil }
        return number
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        // 이미 0인데 0이 들어오지만 않으면 true
        return strAmount != "0" && digit != .zero
    }
    
    private func inputDigit(digit: Digit) {
        if containsDecimal && digit == .zero {
            // 소수점 상태인데 0이 입력되면 zeroCount를 올려서 소수점 0자리 이어붙히게 됨
            strAmount += "0"
        } else if canAddDigit(digit) {
            // 0이 아닌 다른 숫자가 입력되면 그냥 작성 중이던 값에 그 숫자를 이어붙힘
            strAmount += digit.description
        }
    }
    
    private func inputDecimal() {
        // 이미 소수점을 포함한 상태면 무시하고, 아니면 "."이 찍히게 함
        if containsDecimal { return }
        strAmount += "."
    }
    
    private func inputAllClear() {
        strAmount = "0"
    }
}
