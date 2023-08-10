#  Calculator Clone
아이폰의 기본 앱 중 하나인 계산기 앱을 클론해보자.

## ScreenShots
* 일반 계산기, 환율 계산기 화면과 메뉴 스위칭 버튼

<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_CoreView.PNG?raw=true" alt="CoreView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_MenuView.PNG?raw=true" alt="MenuView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_ExchangeRateView.PNG?raw=true" alt="ExchangeRateView" width="250px">
</p>

    * 아이폰 기본 앱 중 하나인 계산기 앱을 따라 만들어 봄.
    * 또한 이 계산기에 새로운 기능을 넣어보고 싶어졌고, 이에 다양한 통화에 대한 환율 계산을 수행하는 기능을 넣기로 하였음.

---------------------------------------

## ExchangeRate API

ExchangeRate API를 활용하여 최근 환율 정보를 얻을 수 있다.

![ExchangeRateAPI](https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_ExchangeRateAPI.png?raw=true)

     https://v6.exchangerate-api.com/v6/\(api-key)/latest/\(3 characters currency locale)
> 무료 요금제 기준에서, 한 달에 1,500건의 

```Swift
import Foundation
import Combine

class ExchangeRateModule {
    @Published var exchangeRateModel: ExchangeRateModel?
    
    let fm = LocalFileManager.shared
    
    private var subscription: Cancellable?
    
    private let openKey: String = "EXCHANGE_RATE_API"
    
    init() {
        loadData()
    }
    
    private func loadData(base: CurrencyCode.RawValue = "KRW") {
        // 최근에 저장되어있던 환율표가 있는지 확인
        if let currentData = LocalFileManager.shared.fetchJSONFile(),
           let currentExchangeRateModel = convertDataToExchangeRateModel(data: currentData) {
            // 저장된 환율표 기준 업데이트 예정 시간 참조
            let updateTime = currentExchangeRateModel.timeNextUpdateUTC ?? CalendarManager.shared.dateToString(Date.now)
            // 현재 시간 참조
            let now = CalendarManager.shared.dateToString(Date.now)
            
            // 저장된 환율표의 업데이트 예정 시간과 현재 시간을 비교해서 하루 이상 지났을 경우 새로운 환율표를 다운로드하고 업데이트 하기
            // 아니면 그냥 환율표를 가져와서 업데이트 하기
            if let difference = CalendarManager.shared.differenceInDays(from: updateTime, to: now), difference > 0 {
                downloadExchangeRate(base: base)
            } else {
                self.exchangeRateModel = currentExchangeRateModel
            }
        } else {
            downloadExchangeRate(base: base)
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
                    if let data = self?.convertExchangeRateModelToData(exchangeRateModel: receivedExchangeRateModel) {
                        LocalFileManager.shared.saveJSONFile(data: data)
                    }
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
```
