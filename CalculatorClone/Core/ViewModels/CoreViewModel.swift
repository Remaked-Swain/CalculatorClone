//
//  CoreViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/05.
//

import Foundation
import Combine

final class CoreViewModel: ObservableObject {
    @Published private var module = CalcModule()
    
    var displayText: String { return module.displayText }
    
    var keypads: [[ButtonType]] {
        let clearButtonType: ButtonType = module.showAllClear ? .allClear : .clear
        return [
            [clearButtonType, .negative, .percent, .order(.divide)],
            [.digit(.seven), .digit(.eight), .digit(.nine), .order(.multiply)],
            [.digit(.four), .digit(.five), .digit(.six), .order(.subtract)],
            [.digit(.one), .digit(.two), .digit(.three), .order(.add)],
            [.digit(.zero), .decimal, .equal]
        ]
    }
    
    func buttonTapped(for buttonType: ButtonType) {
        switch buttonType {
        case .digit(let digit): module.inputDigit(digit)
        case .order(let order): module.inputOrder(order)
        case .negative: module.inputNegative()
        case .percent: module.inputPercent()
        case .decimal: module.inputDecimal()
        case .equal: module.evaluate()
        case .allClear: module.allClear()
        case .clear: module.clear()
        }
    }
    
    func orderButtonIsHighlighted(buttonType: ButtonType) -> Bool {
        // Swift의 열거형에 대한 패턴매칭 문법을 활용한 것으로 버튼 타입에 따라 분기처리
        // 입력된 버튼이 Order타입이 아니라면 false 반환,
        // Order타입이 입력된 것이 맞다면 연산자 버튼을 강조 표시하기 위해 만든 메서드로 전달해줌
        guard case .order(let order) = buttonType else { return false }
        return module.orderButtonIsHighlighted(order)
    }
}
