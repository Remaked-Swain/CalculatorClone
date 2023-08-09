//
//  MeasurementUnit.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/09.
//

import Foundation

@frozen enum UnitType {
    case area, length, volume, angle, mass, pressure, acceleration, duration, frequency, speed, energy, power, temperature, illuminance, electricCharge, electricCurrent, electricPotentialDifference, electricResistance, concentrationMass, dispersion, fuelEfficiency, informationStorage
    
    var description: String {
        switch self {
        case .area: return "면적"
        case .length: return "길이"
        case .volume: return "부피"
        case .angle: return "각도"
        case .mass: return "질량"
        case .pressure: return "압력"
        case .acceleration: return "가속도"
        case .duration: return "시간"
        case .frequency: return "주파수"
        case .speed: return "속도"
        case .energy: return "에너지"
        case .power: return "전력"
        case .temperature: return "온도"
        case .illuminance: return "조도"
        case .electricCharge: return "전하량"
        case .electricCurrent: return "전류"
        case .electricPotentialDifference: return "전위차"
        case .electricResistance: return "저항"
        case .concentrationMass: return "질량 농도"
        case .dispersion: return "산포도"
        case .fuelEfficiency: return "연비"
        case .informationStorage: return "정보 저장"
        }
    }
}

@frozen enum MeasurementUnit {
    enum Area: CaseIterable {
        case squareMegameters, squareKilometers, squareMeters, squareCentimeters, squareMillimeters, squareMicrometers, squareNanometers, squareInches, squareFeet, squareYards, squareMiles, acres, ares, hectares
        
        var symbol: String {
            switch self {
            case .squareMegameters: return UnitArea.squareMegameters.symbol
            case .squareKilometers: return UnitArea.squareKilometers.symbol
            case .squareMeters: return UnitArea.squareMeters.symbol
            case .squareCentimeters: return UnitArea.squareCentimeters.symbol
            case .squareMillimeters: return UnitArea.squareMillimeters.symbol
            case .squareMicrometers: return UnitArea.squareMicrometers.symbol
            case .squareNanometers: return UnitArea.squareNanometers.symbol
            case .squareInches: return UnitArea.squareInches.symbol
            case .squareFeet: return UnitArea.squareFeet.symbol
            case .squareYards: return UnitArea.squareYards.symbol
            case .squareMiles: return UnitArea.squareMiles.symbol
            case .acres: return UnitArea.acres.symbol
            case .ares: return UnitArea.ares.symbol
            case .hectares: return UnitArea.hectares.symbol
            }
        }
        
        var description: String {
            switch self {
            case .squareMegameters: return "제곱 메가미터"
            case .squareKilometers: return "제곱 킬로미터"
            case .squareMeters: return "제곱 미터"
            case .squareCentimeters: return "제곱 센티미터"
            case .squareMillimeters: return "제곱 밀리미터"
            case .squareMicrometers: return "제곱 마이크로미터"
            case .squareNanometers: return "제곱 나노미터"
            case .squareInches: return "제곱 인치"
            case .squareFeet: return "제곱 피트"
            case .squareYards: return "제곱 야드"
            case .squareMiles: return "제곱 마일"
            case .acres: return "에이커"
            case .ares: return "아르"
            case .hectares: return "헥타르"
            }
        }
    }
    
    enum Length: CaseIterable {
        case megameters, kilometers, hectometers, decameters, meters, decimeters, centimeters, millimeters, micrometers, nanometers, picometers, inches, feet, yards, miles, scandinavianMiles, lightyears, nauticalMiles, fathoms, fulongs, astronomicalUnits, parsecs
        
        var symbol: String {
            switch self {
            case .megameters: return UnitLength.megameters.symbol
            case .kilometers: return UnitLength.kilometers.symbol
            case .hectometers: return UnitLength.hectometers.symbol
            case .decameters: return UnitLength.decameters.symbol
            case .meters: return UnitLength.meters.symbol
            case .decimeters: return UnitLength.decimeters.symbol
            case .centimeters: return UnitLength.centimeters.symbol
            case .millimeters: return UnitLength.millimeters.symbol
            case .micrometers: return UnitLength.micrometers.symbol
            case .nanometers: return UnitLength.nanometers.symbol
            case .picometers: return UnitLength.picometers.symbol
            case .inches: return UnitLength.inches.symbol
            case .feet: return UnitLength.feet.symbol
            case .yards: return UnitLength.yards.symbol
            case .miles: return UnitLength.miles.symbol
            case .scandinavianMiles: return UnitLength.scandinavianMiles.symbol
            case .lightyears: return UnitLength.lightyears.symbol
            case .nauticalMiles: return UnitLength.nauticalMiles.symbol
            case .fathoms: return UnitLength.fathoms.symbol
            case .fulongs: return UnitLength.furlongs.symbol
            case .astronomicalUnits: return UnitLength.astronomicalUnits.symbol
            case .parsecs: return UnitLength.parsecs.symbol
            }
        }
        
        var description: String {
            switch self {
            case .megameters: return "메가미터"
            case .kilometers: return "킬로미터"
            case .hectometers: return "헥토미터"
            case .decameters: return "데카미터"
            case .meters: return "미터"
            case .decimeters: return "데시미터"
            case .centimeters: return "센티미터"
            case .millimeters: return "밀리미터"
            case .micrometers: return "마이크로미터"
            case .nanometers: return "나노미터"
            case .picometers: return "피코미터"
            case .inches: return "인치"
            case .feet: return "피트"
            case .yards: return "야드"
            case .miles: return "마일"
            case .scandinavianMiles: return "스칸디나비아 마일"
            case .lightyears: return "광년"
            case .nauticalMiles: return "해리"
            case .fathoms: return "패덤"
            case .fulongs: return "퍼롱"
            case .astronomicalUnits: return "천문 단위"
            case .parsecs: return "파섹"
            }
        }
    }
    
    enum Volume: CaseIterable {
        case megaliters, kiloliters, liters, deciliters, centiliters, milliliters, cubicKilometers, cubicDecimeters, cubicMillimeters, cubicInches, cubicFeet, cubicYards, cubicMiles, acreFeet, bushels, teaspoons, tablespoons, fluidOunces, cups, pints, quarts, gallons, imperialTeaspoons, imperialTablespoons, imperialFluidOunces, imperialPints, imperialQuarts, imperialGallons, metricCups
        
        var symbol: String {
            switch self {
            case .megaliters: return UnitVolume.megaliters.symbol
            case .kiloliters: return UnitVolume.kiloliters.symbol
            case .liters: return UnitVolume.liters.symbol
            case .deciliters: return UnitVolume.deciliters.symbol
            case .centiliters: return UnitVolume.centiliters.symbol
            case .milliliters: return UnitVolume.milliliters.symbol
            case .cubicKilometers: return UnitVolume.cubicKilometers.symbol
            case .cubicDecimeters: return UnitVolume.cubicDecimeters.symbol
            case .cubicMillimeters: return UnitVolume.cubicMillimeters.symbol
            case .cubicInches: return UnitVolume.cubicInches.symbol
            case .cubicFeet: return UnitVolume.cubicFeet.symbol
            case .cubicYards: return UnitVolume.cubicYards.symbol
            case .cubicMiles: return UnitVolume.cubicMiles.symbol
            case .acreFeet: return UnitVolume.acreFeet.symbol
            case .bushels: return UnitVolume.bushels.symbol
            case .teaspoons: return UnitVolume.teaspoons.symbol
            case .tablespoons: return UnitVolume.tablespoons.symbol
            case .fluidOunces: return UnitVolume.fluidOunces.symbol
            case .cups: return UnitVolume.cups.symbol
            case .pints: return UnitVolume.pints.symbol
            case .quarts: return UnitVolume.quarts.symbol
            case .gallons: return UnitVolume.gallons.symbol
            case .imperialTeaspoons: return UnitVolume.imperialTeaspoons.symbol
            case .imperialTablespoons: return UnitVolume.imperialTablespoons.symbol
            case .imperialFluidOunces: return UnitVolume.imperialFluidOunces.symbol
            case .imperialPints: return UnitVolume.imperialPints.symbol
            case .imperialQuarts: return UnitVolume.imperialQuarts.symbol
            case .imperialGallons: return UnitVolume.imperialGallons.symbol
            case .metricCups: return UnitVolume.metricCups.symbol
            }
        }
        
        var description: String {
            switch self {
            case .megaliters: return "메가리터"
            case .kiloliters: return "킬로리터"
            case .liters: return "리터"
            case .deciliters: return "데시리터"
            case .centiliters: return "센티리터"
            case .milliliters: return "밀리리터"
            case .cubicKilometers: return "미터"
            case .cubicDecimeters: return "미터"
            case .cubicMillimeters: return "미터"
            case .cubicInches: return "미터"
            case .cubicFeet: return "미터"
            case .cubicYards: return "미터"
            case .cubicMiles: return "미터"
            case .acreFeet: return "에이커-피트"
            case .bushels: return "부셸"
            case .teaspoons: return "티스푼"
            case .tablespoons: return "테이블스푼"
            case .fluidOunces: return "액량 온스"
            case .cups: return "컵"
            case .pints: return "파인트"
            case .quarts: return "쿼트"
            case .gallons: return "갤런"
            case .imperialTeaspoons: return "영국식 티스푼"
            case .imperialTablespoons: return "영국식 테이블스푼"
            case .imperialFluidOunces: return "영국식 액량 온스"
            case .imperialPints: return "영국식 파인트"
            case .imperialQuarts: return "영국식 쿼트"
            case .imperialGallons: return "영국식 갤런"
            case .metricCups: return "메트릭 컵"
            }
        }
    }
    
    enum Angle: CaseIterable {
        case degrees, arcMinutes, arcSeconds, radians, gradians, revolutions
        
        var symbol: String {
            switch self {
            case .degrees: return UnitAngle.degrees.symbol
            case .arcMinutes: return UnitAngle.arcMinutes.symbol
            case .arcSeconds: return UnitAngle.arcSeconds.symbol
            case .radians: return UnitAngle.radians.symbol
            case .gradians: return UnitAngle.gradians.symbol
            case .revolutions: return UnitAngle.revolutions.symbol
            }
        }
        
        var description: String {
            switch self {
            case .degrees: return "도"
            case .arcMinutes: return "분"
            case .arcSeconds: return "초"
            case .radians: return "라디안"
            case .gradians: return "그라디언"
            case .revolutions: return "회전"
            }
        }
    }
    
    enum Mass: CaseIterable {
        case kilograms, grams, decigrams, centigrams, milligrams, micrograms, nanograms, picograms, ounces, pounds, stones, metricTons, shortTons, carats, ouncesTroy, slugs
        
        var symbol: String {
            switch self {
            case .kilograms: return UnitMass.kilograms.symbol
            case .grams: return UnitMass.grams.symbol
            case .decigrams: return UnitMass.decigrams.symbol
            case .centigrams: return UnitMass.centigrams.symbol
            case .milligrams: return UnitMass.milligrams.symbol
            case .micrograms: return UnitMass.micrograms.symbol
            case .nanograms: return UnitMass.nanograms.symbol
            case .picograms: return UnitMass.picograms.symbol
            case .ounces: return UnitMass.ounces.symbol
            case .pounds: return UnitMass.pounds.symbol
            case .stones: return UnitMass.stones.symbol
            case .metricTons: return UnitMass.metricTons.symbol
            case .shortTons: return UnitMass.shortTons.symbol
            case .carats: return UnitMass.carats.symbol
            case .ouncesTroy: return UnitMass.ouncesTroy.symbol
            case .slugs: return UnitMass.slugs.symbol
            }
        }
        
        var description: String {
            switch self {
            case .kilograms: return "킬로그램"
            case .grams: return "그램"
            case .decigrams: return "데시그램"
            case .centigrams: return "센티그램"
            case .milligrams: return "밀리그램"
            case .micrograms: return "마이크로그램"
            case .nanograms: return "나노그램"
            case .picograms: return "피코그램"
            case .ounces: return "온스"
            case .pounds: return "파운드"
            case .stones: return "스톤"
            case .metricTons: return "미터톤"
            case .shortTons: return "단위톤"
            case .carats: return "캐럿"
            case .ouncesTroy: return "트로이온스"
            case .slugs: return "슬러그"
            }
        }
    }
    
    enum Pressure: CaseIterable {
        case newtonsPerMetersSquared, gigapascals, megapascals, kilopascals, hectopascals, inchesOfMercury, bars, millibars, millimetersOfMercury, poundsForcePerSquareInch
        
        var symbol: String {
            switch self {
            case .newtonsPerMetersSquared: return "N/m²"
            case .gigapascals: return "GPa"
            case .megapascals: return "MPa"
            case .kilopascals: return "kPa"
            case .hectopascals: return "hPa"
            case .inchesOfMercury: return "inHg"
            case .bars: return "bar"
            case .millibars: return "mbar"
            case .millimetersOfMercury: return "mmHg"
            case .poundsForcePerSquareInch: return "psi"
            }
        }
        
        var description: String {
            switch self {
            case .newtonsPerMetersSquared: return "뉴튼/미터²"
            case .gigapascals: return "기가파스칼"
            case .megapascals: return "메가파스칼"
            case .kilopascals: return "킬로파스칼"
            case .hectopascals: return "헥토파스칼"
            case .inchesOfMercury: return "수은 인치"
            case .bars: return "바"
            case .millibars: return "밀리바"
            case .millimetersOfMercury: return "수은 밀리미터"
            case .poundsForcePerSquareInch: return "파운드 힘/제곱인치"
            }
        }
    }
    
    enum Acceleration: CaseIterable {
        case metersPerSecondSquared, gravity
        
        var symbol: String {
            switch self {
            case .metersPerSecondSquared: return UnitAcceleration.metersPerSecondSquared.symbol
            case .gravity: return UnitAcceleration.gravity.symbol
            }
        }
        
        var description: String {
            switch self {
            case .metersPerSecondSquared: return "미터/초²"
            case .gravity: return "중력"
            }
        }
    }
    
    enum Duration: CaseIterable {
        case hours, minutes, seconds, milliseconds, microseconds, nanoseconds, picoseconds
        
        var symbol: String {
            switch self {
            case .hours: return UnitDuration.hours.symbol
            case .minutes: return UnitDuration.minutes.symbol
            case .seconds: return UnitDuration.seconds.symbol
            case .milliseconds: return UnitDuration.milliseconds.symbol
            case .microseconds: return UnitDuration.microseconds.symbol
            case .nanoseconds: return UnitDuration.nanoseconds.symbol
            case .picoseconds: return UnitDuration.picoseconds.symbol
            }
        }
        
        var description: String {
            switch self {
            case .hours: return "시간"
            case .minutes: return "분"
            case .seconds: return "초"
            case .milliseconds: return "밀리초"
            case .microseconds: return "마이크로초"
            case .nanoseconds: return "나노초"
            case .picoseconds: return "피코초"
            }
        }
    }
    
    enum Frequency: CaseIterable {
        case terahertz, gigahertz, megahertz, kilohertz, hertz, millihertz, microhertz, nanohertz, framesPerSecond
        
        var symbol: String {
            switch self {
            case .terahertz: return "THz"
            case .gigahertz: return "GHz"
            case .megahertz: return "MHz"
            case .kilohertz: return "kHz"
            case .hertz: return "Hz"
            case .millihertz: return "mHz"
            case .microhertz: return "μHz"
            case .nanohertz: return "nHz"
            case .framesPerSecond: return "fps"
            }
        }
        
        var description: String {
            switch self {
            case .terahertz: return "테라헤르츠"
            case .gigahertz: return "기가헤르츠"
            case .megahertz: return "메가헤르츠"
            case .kilohertz: return "킬로헤르츠"
            case .hertz: return "헤르츠"
            case .millihertz: return "밀리헤르츠"
            case .microhertz: return "마이크로헤르츠"
            case .nanohertz: return "나노헤르츠"
            case .framesPerSecond: return "프레임/초"
            }
        }
    }
    
    enum Speed: CaseIterable {
        case metersPerSecond, kilometersPerHour, milesPerHour, knots
        
        var symbol: String {
            switch self {
            case .metersPerSecond: return UnitSpeed.metersPerSecond.symbol
            case .kilometersPerHour: return UnitSpeed.kilometersPerHour.symbol
            case .milesPerHour: return UnitSpeed.milesPerHour.symbol
            case .knots: return UnitSpeed.knots.symbol
            }
        }
        
        var description: String {
            switch self {
            case .metersPerSecond: return "미터/초"
            case .kilometersPerHour: return "킬로미터/시간"
            case .milesPerHour: return "마일/시간"
            case .knots: return "노트"
            }
        }
    }
    
    enum Energy: CaseIterable {
        case kilojoules, joules, kilocalories, calories, kilowattHours
        
        var symbol: String {
            switch self {
            case .kilojoules: return "kJ"
            case .joules: return "J"
            case .kilocalories: return "kcal"
            case .calories: return "cal"
            case .kilowattHours: return "kWh"
            }
        }
        
        var description: String {
            switch self {
            case .kilojoules: return "킬로줄"
            case .joules: return "줄"
            case .kilocalories: return "킬로칼로리"
            case .calories: return "칼로리"
            case .kilowattHours: return "킬로와트시"
            }
        }
    }
    
    enum Power: CaseIterable {
        case terawatts, gigawatts, megawatts, kilowatts, watts, milliwatts, microwatts, nanowatts, picowatts, femtowatts, horsepower
        
        var symbol: String {
            switch self {
            case .terawatts: return "TW"
            case .gigawatts: return "GW"
            case .megawatts: return "MW"
            case .kilowatts: return "kW"
            case .watts: return "W"
            case .milliwatts: return "mW"
            case .microwatts: return "μW"
            case .nanowatts: return "nW"
            case .picowatts: return "pW"
            case .femtowatts: return "fW"
            case .horsepower: return "hp"
            }
        }
        
        var description: String {
            switch self {
            case .terawatts: return "테라와트"
            case .gigawatts: return "기가와트"
            case .megawatts: return "메가와트"
            case .kilowatts: return "킬로와트"
            case .watts: return "와트"
            case .milliwatts: return "밀리와트"
            case .microwatts: return "마이크로와트"
            case .nanowatts: return "나노와트"
            case .picowatts: return "피코와트"
            case .femtowatts: return "펨토와트"
            case .horsepower: return "마력"
            }
        }
    }
    
    // temperature
    
    // illuminance
    
    // electric charge
    
    // electric current
    
    // electric potential difference
    
    // electric resistance
    
    // concentration mass
    
    // dispersion
    
    // fuel efficiency
    
    // information storage
}
