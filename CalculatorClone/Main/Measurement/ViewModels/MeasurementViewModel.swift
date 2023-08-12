//
//  MeasurementViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/11.
//

import Foundation
import Combine

class MeasurementViewModel: ObservableObject {
    @Published var selectedUnitType: UnitType = .area
    @Published var selectableUnitList: [Dimension] = []
    @Published var baseUnit: Dimension?
    @Published var baseUnitAmount: Double = 0
    @Published var comparisonUnit: Dimension?
    @Published var comparisonUnitAmount: Double = 0
    
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
        $selectedUnitType
            .sink { [weak self] receiveUnitType in
                self?.selectableUnitList = receiveUnitType.unitList
                self?.baseUnit = receiveUnitType.unitList.first
                self?.comparisonUnit = receiveUnitType.unitList.first
            }
            .store(in: &cancellables)
        
        $baseUnitAmount
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] receiveAmount in
                guard let self = self, let baseUnit = baseUnit, let comparisonUnit = comparisonUnit else { return }
                self.comparisonUnitAmount = convertUnit(receiveAmount, baseUnit, comparisonUnit)
            }
            .store(in: &cancellables)
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

// MARK: Internal Methods
extension MeasurementViewModel {
    func selectUnitType(_ unitType: UnitType) {
        self.selectedUnitType = unitType
    }
    
    func selectBaseUnit(_ dimension: Dimension) {
        self.baseUnit = dimension
    }
    
    func selectComparisonUnit(_ dimension: Dimension) {
        self.comparisonUnit = dimension
    }
}

// MARK: Private Methods
extension MeasurementViewModel {
    private func convertUnit(_ amount: Double, _ baseUnit: Dimension, _ comparisonUnit: Dimension) -> Double {
        let baseMeasurement = Measurement(value: amount, unit: baseUnit)
        return baseMeasurement.converted(to: comparisonUnit).value
    }
    
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
