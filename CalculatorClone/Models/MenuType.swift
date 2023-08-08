//
//  MenuType.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation

// MainView에서 선택할 수 있는 뷰의 열거이자 앱을 이루는 주요 모듈에 대한 열거
@frozen enum MenuType: String, CaseIterable {
    case core, exchangeRate, measurement
    
    var title: String {
        switch self {
        case .core: return "일반 계산기"
        case .exchangeRate: return "환율 및 통화"
        case .measurement: return "측정 단위"
        }
    }
}
