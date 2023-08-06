//
//  CoreView.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/05.
//

import SwiftUI

struct CoreView: View {
    @StateObject private var coreVM = CoreViewModel()
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor.ignoresSafeArea()
            
            VStack {
                displayText
                
                keypads
            }
        }
    }
}

struct CoreView_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
    }
}

// MARK: Extracted Views
extension CoreView {
    private var displayText: some View {
        VStack {
            Spacer()
            Text(coreVM.displayText)
                .padding()
                .font(.system(size: 88, weight: .light))
                .foregroundColor(.theme.textColor)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .background(
            Rectangle().foregroundColor(.theme.backgroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 3)
                .gesture(
                    DragGesture()
                        .onChanged({ _ in
                            // do nothing
                        })
                        .onEnded({ _ in
                            coreVM.dragDisplayTextToRemove()
                        })
                )
        )
    }
    
    private var keypads: some View {
        VStack {
            Spacer()
            ForEach(coreVM.keypads, id: \.self) { row in
                HStack {
                    Spacer()
                    ForEach(row, id: \.self) { buttonType in
                        KeypadButtonView(buttonType, size: getButtonSize())
                            .environmentObject(coreVM)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
    }
}

// MARK: Methods
extension CoreView {
    private func getButtonSize() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}
