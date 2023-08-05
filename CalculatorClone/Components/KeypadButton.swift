//
//  KeypadButton.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/05.
//

import SwiftUI

struct KeypadButton: View {
    @EnvironmentObject private var coreVM: CoreViewModel
    
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
            coreVM.buttonTapped(for: buttonType)
        } label: {
            if isSymbol {
                Image(systemName: buttonType.description)
            } else {
                Text(buttonType.description)
            }
        }
        .buttonStyle(KeypadButtonStyle(size: size, foregroundColor: getForegroundColor(), backgroundColor: getBackgroundColor(), isWide: buttonType == .digit(.zero)))
    }
    
    private func getForegroundColor() -> Color {
        coreVM.orderButtonIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
    }
    
    private func getBackgroundColor() -> Color {
        coreVM.orderButtonIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
    }
}

struct KeypadButtonStyle: ButtonStyle {
    let size: CGFloat
    let foregroundColor: Color
    let backgroundColor: Color
    let isWide: Bool
    
    init(size: CGFloat, foregroundColor: Color, backgroundColor: Color, isWide: Bool = false) {
        self.size = size
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.isWide = isWide
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.medium)
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size, alignment: isWide ? .leading : .center)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
}
