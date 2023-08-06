//
//  ExchangeRateModel.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation

// Exchange Rate API
/*
 url: https://v6.exchangerate-api.com/v6/\(api-key)/latest/\(3 characters currency locale)
 
 ex: https://v6.exchangerate-api.com/v6/\(api-key)/latest/KRW
 
 response:
 {
  "result":"success",
  "documentation":"https://www.exchangerate-api.com/docs",
  "terms_of_use":"https://www.exchangerate-api.com/terms",
  "time_last_update_unix":1691280001,
  "time_last_update_utc":"Sun, 06 Aug 2023 00:00:01 +0000",
  "time_next_update_unix":1691366401,
  "time_next_update_utc":"Mon, 07 Aug 2023 00:00:01 +0000",
  "base_code":"KRW",
  "conversion_rates":{
   "KRW":1,
   "AED":0.002816,
   "AFN":0.06557,
   "ALL":0.07307,
   "AMD":0.2955,
   "ANG":0.001373,
   "AOA":0.6396,
   "ARS":0.2130,
   "AUD":0.001166,
   "AWG":0.001373,
   "AZN":0.001301,
   "BAM":0.001364,
   "BBD":0.001534,
   "BDT":0.08407,
   "BGN":0.001363,
   "BHD":0.00028835,
   "BIF":2.1852,
   "BMD":0.00076689,
   "BND":0.001028,
   "BOB":0.005319,
   "BRL":0.003739,
   "BSD":0.00076689,
   "BTN":0.06344,
   "BWP":0.01029,
   "BYN":0.001922,
   "BZD":0.001534,
   "CAD":0.001025,
   "CDF":1.9032,
   "CHF":0.00067012,
   "CLP":0.6506,
   "CNY":0.005502,
   "COP":3.1106,
   "CRC":0.4185,
   "CUP":0.01841,
   "CVE":0.07687,
   "CZK":0.01693,
   "DJF":0.1363,
   "DKK":0.005201,
   "DOP":0.04336,
   "DZD":0.1043,
   "EGP":0.02362,
   "ERN":0.01150,
   "ETB":0.04232,
   "EUR":0.00069716,
   "FJD":0.001731,
   "FKP":0.00060174,
   "FOK":0.005201,
   "GBP":0.00060198,
   "GEL":0.001998,
   "GGP":0.00060174,
   "GHS":0.008632,
   "GIP":0.00060174,
   "GMD":0.04827,
   "GNF":6.5556,
   "GTQ":0.006041,
   "GYD":0.1607,
   "HKD":0.005991,
   "HNL":0.01890,
   "HRK":0.005253,
   "HTG":0.1052,
   "HUF":0.2732,
   "IDR":11.6355,
   "ILS":0.002814,
   "IMP":0.00060174,
   "INR":0.06344,
   "IQD":1.0043,
   "IRR":32.5226,
   "ISK":0.1010,
   "JEP":0.00060174,
   "JMD":0.1191,
   "JOD":0.00054372,
   "JPY":0.1090,
   "KES":0.1097,
   "KGS":0.06713,
   "KHR":3.1892,
   "KID":0.001167,
   "KMF":0.3430,
   "KWD":0.00023433,
   "KYD":0.00063907,
   "KZT":0.3404,
   "LAK":14.7769,
   "LBP":11.5033,
   "LKR":0.2448,
   "LRD":0.1433,
   "LSL":0.01420,
   "LYD":0.003680,
   "MAD":0.007560,
   "MDL":0.01352,
   "MGA":3.4706,
   "MKD":0.04308,
   "MMK":1.8648,
   "MNT":2.6517,
   "MOP":0.006171,
   "MRU":0.02970,
   "MUR":0.03452,
   "MVR":0.01186,
   "MWK":0.8082,
   "MXN":0.01315,
   "MYR":0.003501,
   "MZN":0.04902,
   "NAD":0.01420,
   "NGN":0.5919,
   "NIO":0.02811,
   "NOK":0.007833,
   "NPR":0.1015,
   "NZD":0.001256,
   "OMR":0.00029487,
   "PAB":0.00076689,
   "PEN":0.002832,
   "PGK":0.002753,
   "PHP":0.04262,
   "PKR":0.2189,
   "PLN":0.003103,
   "PYG":5.6148,
   "QAR":0.002791,
   "RON":0.003455,
   "RSD":0.08194,
   "RUB":0.07324,
   "RWF":0.9042,
   "SAR":0.002876,
   "SBD":0.006495,
   "SCR":0.01019,
   "SDG":0.3435,
   "SEK":0.008204,
   "SGD":0.001028,
   "SHP":0.00060174,
   "SLE":0.01628,
   "SLL":16.2819,
   "SOS":0.4370,
   "SRD":0.02933,
   "SSP":0.7688,
   "STN":0.01708,
   "SYP":9.8986,
   "SZL":0.01420,
   "THB":0.02657,
   "TJS":0.008330,
   "TMT":0.002672,
   "TND":0.002370,
   "TOP":0.001825,
   "TRY":0.02070,
   "TTD":0.005227,
   "TVD":0.001167,
   "TWD":0.02428,
   "TZS":1.8880,
   "UAH":0.02825,
   "UGX":2.7765,
   "USD":0.00076689,
   "UYU":0.02883,
   "UZS":8.9446,
   "VES":0.02376,
   "VND":18.2036,
   "VUV":0.09250,
   "WST":0.002106,
   "XAF":0.4573,
   "XCD":0.002071,
   "XDR":0.00057138,
   "XOF":0.4573,
   "XPF":0.08319,
   "YER":0.1922,
   "ZAR":0.01428,
   "ZMW":0.01471,
   "ZWL":3.5230
  }
 }
 */

struct ExchangeRateModel: Codable {
    let result: String? // 응답결과: success, fail
    let documentation, termsOfUse: String? // API documentation, terms
    let timeLastUpdateUnix: Int? // 최근 업데이트 시각, UNIX timestamp
    let timeLastUpdateUTC: String? // 최근 업데이트 시각, UTC
    let timeNextUpdateUnix: Int? // 다음 업데이트 예정 시각, UNIX timestamp
    let timeNextUpdateUTC: String? // 다음 업데이트 예정 시각, UTC
    let conversionRates: [String: Double]?
    let baseCode: String? // 기준 통화

    enum CodingKeys: String, CodingKey {
        case result, documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}
