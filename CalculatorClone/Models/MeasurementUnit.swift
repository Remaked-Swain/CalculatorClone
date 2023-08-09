//
//  MeasurementUnit.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/09.
//

import Foundation

@frozen enum MeasurementUnit {
    enum Area: CaseIterable {
        case squareMegameters, squareKilometers, squareMeters, squareCentimeters, squareMillimeters, squareMicrometers, squareNanometers, squareInches, squareFeet, squareYards, squareMiles, acres, ares, hectares
        
        var symbol: String {
            switch self {
            case .squareMegameters: return UnitArea.squareMegameters.symbol
            }
        }
        
        var description: String {
            switch self {
            case .squareMegameters: return "제곱 메가미터"
            }
        }
    }
}
