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
> 무료 요금제 기준에서, 한 달에 1,500건 API 요청이 가능하다. 나름 테스팅 과정에서 많은 API 요청이 이루어졌다고 생각했으나 154건 밖에 사용하지 않았다.

* JSON 응답을 파싱하여 Swift에서 환율 정보로 모델링

```Swift
struct ExchangeRateModel: Codable {
    let result: String? // 응답결과: success, fail
    let documentation, termsOfUse: String? // API documentation, terms
    let timeLastUpdateUnix: Int? // 최근 업데이트 시각, UNIX timestamp
    let timeLastUpdateUTC: String? // 최근 업데이트 시각, UTC
    let timeNextUpdateUnix: Int? // 다음 업데이트 예정 시각, UNIX timestamp
    let timeNextUpdateUTC: String? // 다음 업데이트 예정 시각, UTC
    let conversionRates: [String: Double]?
    let baseCode: String? // 기준 통화

    enum CodingKeys: String, CodingKey {
        case result, documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}
```
> baseCode가 1의 리터럴 값을 가진 기준 통화이고, conversionRates 딕셔너리에 국가코드를 키 값으로 찾을 수 있는 기준 통화 대비 비교 통화의 환율 데이터가 담겨있다.
> 그래서 나는 키 값으로 사용할 국가코드를 열거형으로 묶어서 관리할 필요를 느끼게 되었다. 겸사겸사 각 국 통화이름도 정리해주자.

```Swift
@frozen enum CurrencyCode: String, CaseIterable, CustomStringConvertible {
    case KRW
    case AED
    case AFN
    
//  ...생략...

    case ZAR
    case ZMW
    case ZWL

    var description: String {
        switch self {
        case .KRW:
            return "대한민국 원 (KRW)"
        case .AED:
            return "아랍 에미리트 디르함 (AED)"
        case .AFN:
            return "아프가니스탄 아프가니 (AFN)"
            
//      ...생략...

        case .ZAR:
            return "남아프리카 랜드 (ZAR)"
        case .ZMW:
            return "잠비아 콰쳐 (ZMW)"
        case .ZWL:
            return "짐바브웨 달러 (ZWL)"
        }
    }
}
```

## ExchangeRateModule & LocalFileManager

API 와의 통신과 수신된 JSON 응답을 처리하여 ViewModel이 적절한 동작을 수행할 수 있게 보조하는 모듈

* ExchangeRateModule

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
    // 생략...
}
```

* LocalFileManager
```Swift
class LocalFileManager {
    static let shared = LocalFileManager()
    
    private let folderName: String = "ExchangeRateJSON"
    private let fileName: String = "CurrentExchangeRate"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func getDocumentDirectoryURL() -> URL? {
        // 디렉토리 경로 확인
        guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("디렉토리 경로를 찾을 수 없습니다.")
            return nil
        }
        // 디렉토리 경로 반환
        return documentDirectoryURL
    }
    
    private func getFolderURL() -> URL? {
        guard let documentDirectoryURL = getDocumentDirectoryURL() else { return nil }
        let folderURL = documentDirectoryURL.appendingPathComponent(folderName, conformingTo: .folder)
        return folderURL
    }
    
    private func getJSONFileURL() -> URL? {
        guard let folderURL = getFolderURL() else { return nil }
        let fileURL = folderURL.appendingPathComponent(fileName, conformingTo: .json)
        return fileURL
    }
    
    private func createFolderIfNeeded() {
        // 디렉토리 내 폴더 확인
        guard let folderURL = getFolderURL() else { return }
        
        // 폴더가 존재하지 않을 경우 생성
        if !FileManager.default.fileExists(atPath: folderURL.path()) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
                print("폴더 생성")
            } catch let error {
                print("폴더 생성간 에러 발생: \(error)")
            }
        }
    }
    
    func saveJSONFile(data: Data) {
        guard let jsonFileURL = getJSONFileURL() else { return }
        
        do {
            try data.write(to: jsonFileURL)
            print("다운로드 및 파일 저장")
        } catch let error {
            print("파일 저장 실패: \(error)")
        }
    }
    
    func fetchJSONFile() -> Data? {
        guard let jsonFileURL = getJSONFileURL(), FileManager.default.fileExists(atPath: jsonFileURL.path) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: jsonFileURL)
            return data
        } catch let error {
            print("파일을 찾을 수 없습니다. \(error)")
            return nil
        }
    }
}
```
> 개발 중인 내용을 친구에게 자랑했더니 친구가 말했다, "그러면 환율 정보는 매번 앱을 켤때마다 와이파이나 데이터를 켜서 다운로드 받아야 해?"
> 마침 JSON응답 내에는 업데이트된 시각과 다음 업데이트 예정 시각에 대한 데이터도 포함되어 있었기에, 나는 현재 날짜와 업데이트 예정 시각을 비교하여 다운로드 필요 여부를 결정하게 하기로 했다.
> 또한 나는 이 과정에서 JSON파일을 기기 내에 저장해둔다면 다운로드가 필요없을 때나 인터넷 연결이 불가능한 경우에도 앱을 사용할 수 있을 것으로 보았다.
> JSON파일을 로컬파일에서 가져오고, 비교하고, 다운로드를 새로 해야할지 결정하는 분기들이 머릿속에서는 간단했는데 코드로 작성하려니 뭔가 헷갈리기 시작했다. 그래서 도처에 print문을 깔아두고 동작 순서를 여러번 테스트해가며 코드를 작성했다.

* 기능
    1. 일반 계산기는 정수, 소수에 대한 사칙연산을 수행할 수 있다.
    2. 환율 계산기는 필요에 따라 인터넷에서 최신 환율 정보를 받아오고, 그것을 기반으로 다양한 국가의 통화와 환율 계산을 지원한다.
    3. 환율 계산을 원하는 통화를 선택할 수 있다. (앱 부팅 시 대한민국 원화 -> 미국 달러화가 기본값이다.)
