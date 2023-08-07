//
//  NumberKeypadButton.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/07.
//

import SwiftUI

struct NumberKeypadButton: View {
    @EnvironmentObject private var rateVM: ExchangeRateViewModel
    
    let buttonType: ButtonType
    let isSymbol: Bool
    let size: CGFloat
    
    init(_ buttonType: ButtonType, size: CGFloat) {
        self.buttonType = buttonType
        switch buttonType {
        case .digit, .allClear, .clear, .decimal: self.isSymbol = false
        default: self.isSymbol = true
        }
        self.size = size
    }
    
    var body: some View {
        Button {
            rateVM.buttonTapped(for: buttonType)
        } label: {
            if isSymbol {
                Image(systemName: buttonType.description)
            } else {
                Text(buttonType.description)
            }
        }
        .buttonStyle(KeypadButtonStyle(size: size, foregroundColor: buttonType.foregroundColor, backgroundColor: buttonType.backgroundColor, isWide: buttonType == .digit(.zero)))
    }
}
