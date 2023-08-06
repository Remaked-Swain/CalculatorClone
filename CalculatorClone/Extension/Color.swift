//
//  Color.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = Theme()
}

struct Theme {
    let accentColor = Color("AccentColor")
    let textColor = Color("TextColor")
    let backgroundColor = Color("BackgroundColor")
    let secondaryColor = Color("SecondaryColor")
    let darkSecondaryColor = Color("DarkSecondaryColor")
}
