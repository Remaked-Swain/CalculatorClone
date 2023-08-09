//
//  MeasurementViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/08.
//

import Foundation

class MeasurementViewModel: ObservableObject {
    @Published var selectedType: UnitType = .length
    
    var keypads: [[ButtonType]] {
        return [
            [.digit(.seven), .digit(.eight), .digit(.nine)],
            [.digit(.four), .digit(.five), .digit(.six)],
            [.digit(.one), .digit(.two), .digit(.three)],
            [.digit(.zero), .decimal, .allClear]
        ]
    }
}
