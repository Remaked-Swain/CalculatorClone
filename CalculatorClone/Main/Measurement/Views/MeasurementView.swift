//
//  MeasurementView.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/11.
//

import SwiftUI

struct MeasurementView: View {
    @StateObject private var measurementVM = MeasurementViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                measurementMenu
                
                baseUnitSection
                
                swapUnitTypeButton
                
                comparisonUnitSection
                
                keypads
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
    private var measurementMenu: some View {
        HStack {
            Spacer()
            
            Menu {
                ForEach(UnitType.allCases, id: \.self) { unitType in
                    Button {
                        measurementVM.selectUnitType(unitType)
                    } label: {
                        Text(unitType.description)
                    }
                }
            } label: {
                Text(measurementVM.selectedUnitType.description)
                    .font(.callout)
                    .foregroundColor(.theme.textColor)
                    .padding(10)
                    .background(Color.theme.accentColor.cornerRadius(10))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal)
    }
    
    private var baseUnitSection: some View {
        VStack(alignment:. leading) {
            HStack {
                Menu {
                    ForEach(measurementVM.selectableUnitList, id: \.self) { dimension in
                        Button {
                            selectBaseUnit(dimension)
                        } label: {
                            HStack {
                                Text(dimension.symbol)
                            }
                        }
                    }
                } label: {
                    Text(measurementVM.baseUnit?.symbol ?? "단위 없음")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.theme.textColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            Text(measurementVM.baseUnitAmount, format: .number)
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
    
    private var comparisonUnitSection: some View {
        VStack(alignment:. leading) {
            HStack {
                Menu {
                    ForEach(measurementVM.selectableUnitList, id: \.self) { dimension in
                        Button {
                            selectComparisonUnit(dimension)
                        } label: {
                            HStack {
                                Text(dimension.symbol)
                            }
                        }
                    }
                } label: {
                    Text(measurementVM.comparisonUnit?.symbol ?? "단위 없음")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.theme.textColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            Text(measurementVM.comparisonUnitAmount, format: .number)
                .keyboardType(.decimalPad)
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
    
    private var swapUnitTypeButton: some View {
        Button {
            withAnimation(.easeInOut) {
                measurementVM.swapUnits()
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
                        NumberKeypadButtonView2(buttonType, size: getButtonSize())
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
    
    func selectBaseUnit(_ dimension: Dimension) {
        withAnimation(.easeInOut) {
            measurementVM.selectBaseUnit(dimension)
        }
    }
    
    func selectComparisonUnit(_ dimension: Dimension) {
        withAnimation(.easeInOut) {
            measurementVM.selectComparisonUnit(dimension)
        }
    }
}
