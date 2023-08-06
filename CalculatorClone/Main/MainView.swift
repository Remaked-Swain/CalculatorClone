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
            Button {
                selectedMenu = .core
            } label: {
                Text("일반 계산기")
            }
            
            Button {
                selectedMenu = .exchangeRate
            } label: {
                Text("환율")
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
