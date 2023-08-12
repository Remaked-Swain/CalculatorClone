//
//  UnitType.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/12.
//

import Foundation

@frozen enum UnitType: String, CaseIterable, CustomStringConvertible {
    case acceleration, angle, area
//    concentrationMass, dispersion, duration, electricCharge, electricCurrent, electricPotentialDifference, electricResistance, energy, frequency, fuelEfficiency, illuminance, informationStorage, length, mass, power, pressure, speed, temperature, volume
    
    var unitList: [Dimension] {
        switch self {
        case .acceleration: return Acceleration.allCases.map {$0.unit}
        case .angle: return Angle.allCases.map {$0.unit}
        case .area: return Area.allCases.map {$0.unit}
        }
    }
    
    var description: String {
        switch self {
        case .acceleration: return "가속도"
        case .angle: return "각도"
        case .area: return "면적"
//        case .concentrationMass: return "질량 농도"
//        case .dispersion: return "분산"
//        case .duration: return "시간"
//        case .electricCharge: return "전하량"
//        case .electricCurrent: return "전류"
//        case .electricPotentialDifference: return "전위 차이"
//        case .electricResistance: return "전기 저항"
//        case .energy: return "에너지"
//        case .frequency: return "주파수"
//        case .fuelEfficiency: return "연료 효율"
//        case .illuminance: return "조도"
//        case .informationStorage: return "정보 저장"
//        case .length: return "길이"
//        case .mass: return "질량"
//        case .power: return "전력"
//        case .pressure: return "압력"
//        case .speed: return "속도"
//        case .temperature: return "온도"
//        case .volume: return "부피"
        }
    }
    
    @frozen enum Acceleration: CaseIterable {
        case metersPerSecondSquared, gravity
        
        var unit: UnitAcceleration {
            switch self {
            case .metersPerSecondSquared: return .metersPerSecondSquared
            case .gravity: return .gravity
            }
        }
    }
    
    @frozen enum Angle: CaseIterable {
        case degrees, arcMinutes, arcSeconds, radians, gradians, revolutions
        
        var unit: UnitAngle {
            switch self {
            case .degrees: return .degrees
            case .arcMinutes: return .arcMinutes
            case .arcSeconds: return .arcSeconds
            case .radians: return .radians
            case .gradians: return .gradians
            case .revolutions: return .revolutions
            }
        }
    }
    
    @frozen enum Area: CaseIterable {
        case squareMegameters, squareKilometers, squareMeters, squareCentimeters, squareMillimeters, squareMicrometers, squareNanometers, squareInches, squareFeet, squareYards, squareMiles, acres, ares, hectares
        
        var unit: UnitArea {
            switch self {
            case .squareMegameters: return .squareMegameters
            case .squareKilometers: return .squareKilometers
            case .squareMeters: return .squareMeters
            case .squareCentimeters: return .squareCentimeters
            case .squareMillimeters: return .squareMillimeters
            case .squareMicrometers: return .squareMicrometers
            case .squareNanometers: return .squareNanometers
            case .squareInches: return .squareInches
            case .squareFeet: return .squareFeet
            case .squareYards: return .squareYards
            case .squareMiles: return .squareMiles
            case .acres: return .acres
            case .ares: return .ares
            case .hectares: return .hectares
            }
        }
    }
}
