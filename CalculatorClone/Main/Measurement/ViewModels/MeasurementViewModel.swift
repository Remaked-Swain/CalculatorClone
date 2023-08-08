//
//  MeasurementViewModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/08.
//

import Foundation

class MeasurementViewModel: ObservableObject {
    @Published var baseMeasurement: Measurement = Measurement(value: 0, unit: UnitLength.meters)
}
