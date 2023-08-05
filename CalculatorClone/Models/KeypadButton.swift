//
//  Digit.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/05.
//

import Foundation
import SwiftUI

// 숫자 키패드에 대해 열거, Int, CustomStringConvertible 프로토콜을 채택하여 Int 또는 String 타입의 원시값을 편하게 쓸 수 있음.
// CaseIterable 프로토콜을 채택하여 각 케이스마다 일련의 번호가 부여되는데 마침 이게 숫자 키패드 열거형이므로 Int형 원시값을 쓸 수가 있게 되는 것.
@frozen enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}

// 사칙연산 연산자 키패드에 대해 열거
@frozen enum Order: CustomStringConvertible {
    case add, subtract, multiply, divide
    
    var description: String {
        switch self {
        case .add: return "plus"
        case .subtract: return "minus"
        case .multiply: return "multiply"
        case .divide: return "divide"
        }
    }
}

// 계산기에서 누를 수 있는 키패드 버튼들에 대해 열거
// Hashable을 채택하여 각 버튼의 고유한 값을 부여한다는 것은 Identifiable 하다는 것이고, 키패드 값이 서로 중복되지 않는다는 것을 보장하는 셈이다.
@frozen enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case order(_ order: Order)
    case negative
    case percent
    case decimal
    case equal
    case allClear
    case clear
    
    var description: String {
        switch self {
        case .digit(let digit): return digit.description
        case .order(let order): return order.description
        case .negative: return "plus.forwardslash.minus"
        case .percent: return "percent"
        case .decimal: return "."
        case .equal: return "equal"
        case .allClear: return "AC"
        case .clear: return "C"
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .negative, .percent, .allClear, .clear: return .black
        default: return .white
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit, .decimal: return .secondary
        case .order, .equal: return .orange
        case .negative, .percent, .allClear, .clear: return Color(.lightGray)
        }
    }
}
