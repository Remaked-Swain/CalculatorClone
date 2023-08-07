//
//  ExchangeRateModule.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation
import Combine

class ExchangeRateModule {
    @Published var exchangeRateModel: ExchangeRateModel?
    
    let fm = LocalFileManager.shared
    
    private var subscription: Cancellable?
    
    private let openKey: String = "EXCHANGE_RATE_API"
    private let fileName: String = "CurrentExchangeRate"
    
    init() {
        loadData()
    }
    
    func loadData(base: CurrencyCode.RawValue = "KRW") {
        // 최근에 저장되어있던 환율표가 있는지 확인
        if let currentData = LocalFileManager.shared.fetchJSONFile(fileName: fileName),
           let currentExchangeRateModel = convertDataToExchangeRateModel(data: currentData) {
            // 저장된 환율표 기준 업데이트 예정 시간 참조
            let updateTime = currentExchangeRateModel.timeNextUpdateUTC ?? CalendarManager.shared.dateToString(Date.now)
            // 현재 시간 참조
            let now = CalendarManager.shared.dateToString(Date.now)
            
            // 저장된 환율표의 업데이트 예정 시간과 현재 시간을 비교해서 하루 이상 지났을 경우 새로운 환율표를 다운로드하고 업데이트 하기
            // 아니면 그냥 환율표를 가져와서 업데이트 하기
            if let difference = CalendarManager.shared.differenceInDays(from: updateTime, to: now), difference > 0 {
                downloadExchangeRate(base: base)
                if let exchangeRateModel = self.exchangeRateModel, let data = convertExchangeRateModelToData(exchangeRateModel: exchangeRateModel){
                    LocalFileManager.shared.saveJSONFile(data: data, fileName: fileName)
                }
            } else {
                self.exchangeRateModel = currentExchangeRateModel
            }
        } else {
            // 저장된 환율표가 없으면 새로 다운로드하고 업데이트
            downloadExchangeRate(base: base)
            if let exchangeRateModel = self.exchangeRateModel, let data = convertExchangeRateModelToData(exchangeRateModel: exchangeRateModel){
                LocalFileManager.shared.saveJSONFile(data: data, fileName: fileName)
            }
        }
    }
    
    private func downloadExchangeRate(base: CurrencyCode.RawValue = "KRW") {
        guard let apiKey = Bundle.getAPIKey(for: openKey) else { return }
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(base)") else { return }
        subscription = NetworkingManager.download(url: url)
            .decode(type: ExchangeRateModel.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] receivedExchangeRateModel in
                    self?.exchangeRateModel = receivedExchangeRateModel
                    self?.subscription?.cancel()
                    print("ExchangeRateModel 다운로드 됨")
                })
    }
}

// MARK: LocalFileManager Methods
extension ExchangeRateModule {
    private func convertDataToExchangeRateModel(data: Data) -> ExchangeRateModel? {
        do {
            let exchangeRateModel = try JSONDecoder().decode(ExchangeRateModel.self, from: data)
            return exchangeRateModel
        } catch let error {
            print("JSON파일을 환율표로 디코딩하는데 실패했습니다. \(error)"); return nil
        }
    }
    
    private func convertExchangeRateModelToData(exchangeRateModel: ExchangeRateModel) -> Data? {
        do {
            let data = try JSONEncoder().encode(exchangeRateModel)
            return data
        } catch let error {
            print("환율표를 JSON파일로 인코딩하는데 실패했습니다. \(error)"); return nil
        }
    }
}
