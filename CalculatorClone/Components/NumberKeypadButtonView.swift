//
//  NumberKeypadButtonView.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/07.
//

import SwiftUI

struct NumberKeypadButtonView: View {
    @EnvironmentObject private var rateVM: ExchangeRateViewModel
    
    let buttonType: ButtonType
    let size: CGFloat
    
    init(_ buttonType: ButtonType, size: CGFloat) {
        self.buttonType = buttonType
        self.size = size
    }
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                rateVM.buttonTapped(for: buttonType)
            }
        } label: {
            Text(buttonType.description)
        }
        .buttonStyle(KeypadButtonStyle(size: size, foregroundColor: buttonType.foregroundColor, backgroundColor: buttonType.backgroundColor, isWide: true))
    }
}
