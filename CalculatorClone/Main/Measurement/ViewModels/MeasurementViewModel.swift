//
//  MeasurementViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/11.
//

import Foundation
import Combine

class MeasurementViewModel: ObservableObject {
    @Published var baseUnitAmount: Double = 0
    @Published var comparisonAmount: Double = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    private var containsDecimal: Bool { return strAmount.contains(".") }
    
    private var strAmount: String = "0" {
        didSet {
            guard let amount = convertStringToDouble(strAmount) else { return }
            baseUnitAmount = amount
        }
    }
    
    var keypads: [[ButtonType]] {
        return [
            [.digit(.seven), .digit(.eight), .digit(.nine)],
            [.digit(.four), .digit(.five), .digit(.six)],
            [.digit(.one), .digit(.two), .digit(.three)],
            [.digit(.zero), .decimal, .allClear]
        ]
    }
    
    init() {
        addSubscription()
    }
    
    private func addSubscription() {
        
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
extension MeasurementViewModel {
    private func convertStringToDouble(_ str: String) -> Double? {
        guard let number = Double(str) else { return nil }
        return number
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        // 0인데 0이 입력되는 상황만 아니면 true
        return strAmount != "0" || digit != .zero
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
