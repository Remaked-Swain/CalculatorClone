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
                
                swapCurrencyButton
                
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

// MARK: Extract Views
extension ExchangeRateView {
    private var baseCurrencySection: some View {
        VStack(alignment:. leading) {
            HStack {
                Text(rateVM.baseCurrency.description)
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.theme.textColor)
                
                Spacer()
            }
            
            Spacer()
            
            TextField("0", value: $rateVM.baseCurrencyAmount, format: .number)
                .keyboardType(.decimalPad)
                .font(.system(size: 80))
                .foregroundColor(.theme.textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
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
            
            Spacer()
            
            Text(rateVM.convertedCurrencyAmount, format: .number)
                .font(.system(size: 80))
                .foregroundColor(.theme.textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
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
    
    private var swapCurrencyButton: some View {
        Button {
            // swap currency
        } label: {
            Image(systemName: "chevron.down")
                .imageScale(.large)
                .frame(maxWidth: .infinity)
                .foregroundColor(.theme.accentColor)
        }
    }
}

// MARK: Methods
extension ExchangeRateView {
    
}
