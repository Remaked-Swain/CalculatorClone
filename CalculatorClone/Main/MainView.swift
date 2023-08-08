//
//  MainView.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import SwiftUI

struct MainView: View {
    @State private var selectedMenu: MenuType = .core
    
    var body: some View {
        ZStack {
            switch selectedMenu {
            case .core: CoreView()
            case .exchangeRate: ExchangeRateView()
            case .measurement: MeasurementView()
            }
            
            menuSelector
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    private var menuSelector: some View {
        Menu {
            ForEach(MenuType.allCases, id: \.self) { menuType in
                Button {
                    selectedMenu = menuType
                } label: {
                    Text(menuType.title)
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal")
                .font(.title.weight(.bold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .tint(.theme.textColor)
    }
}
