//
//  UnitType.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/12.
//

import Foundation

@frozen enum UnitType: String, CaseIterable, CustomStringConvertible {
    case acceleration, angle, area, concentrationMass, duration, electricCharge, electricCurrent, electricPotentialDifference, electricResistance, energy, frequency, fuelEfficiency, informationStorage, length, mass, power, pressure, speed, temperature, volume
    
    var unitList: [Dimension] {
        switch self {
        case .acceleration: return Acceleration.allCases.map {$0.unit}
        case .angle: return Angle.allCases.map {$0.unit}
        case .area: return Area.allCases.map {$0.unit}
        case .concentrationMass: return ConcentrationMass.allCases.map {$0.unit}
        case .duration: return Duration.allCases.map {$0.unit}
        case .electricCharge: return ElectricCharge.allCases.map {$0.unit}
        case .electricCurrent: return ElectricCurrent.allCases.map {$0.unit}
        case .electricPotentialDifference: return ElectricPotentialDifference.allCases.map {$0.unit}
        case .electricResistance: return ElectricResistance.allCases.map {$0.unit}
        case .energy: return Energy.allCases.map {$0.unit}
        case .frequency: return Frequency.allCases.map {$0.unit}
        case .fuelEfficiency: return FuelEfficiency.allCases.map {$0.unit}
        case .informationStorage: return InformationStorage.allCases.map {$0.unit}
        case .length: return Length.allCases.map {$0.unit}
        case .mass: return Mass.allCases.map {$0.unit}
        case .power: return Power.allCases.map {$0.unit}
        case .pressure: return Pressure.allCases.map {$0.unit}
        case .speed: return Speed.allCases.map {$0.unit}
        case .temperature: return Temperature.allCases.map {$0.unit}
        case .volume: return Volume.allCases.map {$0.unit}
        }
    }
    
    var description: String {
        switch self {
        case .acceleration: return "가속도"
        case .angle: return "각도"
        case .area: return "면적"
        case .concentrationMass: return "질량 농도"
        case .duration: return "시간"
        case .electricCharge: return "전하량"
        case .electricCurrent: return "전류"
        case .electricPotentialDifference: return "전위 차이"
        case .electricResistance: return "전기 저항"
        case .energy: return "에너지"
        case .frequency: return "주파수"
        case .fuelEfficiency: return "연료 효율"
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
    
    @frozen enum ConcentrationMass: CaseIterable {
        case gramsperLiter, milligramsPerDeciliter
        
        var unit: UnitConcentrationMass {
            switch self {
            case .gramsperLiter: return .gramsPerLiter
            case .milligramsPerDeciliter: return .milligramsPerDeciliter
            }
        }
    }
    
    @frozen enum Duration: CaseIterable {
        case hours, minutes, seconds, milliseconds, microseconds, nanoseconds, picoseconds
        
        var unit: UnitDuration {
            switch self {
            case .hours: return .hours
            case .minutes: return .minutes
            case .seconds: return .seconds
            case .milliseconds: return .milliseconds
            case .microseconds: return .microseconds
            case .nanoseconds: return .nanoseconds
            case .picoseconds: return .picoseconds
            }
        }
    }
    
    @frozen enum ElectricCharge: CaseIterable {
        case coulombs, megaampereHours, kiloampereHours, ampereHours, milliampereHours, microampereHours
        
        var unit: UnitElectricCharge {
            switch self {
            case .coulombs: return .coulombs
            case .megaampereHours: return .megaampereHours
            case .kiloampereHours: return .kiloampereHours
            case .ampereHours: return .ampereHours
            case .milliampereHours: return .milliampereHours
            case .microampereHours: return .microampereHours
            }
        }
    }
    
    @frozen enum ElectricCurrent: CaseIterable {
        case megaamperes, kiloamperes, amperes, milliamperes, microamperes
        
        var unit: UnitElectricCurrent {
            switch self {
            case .megaamperes: return .megaamperes
            case .kiloamperes: return .kiloamperes
            case .amperes: return .amperes
            case .milliamperes: return .milliamperes
            case .microamperes: return .microamperes
            }
        }
    }
    
    @frozen enum ElectricPotentialDifference: CaseIterable {
        case megavolts, kilovolts, volts, millivolts, microvolts
        
        var unit: UnitElectricPotentialDifference {
            switch self {
            case .megavolts: return .megavolts
            case .kilovolts: return .kilovolts
            case .volts: return .volts
            case .millivolts: return .millivolts
            case .microvolts: return .microvolts
            }
        }
    }
    
    @frozen enum ElectricResistance: CaseIterable {
        case megaohms, kiloohms, ohms, milliohms, microohms
        
        var unit: UnitElectricResistance {
            switch self {
            case .megaohms: return .megaohms
            case .kiloohms: return .kiloohms
            case .ohms: return .ohms
            case .milliohms: return .milliohms
            case .microohms: return .microohms
            }
        }
    }
    
    @frozen enum Energy: CaseIterable {
        case kilojoules, joules, kilocalories, calories, kilowattHours
        
        var unit: UnitEnergy {
            switch self {
            case .kilojoules: return .kilojoules
            case .joules: return .joules
            case .kilocalories: return .kilocalories
            case .calories: return .calories
            case .kilowattHours: return .kilowattHours
            }
        }
    }
    
    @frozen enum Frequency: CaseIterable {
        case terahertz, gigahertz, megahertz, kilohertz, hertz, millihertz, microhertz, nanohertz
        
        var unit: UnitFrequency {
            switch self {
            case .terahertz: return .terahertz
            case .gigahertz: return .gigahertz
            case .megahertz: return .megahertz
            case .kilohertz: return .kilohertz
            case .hertz: return .hertz
            case .millihertz: return .millihertz
            case .microhertz: return .microhertz
            case .nanohertz: return .nanohertz
            }
        }
    }
    
    @frozen enum FuelEfficiency: CaseIterable {
        case litersPer100Kilometers, milesPerGallon, milesPerImperialGallon
        
        var unit: UnitFuelEfficiency {
            switch self {
            case .litersPer100Kilometers: return .litersPer100Kilometers
            case .milesPerGallon: return .milesPerGallon
            case .milesPerImperialGallon: return .milesPerImperialGallon
            }
        }
    }
    
    @frozen enum InformationStorage: CaseIterable {
        case bits, nibbles, bytes, kibibits, kibibytes, mebibits, mebibytes, gibibits, gibibytes, tebibits, tebibytes, pebibits, pebibytes, exbibits, exbibytes, zebibits, zebibytes, yobibits, yobibytes, kilobits, kilobytes, megabits, megabytes, gigabits, gigabytes, terabits, terabytes, petabits, petabytes, exabits, exabytes, zettabits, zettabytes, yottabits, yottabytes
        
        var unit: UnitInformationStorage {
            switch self {
            case .bits: return .bits
            case .nibbles: return .nibbles
            case .bytes: return .bytes
            case .kibibits: return .kibibits
            case .kibibytes: return .kibibytes
            case .mebibits: return .mebibits
            case .mebibytes: return .mebibytes
            case .gibibits: return .gibibytes
            case .gibibytes: return .gibibytes
            case .tebibits: return .tebibytes
            case .tebibytes: return .tebibytes
            case .pebibits: return .pebibits
            case .pebibytes: return .pebibytes
            case .exbibits: return .exbibits
            case .exbibytes: return .exbibytes
            case .zebibits: return .zebibits
            case .zebibytes: return .zebibytes
            case .yobibits: return .yobibits
            case .yobibytes: return .yobibytes
            case .kilobits: return .kilobits
            case .kilobytes: return .kilobytes
            case .megabits: return .megabits
            case .megabytes: return .megabytes
            case .gigabits: return .gigabits
            case .gigabytes: return .gigabytes
            case .terabits: return .terabits
            case .terabytes: return .terabytes
            case .petabits: return .petabits
            case .petabytes: return .petabytes
            case .exabits: return .exabits
            case .exabytes: return .exabytes
            case .zettabits: return .zettabits
            case .zettabytes: return .zettabytes
            case .yottabits: return .yottabits
            case .yottabytes: return .yottabytes
            }
        }
    }
    
    @frozen enum Length: CaseIterable {
        case megameters, kilometers, hectometers, decameters, meters, decimeters, centimeters, millimeters, micrometers, nanometers, picometers, inches, feet, yards, miles, scandinavianMiles, lightyears, nauticalMiles, fathoms, furlongs, astronomicalUnits, parsecs
        
        var unit: UnitLength {
            switch self {
            case .megameters: return .megameters
            case .kilometers: return .kilometers
            case .hectometers: return .hectometers
            case .decameters: return .decameters
            case .meters: return .meters
            case .decimeters: return .decimeters
            case .centimeters: return .centimeters
            case .millimeters: return .millimeters
            case .micrometers: return .micrometers
            case .nanometers: return .nanometers
            case .picometers: return .picometers
            case .inches: return .inches
            case .feet: return .feet
            case .yards: return .yards
            case .miles: return .miles
            case .scandinavianMiles: return .scandinavianMiles
            case .lightyears: return .lightyears
            case .nauticalMiles: return .nauticalMiles
            case .fathoms: return .fathoms
            case .furlongs: return .furlongs
            case .astronomicalUnits: return .astronomicalUnits
            case .parsecs: return .parsecs
            }
        }
    }
    
    @frozen enum Mass: CaseIterable {
        case kilograms, grams, decigrams, centigrams, milligrams, micrograms, nanograms, picograms, ounces, pounds, stones, metricTons, shortTons, carats, ouncesTroy, slugs
        
        var unit: UnitMass {
            switch self {
            case .kilograms: return .kilograms
            case .grams: return .grams
            case .decigrams: return .decigrams
            case .centigrams: return .centigrams
            case .milligrams: return .milligrams
            case .micrograms: return .micrograms
            case .nanograms: return .nanograms
            case .picograms: return .picograms
            case .ounces: return .ounces
            case .pounds: return .pounds
            case .stones: return .stones
            case .metricTons: return .metricTons
            case .shortTons: return .shortTons
            case .carats: return .carats
            case .ouncesTroy: return .ouncesTroy
            case .slugs: return .slugs
            }
        }
    }
    
    @frozen enum Power: CaseIterable {
        case terawatts, gigawatts, megawatts, kilowatts, watts, milliwatts, microwatts, nanowatts, picowatts, femtowatts, horsepower
        
        var unit: UnitPower {
            switch self {
            case .terawatts: return .terawatts
            case .gigawatts: return .gigawatts
            case .megawatts: return .megawatts
            case .kilowatts: return .kilowatts
            case .watts: return .watts
            case .milliwatts: return .milliwatts
            case .microwatts: return .microwatts
            case .nanowatts: return .nanowatts
            case .picowatts: return .picowatts
            case .femtowatts: return .femtowatts
            case .horsepower: return .horsepower
            }
        }
    }
    
    @frozen enum Pressure: CaseIterable {
        case gigapascals, megapascals, kilopascals, hectopascals, inchesOfMercury, bars, millibars, millimetersOfMercury, newtonsPerMetersSquared, poundsForcePerSquareInch
        
        var unit: UnitPressure {
            switch self {
            case .gigapascals: return .gigapascals
            case .megapascals: return .megapascals
            case .kilopascals: return .kilopascals
            case .hectopascals: return .hectopascals
            case .inchesOfMercury: return .inchesOfMercury
            case .bars: return .bars
            case .millibars: return .millibars
            case .millimetersOfMercury: return .millimetersOfMercury
            case .newtonsPerMetersSquared: return .newtonsPerMetersSquared
            case .poundsForcePerSquareInch: return .poundsForcePerSquareInch
            }
        }
    }
    
    @frozen enum Speed: CaseIterable {
        case metersPerSecond, kilometersPerHour, milesPerHour, knots
        
        var unit: UnitSpeed {
            switch self {
            case .metersPerSecond: return .metersPerSecond
            case .kilometersPerHour: return .kilometersPerHour
            case .milesPerHour: return .milesPerHour
            case .knots: return .knots
            }
        }
    }
    
    @frozen enum Temperature: CaseIterable {
        case kelvin, celsius, fahrenheit
        
        var unit: UnitTemperature {
            switch self {
            case .kelvin: return .kelvin
            case .celsius: return .celsius
            case .fahrenheit: return .fahrenheit
            }
        }
    }
    
    @frozen enum Volume: CaseIterable {
        case megaliters, kiloliters, liters, deciliters, centiliters, milliliters, cubicKilometers, cubicMeters, cubicDecimeters, cubicCentimeters, cubicMillimeters, cubicInches, cubicFeet, cubicYards, cubicMiles, acreFeet, bushels, teaspoons, tablespoons, fluidOunces, cups, pints, quarts, gallons, imperialTeaspoons, imperialTablespoons, imperialFluidOunces, imperialPints, imperialQuarts, imperialGallons, metricCups
        
        var unit: UnitVolume {
            switch self {
            case .megaliters: return .megaliters
            case .kiloliters: return .kiloliters
            case .liters: return .liters
            case .deciliters: return .deciliters
            case .centiliters: return .centiliters
            case .milliliters: return .milliliters
            case .cubicKilometers: return .cubicKilometers
            case .cubicMeters: return .cubicMeters
            case .cubicDecimeters: return .cubicDecimeters
            case .cubicCentimeters: return .cubicCentimeters
            case .cubicMillimeters: return .cubicMillimeters
            case .cubicInches: return .cubicInches
            case .cubicFeet: return .cubicFeet
            case .cubicYards: return .cubicYards
            case .cubicMiles: return .cubicMiles
            case .acreFeet: return .acreFeet
            case .bushels: return .bushels
            case .teaspoons: return .teaspoons
            case .tablespoons: return .tablespoons
            case .fluidOunces: return .fluidOunces
            case .cups: return .cups
            case .pints: return .pints
            case .quarts: return .quarts
            case .gallons: return .gallons
            case .imperialTeaspoons: return .imperialTeaspoons
            case .imperialTablespoons: return .imperialTablespoons
            case .imperialFluidOunces: return .imperialFluidOunces
            case .imperialPints: return .imperialPints
            case .imperialQuarts: return .imperialQuarts
            case .imperialGallons: return .imperialGallons
            case .metricCups: return .metricCups
            }
        }
    }
}
