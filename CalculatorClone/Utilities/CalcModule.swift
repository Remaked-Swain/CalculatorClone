//
//  CalcModule.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/05.
//

import Foundation

struct CalcModule {
    // 사칙연산 산술표현식
    private struct ArithmeticExpression: Equatable {
        var firstOperand: Decimal
        var order: Order
        
        func evaluate(with secondOperand: Decimal) -> Decimal {
            switch order {
            case .add: return firstOperand + secondOperand
            case .subtract: return firstOperand - secondOperand
            case .multiply: return firstOperand * secondOperand
            case .divide: return firstOperand / secondOperand
            }
        }
    }
    
    // CalcModule State
    private var isNegative: Bool = false
    private var isDecimal: Bool = false
    private var isClearPressed: Bool = false
    private var zeroCount: Int = 0
    private var containsDecimal: Bool { return displayText.contains(".") }
    
    // 작성 중인 값을 나타내는 변수로, didSet을 이용해 변화를 감지하는데 그냥 작성되고 있을 경우에는 상태도 초기화
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            isNegative = false
            isDecimal = false
            isClearPressed = false
            zeroCount = 0
        }
    }
    
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    
    var showAllClear: Bool {
        // clear버튼이 눌린 상태이거나
        // 작성 중인 값도, 입력돼있는 연산자도, 계산했던 결과도 없는 초기상태면 allClear버튼 노출
        newNumber == nil && expression == nil && result == nil || isClearPressed
    }
    
    private var number: Decimal? {
        // clear버튼이 눌린 상태이거나 소수점 상태면 작성 중인 값을 반환
        guard isClearPressed || isDecimal else {
            // 아니라면 작성 중인 값, 1주소 피연산자, 계산결과값 중 우선순 하나를 반환
            // 작성 중인 값이 없다면 1주소 피연산자, 1주소 피연산자도 없다면 결과값을 화면에 보여주겠다는 의미
            return newNumber ?? expression?.firstOperand ?? result
        }
        
        return newNumber
    }
    
    var displayText: String {
        // 작성 중인 값(newNumber), 1주소 피연산자(ArithmeticExpression.firstOperand), 계산결과값(result) 중
        // 사인 상태에 맞는 값을 문자열로 변환해둠
        return convertNumberToString(for: number, withCommas: true)
    }
    
    private func convertNumberToString(for number: Decimal?, withCommas: Bool = false) -> String {
        var str = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
        
        if isNegative { str.insert("-", at: str.startIndex) } // 음수 상태면 "-" 사인 추가
        if isDecimal { str.insert(".", at: str.endIndex) } // 소수점 상태면 "." 사인 추가
        if zeroCount > 0 { str.append(String(repeating: "0", count: zeroCount)) } // 0 개수만큼 뒤에 붙혀주기
        
        return str
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        // 처리할 숫자가 없거나 입력된 숫자가 0이 아니면 true
        return number != nil || digit != .zero
    }
    
    mutating func inputDigit(_ digit: Digit) {
        if containsDecimal && digit == .zero {
            // 소수점 상태인데 0이 입력되면 zeroCount를 올려서 소수점 0자리 이어붙히게 됨
            zeroCount += 1
        } else if canAddDigit(digit) {
            // 0이 아닌 다른 숫자가 입력되면 그냥 작성 중이던 값에 그 숫자를 이어붙힘
            let str = convertNumberToString(for: newNumber)
            newNumber = Decimal(string: str.appending("\(digit.rawValue)"))
        }
    }
    
    mutating func inputOrder(_ order: Order) {
        // 작성 중이던 값을 가져오거나, 작성 중이던 값이 없으면 최근 계산결과를 가져옴
        guard var number = newNumber ?? result else { return }
        
        // 최근 수행한 연산이 있다면 동일한 연산을 수행
        if let currentExpression = expression {
            number = currentExpression.evaluate(with: number)
        }
        
        // 수행한 연산을 저장하고 1주소에 저장, 그리고 작성 중이던 값은 새로운 피연산자를 받기위해 초기화
        expression = ArithmeticExpression(firstOperand: number, order: order)
        newNumber = nil
    }
    
    mutating func inputNegative() {
        // 작성 중이던 값이 있으면 부호를 바꿔서 저장
        if let number = newNumber { newNumber = -number; return }
        
        // 작성 중이던 값이 없으면, 다음 순위인 최근 계산결과를 부호를 바꿔서 저장
        if let number = result { result = -number; return }
        
        isNegative.toggle()
    }
    
    mutating func inputPercent() {
        // 작성 중이던 값이 있으면 백분화하고 저장
        if let number = newNumber { newNumber = number / 100; return }
        
        // 작성 중이던 값이 없으면, 다음 순위인 최근 계산결과를 백분화하고 저장
        if let number = result { result = number / 100; return }
    }
    
    mutating func inputDecimal() {
        // 이미 소수점을 포함한 상태면 무시하고, 아니면 소수점 상태로 변경해서 "."이 찍히게 함
        if containsDecimal { return }
        isDecimal = true
    }
    
    mutating func evaluate() {
        // 작성 중인 값이 없거나, 연산자가 입력되지 않았다면 무시됨
        guard let number = newNumber, let currentExpression = expression else { return }
        
        // 아니라면 계산 후 결과를 저장하고 계산에 사용한 자원을 초기화
        // expression, newNumber가 nil이 된다는 것은 displayText에 표시할 자원이 3순위였던 result가 된다는 뜻
        result = currentExpression.evaluate(with: number)
        expression = nil
        newNumber = nil
    }
    
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        isNegative = false
        isDecimal = false
        zeroCount = 0
    }
    
    mutating func clear() {
        newNumber = nil
        isNegative = false
        isDecimal = false
        zeroCount = 0
        isClearPressed = true
    }
    
    mutating func dragDisplayTextToRemove() {
        guard let number = newNumber, number != 0 else { return }
        let arr = Array(convertNumberToString(for: number)).map {String($0)}
        let newStr = arr[arr.startIndex..<arr.endIndex - 1].joined()
        newNumber = Decimal(string: newStr)
    }
    
    internal func orderButtonIsHighlighted(_ order: Order) -> Bool {
        // 작성 중인 값이 없는 상태에서 현재 입력되어 있는 연산자와 지금 입력한 연산자가 같으면 그 연산자가 입력되어 있다고 강조 표시 할 수 있게 됨
        return newNumber == nil && expression?.order == order
    }
}
