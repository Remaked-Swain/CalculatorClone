//
//  MeasurementView.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/08.
//

import SwiftUI

struct MeasurementView: View {
    @StateObject private var measurementVM = MeasurementViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                
            }
        }
    }
}

struct MeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementView()
    }
}

// MARK: Extract Views
extension MeasurementView {
    private var unitSelector: some View {
        HStack {
            
        }
    }

    private var swapUnitButton: some View {
        Button {
            withAnimation(.easeInOut) {
                // swap unit
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
            ForEach(measurementVM.keypads, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { buttonType in
                        NumberKeypadButtonView(buttonType, size: getButtonSize())
                            .environmentObject(measurementVM)
                    }
                }
            }
        }
        .padding()
    }
}

// MARK: Methods
extension MeasurementView {
    private func getButtonSize() -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 48) / 3
    }
}
