//
//  UnitType.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/12.
//

import Foundation

@frozen enum UnitType: String, CaseIterable, CustomStringConvertible {
    case acceleration, angle, area, concentrationMass, dispersion, duration, electricCharge, electricCurrent, electricPotentialDifference, electricResistance, energy, frequency, fuelEfficiency, illuminance, informationStorage, length, mass, power, pressure, speed, temperature, volume
    
    var units: Dimension.Type {
        switch self {
        case .acceleration: return UnitAcceleration.self
        case .angle: return UnitAngle.self
        case .area: return UnitArea.self
        case .concentrationMass: return UnitConcentrationMass.self
        case .dispersion: return UnitDispersion.self
        case .duration: return UnitDuration.self
        case .electricCharge: return UnitElectricCharge.self
        case .electricCurrent: return UnitElectricCurrent.self
        case .electricPotentialDifference: return UnitElectricPotentialDifference.self
        case .electricResistance: return UnitElectricResistance.self
        case .energy: return UnitEnergy.self
        case .frequency: return UnitFrequency.self
        case .fuelEfficiency: return UnitFuelEfficiency.self
        case .illuminance: return UnitIlluminance.self
        case .informationStorage: return UnitInformationStorage.self
        case .length: return UnitLength.self
        case .mass: return UnitMass.self
        case .power: return UnitPower.self
        case .pressure: return UnitPressure.self
        case .speed: return UnitSpeed.self
        case .temperature: return UnitTemperature.self
        case .volume: return UnitVolume.self
        }
    }
    
    var description: String {
        switch self {
        case .acceleration: return "가속도"
        case .angle: return "각도"
        case .area: return "면적"
        case .concentrationMass: return "질량 농도"
        case .dispersion: return "분산"
        case .duration: return "시간"
        case .electricCharge: return "전하량"
        case .electricCurrent: return "전류"
        case .electricPotentialDifference: return "전위 차이"
        case .electricResistance: return "전기 저항"
        case .energy: return "에너지"
        case .frequency: return "주파수"
        case .fuelEfficiency: return "연료 효율"
        case .illuminance: return "조도"
        case .informationStorage: return "정보 저장"
        case .length: return "길이"
        case .mass: return "질량"
        case .power: return "전력"
        case .pressure: return "압력"
        case .speed: return "속도"
        case .temperature: return "온도"
        case .volume: return "부피"
        }
    }
}
