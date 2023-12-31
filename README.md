#  Calculator Clone
아이폰의 기본 앱 중 하나인 계산기 앱을 클론해보자.

## ScreenShots
* 일반 계산기, 환율 계산기 화면과 메뉴 스위칭 버튼

<p>
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_CoreView.PNG?raw=true" alt="CoreView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_Menu.PNG?raw=true" alt="Menu" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_ExchangeRateView.PNG?raw=true" alt="ExchangeRateView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_ExchangeRateView_CurrencyMenu.PNG?raw=true" alt="CurrencyMenu" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_MeasurementView.PNG?raw=true" alt="MeasurementView" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_MeasurementView_2.PNG?raw=true" alt="MeasurementView2" width="250px">
    <img src="https://github.com/Remaked-Swain/ScreenShotRepository/blob/main/CalcClone/CalcClone_MeasurementView_DimensionMenu.PNG?raw=true" alt="DimensionMenu" width="250px">
</p>

> 아이폰 기본 앱 중 하나인 계산기 앱을 따라 만들어 봄.
> 또한 이 계산기에 새로운 기능을 넣어보고 싶어졌고, 이에 다양한 통화에 대한 환율 계산을 수행하는 기능과 측정 단위를 변환해주는 기능을 넣기로 하였음.

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

    * ExchangeRateModel
    1. baseCode는 기준 통화를 의미하며 1의 리터럴 값을 가짐.
    2. conversionRates 딕셔너리는 국가코드를 키 값으로 찾을 수 있는 기준 통화 대비 비교 통화의 환율 데이터를 가짐.
> 국가코드를 사용해 환율 데이터를 가져올 수 있으므로 이를 열거형으로 묶어서 관리할 필요를 느끼게 되었다. 겸사겸사 각 국 통화이름도 정리해주자.

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

    * CurrencyCode
    1. JSON 응답에 존재하는 모든 국가코드에 대한 열거.
    2. RawValue -> String 의 키 값을 사용할 수 있도록 함.
    3. 모든 케이스에 대해 뷰에서 선택할 수 있도록 CaseIterable 채택함.
    4. 국가코드를 헷갈려 할 여지가 보이기에 description 프로퍼티를 정의함.
> 모든 국가코드에 대해서 국가명과 화폐명을 알아내 정리하는 것은 ChatGPT의 도움을 받았다.

---------------------------------------

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

---------------------------------------

## MeasurementViewModel & UnitType
Dimension과 그 서브클래스인 각종 유닛들에 대하여 관리하기 위한 UnitType 열거형과 뷰 모델

* UnitType

```Swift
@frozen enum UnitType: String, CaseIterable, CustomStringConvertible {
    case acceleration, angle, area, concentrationMass, duration, electricCharge, electricCurrent, electricPotentialDifference, electricResistance, energy, frequency, fuelEfficiency, informationStorage, length, mass, power, pressure, speed, temperature, volume
    
    var unitList: [Dimension] {
        switch self {
        case .acceleration: return Acceleration.allCases.map {$0.unit}
        case .angle: return Angle.allCases.map {$0.unit}
        case .area: return Area.allCases.map {$0.unit}
        case .concentrationMass: return ConcentrationMass.allCases.map {$0.unit}
        case .duration: return Duration.allCases.map {$0.unit}
        case .electricCharge: return ElectricCharge.allCases.map {$0.unit}
        case .electricCurrent: return ElectricCurrent.allCases.map {$0.unit}
        case .electricPotentialDifference: return ElectricPotentialDifference.allCases.map {$0.unit}
        case .electricResistance: return ElectricResistance.allCases.map {$0.unit}
        case .energy: return Energy.allCases.map {$0.unit}
        case .frequency: return Frequency.allCases.map {$0.unit}
        case .fuelEfficiency: return FuelEfficiency.allCases.map {$0.unit}
        case .informationStorage: return InformationStorage.allCases.map {$0.unit}
        case .length: return Length.allCases.map {$0.unit}
        case .mass: return Mass.allCases.map {$0.unit}
        case .power: return Power.allCases.map {$0.unit}
        case .pressure: return Pressure.allCases.map {$0.unit}
        case .speed: return Speed.allCases.map {$0.unit}
        case .temperature: return Temperature.allCases.map {$0.unit}
        case .volume: return Volume.allCases.map {$0.unit}
        }
    }
    
    var description: String {
        switch self {
        case .acceleration: return "가속도"
        case .angle: return "각도"
        case .area: return "면적"
        case .concentrationMass: return "질량 농도"
        case .duration: return "시간"
        case .electricCharge: return "전하량"
        case .electricCurrent: return "전류"
        case .electricPotentialDifference: return "전위 차이"
        case .electricResistance: return "전기 저항"
        case .energy: return "에너지"
        case .frequency: return "주파수"
        case .fuelEfficiency: return "연료 효율"
        case .informationStorage: return "정보 저장"
        case .length: return "길이"
        case .mass: return "질량"
        case .power: return "전력"
        case .pressure: return "압력"
        case .speed: return "속도"
        case .temperature: return "온도"
        case .volume: return "부피"
        }
    }
    
    // 생략...
    
    @frozen enum Volume: CaseIterable {
        case megaliters, kiloliters, liters, deciliters, centiliters, milliliters, cubicKilometers, cubicMeters, cubicDecimeters, cubicCentimeters, cubicMillimeters, cubicInches, cubicFeet, cubicYards, cubicMiles, acreFeet, bushels, teaspoons, tablespoons, fluidOunces, cups, pints, quarts, gallons, imperialTeaspoons, imperialTablespoons, imperialFluidOunces, imperialPints, imperialQuarts, imperialGallons, metricCups
        
        var unit: UnitVolume {
            switch self {
            case .megaliters: return .megaliters
            case .kiloliters: return .kiloliters
            case .liters: return .liters
            case .deciliters: return .deciliters
            case .centiliters: return .centiliters
            case .milliliters: return .milliliters
            case .cubicKilometers: return .cubicKilometers
            case .cubicMeters: return .cubicMeters
            case .cubicDecimeters: return .cubicDecimeters
            case .cubicCentimeters: return .cubicCentimeters
            case .cubicMillimeters: return .cubicMillimeters
            case .cubicInches: return .cubicInches
            case .cubicFeet: return .cubicFeet
            case .cubicYards: return .cubicYards
            case .cubicMiles: return .cubicMiles
            case .acreFeet: return .acreFeet
            case .bushels: return .bushels
            case .teaspoons: return .teaspoons
            case .tablespoons: return .tablespoons
            case .fluidOunces: return .fluidOunces
            case .cups: return .cups
            case .pints: return .pints
            case .quarts: return .quarts
            case .gallons: return .gallons
            case .imperialTeaspoons: return .imperialTeaspoons
            case .imperialTablespoons: return .imperialTablespoons
            case .imperialFluidOunces: return .imperialFluidOunces
            case .imperialPints: return .imperialPints
            case .imperialQuarts: return .imperialQuarts
            case .imperialGallons: return .imperialGallons
            case .metricCups: return .metricCups
            }
        }
    }
}
```

    * UnitType
    1. 각 케이스는 곧 Dimension의 하위 클래스 유닛이 내포하고 있는 모든 측정 단위의 배열.
    2. 배열로 전달되기 때문에 ForEach문을 통해 뷰에 그려주기 편하도록 함.
> UnitLength, UnitMass 등 Dimension과 Measurement 클래스에 대해 공부하고 어떻게 활용할 수 있을까 다양한 시도를 했다.
> 이때 어려웠던 점은, 사용자가 변환을 원하는 단위를 선택하여야 하는데 뷰 모델에서 입력된 Dimension을 인식하고, 그 Dimension의 유닛을 식별해서, 선택가능한 측정 단위를 모두 보여주고 고르게 하는 과정을 구현하기 였다.
> 아마 지금처럼 UnitType 열거형으로 정리하는 것보다 더 목적이 분명하고 효율적인 방법이 있을 테지만 현재로서는 내가 원하는대로 동작시키기 위해 이렇게 작성하는 것이 최선인 것 같다.

* MeasurementViewModel

```Swift
class MeasurementViewModel: ObservableObject {
    @Published var selectedUnitType: UnitType = .area
    @Published var selectableUnitList: [Dimension] = []
    @Published var baseUnit: Dimension?
    @Published var baseUnitAmount: Double = 0
    @Published var comparisonUnit: Dimension?
    @Published var comparisonUnitAmount: Double = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    // 생략...
    
    init() {
        addSubscription()
    }
    
    private func addSubscription() {
        $selectedUnitType
            .sink { [weak self] receiveUnitType in
                self?.selectableUnitList = receiveUnitType.unitList
                self?.baseUnit = receiveUnitType.unitList.first
                self?.comparisonUnit = receiveUnitType.unitList.first
            }
            .store(in: &cancellables)
        
        $baseUnitAmount
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] receiveAmount in
                guard let self = self, let baseUnit = baseUnit, let comparisonUnit = comparisonUnit else { return }
                self.comparisonUnitAmount = convertUnit(receiveAmount, baseUnit, comparisonUnit)
            }
            .store(in: &cancellables)
    }
    
    // 생략...
}

// MARK: Internal Methods
extension MeasurementViewModel {
    // 생략...
}

// MARK: Private Methods
extension MeasurementViewModel {
    private func convertUnit(_ amount: Double, _ baseUnit: Dimension, _ comparisonUnit: Dimension) -> Double {
        let baseMeasurement = Measurement(value: amount, unit: baseUnit)
        return baseMeasurement.converted(to: comparisonUnit).value
    }
    
    // 생략...
}

```

    * MeasurementViewModel
    1. 사용자의 UI 조작에 따라 적절한 비즈니스 로직을 처리하고 뷰 자체의 코드는 최대한 UI 관련 요소만 담을 수 있도록 뷰 모델을 만들었음.
    2. UnitType을 보면 큰 단위의 Dimension 종류가 존재하고, 그 종류에 다양한 작은 측정 단위들이 존재하는 걸 알 수 있음.
    3. @Published var selectedUnitType은 큰 단위인 Dimension이 무엇으로 선택되어있는지 나타내기 위한 프로퍼티.
    4. Dimension이 결정되면 selectableUnitList는 그 Dimension의 서브클래스에서 다룰 수 있는 측정 단위들의 배열로 세팅됨.
    5. 사용자는 selectableUnitList 내에 있는 측정 단위 중에서 하나씩 선택하며 단위 간 변환을 할 수 있음.
    6. 역시 ExchangeRateViewModel에서 했던 것과 마찬가지로, 숫자를 입력하면 그 변화를 감지하여 convertUnit 메서드가 호출, 변환값을 얻을 수 있게 됨.
> MeasurementView 에서는 ExchangeRateView에서 사용했던 키패드 버튼들을 똑같이 사용해도 되는지라 KeypadButtonView의 코드를 재사용하길 원했으나, 뷰 모델을 환경객체로 삽입하는 과정을 독립시키지 못했다.
> 그래서 두 뷰 모델은 겹치는 코드가 굉장히 많아져버렸다.
> 측정 단위를 변환하는 기능을 추가하는 과정에서 Combine프레임워크를 많이 연습해볼 수 있었으며, 재사용 가능성이 있는 컴포넌트에 대한 설계가 얼마나 중요한지 깨달을 수 있었다.
> 또한 Foundation에 담겨있던 Dimension, Measurement에 대해 새롭게 배우고, 그것을 커스텀한 열거형으로 바꿀 때 어떤 한계가 있으며 어떻게 해야 돌파할 수 있는지 다양한 방식의 코드를 작성해볼 수 있었다.
