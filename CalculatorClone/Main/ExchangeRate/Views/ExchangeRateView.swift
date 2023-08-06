//
//  ExchangeRateView.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import SwiftUI

struct ExchangeRateView: View {
    @StateObject private var rateVM = ExchangeRateViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                baseCurrencySection
                
                Image(systemName: "chevron.down")
                    .imageScale(.large)
                    .foregroundColor(.theme.accentColor)
                
                comparisonCurrencySection
                
                // Reset Buttons
            }
        }
    }
}

struct ExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateView()
    }
}

extension ExchangeRateView {
    private var baseCurrencySection: some View {
        VStack(alignment:. leading) {
            HStack {
                Text(rateVM.baseCurrency.description)
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.theme.textColor)
                
                Spacer()
            }
            
            TextField("기준 통화량", text: $rateVM.textField)
                .tint(.theme.accentColor)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height / 5)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.theme.darkSecondaryColor)
        )
        .padding()
    }
    
    private var comparisonCurrencySection: some View {
        VStack(alignment:. leading) {
            HStack {
                Text(rateVM.comparisonCurrency.description)
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.theme.textColor)
                
                Spacer()
            }
            
            Text("fdafdafdafdafdaf")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height / 5)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.theme.darkSecondaryColor)
        )
        .padding()
    }
}
