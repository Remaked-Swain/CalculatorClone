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
                updatedTimeUTC
                
                baseCurrencySection
                
                swapCurrencyButton
                
                comparisonCurrencySection
                
                keypads
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
    private var updatedTimeUTC: some View {
        HStack {
            Spacer()
            
            if let updatedTimeUTC = rateVM.exchangeRateModel?.timeLastUpdateUTC {
                Text(CalendarManager.shared.showUTCTime(updatedTimeUTC))
                    .font(.callout)
                    .foregroundColor(.theme.textColor)
            }
        }
        .padding(.horizontal)
    }
    
    private var baseCurrencySection: some View {
        VStack(alignment:. leading) {
            HStack {
                Text(rateVM.baseCurrency.description)
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.theme.textColor)
                
                Spacer()
            }
            
            Text(rateVM.baseCurrencyAmount, format: .number)
                .keyboardType(.decimalPad)
                .font(.system(size: 80))
                .foregroundColor(.theme.textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .padding()
        .frame(maxWidth: .infinity)
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
            
            Text(rateVM.convertedCurrencyAmount, format: .number)
                .font(.system(size: 80))
                .foregroundColor(.theme.accentColor)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.theme.darkSecondaryColor)
        )
        .padding()
    }
    
    private var swapCurrencyButton: some View {
        Button {
            withAnimation(.easeInOut) {
                rateVM.swapBaseCurrency()
            }
        } label: {
            Image(systemName: "chevron.down")
                .imageScale(.large)
                .foregroundColor(.theme.accentColor)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
    }
    
    private var keypads: some View {
        VStack {
            ForEach(rateVM.keypads, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { buttonType in
                        NumberKeypadButtonView(buttonType, size: getButtonSize())
                            .environmentObject(rateVM)
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: Methods
extension ExchangeRateView {
    private func getButtonSize() -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 48) / 3
    }
}
