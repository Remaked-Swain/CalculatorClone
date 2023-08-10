//
//  File.swift
//  CalculatorClone
//
//  Created by Swain Yun on 2023/08/06.
//

import Foundation

@frozen enum CurrencyCode: String, CaseIterable, CustomStringConvertible {
    case KRW
    case AED
    case AFN
    case ALL
    case AMD
    case ANG
    case AOA
    case ARS
    case AUD
    case AWG
    case AZN
    case BAM
    case BBD
    case BDT
    case BGN
    case BHD
    case BIF
    case BMD
    case BND
    case BOB
    case BRL
    case BSD
    case BTN
    case BWP
    case BYN
    case BZD
    case CAD
    case CDF
    case CHF
    case CLP
    case CNY
    case COP
    case CRC
    case CUP
    case CVE
    case CZK
    case DJF
    case DKK
    case DOP
    case DZD
    case EGP
    case ERN
    case ETB
    case EUR
    case FJD
    case FKP
    case FOK
    case GBP
    case GEL
    case GGP
    case GHS
    case GIP
    case GMD
    case GNF
    case GTQ
    case GYD
    case HKD
    case HNL
    case HRK
    case HTG
    case HUF
    case IDR
    case ILS
    case IMP
    case INR
    case IQD
    case IRR
    case ISK
    case JEP
    case JMD
    case JOD
    case JPY
    case KES
    case KGS
    case KHR
    case KID
    case KMF
    case KWD
    case KYD
    case KZT
    case LAK
    case LBP
    case LKR
    case LRD
    case LSL
    case LYD
    case MAD
    case MDL
    case MGA
    case MKD
    case MMK
    case MNT
    case MOP
    case MRU
    case MUR
    case MVR
    case MWK
    case MXN
    case MYR
    case MZN
    case NAD
    case NGN
    case NIO
    case NOK
    case NPR
    case NZD
    case OMR
    case PAB
    case PEN
    case PGK
    case PHP
    case PKR
    case PLN
    case PYG
    case QAR
    case RON
    case RSD
    case RUB
    case RWF
    case SAR
    case SBD
    case SCR
    case SDG
    case SEK
    case SGD
    case SHP
    case SLE
    case SLL
    case SOS
    case SRD
    case SSP
    case STN
    case SYP
    case SZL
    case THB
    case TJS
    case TMT
    case TND
    case TOP
    case TRY
    case TTD
    case TVD
    case TWD
    case TZS
    case UAH
    case UGX
    case USD
    case UYU
    case UZS
    case VES
    case VND
    case VUV
    case WST
    case XAF
    case XCD
    case XDR
    case XOF
    case XPF
    case YER
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
        case .ALL:
            return "알바니아 레크 (ALL)"
        case .AMD:
            return "아르메니아 드람 (AMD)"
        case .ANG:
            return "네덜란드 앤틸레스 길더 (ANG)"
        case .AOA:
            return "앙골라 콴자 (AOA)"
        case .ARS:
            return "아르헨티나 페소 (ARS)"
        case .AUD:
            return "호주 달러 (AUD)"
        case .AWG:
            return "아루바 플로린 (AWG)"
        case .AZN:
            return "아제르바이잔 마나트 (AZN)"
        case .BAM:
            return "보스니아 헤르체고비나 태환 마르카 (BAM)"
        case .BBD:
            return "바베이도스 달러 (BBD)"
        case .BDT:
            return "방글라데시 타카 (BDT)"
        case .BGN:
            return "불가리아 레프 (BGN)"
        case .BHD:
            return "바레인 디나르 (BHD)"
        case .BIF:
            return "부룬디 프랑 (BIF)"
        case .BMD:
            return "버뮤다 달러 (BMD)"
        case .BND:
            return "브루나이 달러 (BND)"
        case .BOB:
            return "볼리비아노 보리비아노 (BOB)"
        case .BRL:
            return "브라질 레알 (BRL)"
        case .BSD:
            return "바하마 달러 (BSD)"
        case .BTN:
            return "부탄 눌투눔 (BTN)"
        case .BWP:
            return "보츠와나 폴라 (BWP)"
        case .BYN:
            return "벨라루스 루블 (BYN)"
        case .BZD:
            return "벨리즈 달러 (BZD)"
        case .CAD:
            return "캐나다 달러 (CAD)"
        case .CDF:
            return "콩고 프랑 콩골라스 (CDF)"
        case .CHF:
            return "스위스 프랑 (CHF)"
        case .CLP:
            return "칠레 페소 (CLP)"
        case .CNY:
            return "중국 위안 (CNY)"
        case .COP:
            return "콜롬비아 페소 (COP)"
        case .CRC:
            return "코스타리카 콜론 (CRC)"
        case .CUP:
            return "쿠바 페소 (CUP)"
        case .CVE:
            return "카보베르데 에스쿠도 (CVE)"
        case .CZK:
            return "체코 코루나 (CZK)"
        case .DJF:
            return "지부티 프랑 (DJF)"
        case .DKK:
            return "덴마크 크로네 (DKK)"
        case .DOP:
            return "도미니카 페소 (DOP)"
        case .DZD:
            return "알제리 디나르 (DZD)"
        case .EGP:
            return "이집트 파운드 (EGP)"
        case .ERN:
            return "에리트레아 나크파 (ERN)"
        case .ETB:
            return "에티오피아 비르 (ETB)"
        case .EUR:
            return "유로 (EUR)"
        case .FJD:
            return "피지 달러 (FJD)"
        case .FKP:
            return "포클랜드 제도 파운드 (FKP)"
        case .FOK:
            return "페로 제도 크로네 (FOK)"
        case .GBP:
            return "파운드 스털링 (GBP)"
        case .GEL:
            return "조지아 라리 (GEL)"
        case .GGP:
            return "건지 제도 파운드 (GGP)"
        case .GHS:
            return "가나 시디 (GHS)"
        case .GIP:
            return "지브롤터 파운드 (GIP)"
        case .GMD:
            return "감비아 달라시 (GMD)"
        case .GNF:
            return "기니 프랑 (GNF)"
        case .GTQ:
            return "과테말라 케찰 (GTQ)"
        case .GYD:
            return "가이아나 달러 (GYD)"
        case .HKD:
            return "홍콩 달러 (HKD)"
        case .HNL:
            return "온두라스 렘피라 (HNL)"
        case .HRK:
            return "크로아티아 쿠나 (HRK)"
        case .HTG:
            return "아이티 구르드 (HTG)"
        case .HUF:
            return "헝가리 포린트 (HUF)"
        case .IDR:
            return "인도네시아 루피아 (IDR)"
        case .ILS:
            return "이스라엘 세켈 (ILS)"
        case .IMP:
            return "맨 섬 파운드 (IMP)"
        case .INR:
            return "인도 루피 (INR)"
        case .IQD:
            return "이라크 디나르 (IQD)"
        case .IRR:
            return "이란 리얄 (IRR)"
        case .ISK:
            return "아이슬란드 크로나 (ISK)"
        case .JEP:
            return "저지 세이 파운드 (JEP)"
        case .JMD:
            return "자메이카 달러 (JMD)"
        case .JOD:
            return "요르단 디나르 (JOD)"
        case .JPY:
            return "일본 엔 (JPY)"
        case .KES:
            return "케냐 실링 (KES)"
        case .KGS:
            return "키르기스스탄 솜 (KGS)"
        case .KHR:
            return "캄보디아 리얄 (KHR)"
        case .KID:
            return "키리바시 달러 (KID)"
        case .KMF:
            return "코모르 프랑 (KMF)"
        case .KWD:
            return "쿠웨이트 디나르 (KWD)"
        case .KYD:
            return "케이맨 제도 달러 (KYD)"
        case .KZT:
            return "카자흐스탄 텡게 (KZT)"
        case .LAK:
            return "라오스 키프 (LAK)"
        case .LBP:
            return "레바논 파운드 (LBP)"
        case .LKR:
            return "스리랑카 루피 (LKR)"
        case .LRD:
            return "라이베리아 달러 (LRD)"
        case .LSL:
            return "레소토 로티 (LSL)"
        case .LYD:
            return "리비아 디나르 (LYD)"
        case .MAD:
            return "모로코 디르함 (MAD)"
        case .MDL:
            return "몰도바 레이 (MDL)"
        case .MGA:
            return "마다가스카르 아리아리 (MGA)"
        case .MKD:
            return "북마케도니아 디나르 (MKD)"
        case .MMK:
            return "미얀마 키얏 (MMK)"
        case .MNT:
            return "몽골 투그릭 (MNT)"
        case .MOP:
            return "마카오 파타카 (MOP)"
        case .MRU:
            return "모리타니우 우기야 (MRU)"
        case .MUR:
            return "모리셔스 루피 (MUR)"
        case .MVR:
            return "몰디브 루피야 (MVR)"
        case .MWK:
            return "말라위 콰쳐 (MWK)"
        case .MXN:
            return "멕시코 페소 (MXN)"
        case .MYR:
            return "말레이시아 링깃 (MYR)"
        case .MZN:
            return "모잠비크 메티칼 (MZN)"
        case .NAD:
            return "나미비아 달러 (NAD)"
        case .NGN:
            return "니제리아 나이라 (NGN)"
        case .NIO:
            return "니카라과 코르도바 (NIO)"
        case .NOK:
            return "노르웨이 크로네 (NOK)"
        case .NPR:
            return "네팔 루피 (NPR)"
        case .NZD:
            return "뉴질랜드 달러 (NZD)"
        case .OMR:
            return "오만 리얄 (OMR)"
        case .PAB:
            return "파나마 발보아 (PAB)"
        case .PEN:
            return "페루 솔 (PEN)"
        case .PGK:
            return "파푸아뉴기니 키나 (PGK)"
        case .PHP:
            return "필리핀 페소 (PHP)"
        case .PKR:
            return "파키스탄 루피 (PKR)"
        case .PLN:
            return "폴란드 즐로티 (PLN)"
        case .PYG:
            return "파라과이 과라니 (PYG)"
        case .QAR:
            return "카타르 리얄 (QAR)"
        case .RON:
            return "루마니아 레우 (RON)"
        case .RSD:
            return "세르비아 디나르 (RSD)"
        case .RUB:
            return "러시아 루블 (RUB)"
        case .RWF:
            return "르완다 프랑 (RWF)"
        case .SAR:
            return "사우디아라비아 리얄 (SAR)"
        case .SBD:
            return "솔로몬 제도 달러 (SBD)"
        case .SCR:
            return "세이셸 루피 (SCR)"
        case .SDG:
            return "수단 파운드 (SDG)"
        case .SEK:
            return "스웨덴 크로나 (SEK)"
        case .SGD:
            return "싱가포르 달러 (SGD)"
        case .SHP:
            return "세인트헬레나 파운드 (SHP)"
        case .SLE:
            return "시에라리온 리온 (SLE)"
        case .SLL:
            return "레온 (SLL)"
        case .SOS:
            return "소말리아 실링 (SOS)"
        case .SRD:
            return "수리남 달러 (SRD)"
        case .SSP:
            return "남수단 파운드 (SSP)"
        case .STN:
            return "상투메 프린시페 도브라 (STN)"
        case .SYP:
            return "시리아 파운드 (SYP)"
        case .SZL:
            return "스와질란드 릴랑게니 (SZL)"
        case .THB:
            return "태국 바트 (THB)"
        case .TJS:
            return "타지키스탄 소모니 (TJS)"
        case .TMT:
            return "투르크메니스탄 마나트 (TMT)"
        case .TND:
            return "튀니지 디나르 (TND)"
        case .TOP:
            return "통가 파앙가 (TOP)"
        case .TRY:
            return "터키 리라 (TRY)"
        case .TTD:
            return "트리니다드 토바고 달러 (TTD)"
        case .TVD:
            return "투발루 파운드 (TVD)"
        case .TWD:
            return "신 타이완 달러 (TWD)"
        case .TZS:
            return "탄자니아 실링 (TZS)"
        case .UAH:
            return "우크라이나 그리브나 (UAH)"
        case .UGX:
            return "우간다 실링 (UGX)"
        case .USD:
            return "미국 달러 (USD)"
        case .UYU:
            return "우루과이 페소 (UYU)"
        case .UZS:
            return "우즈베키스탄 숨 (UZS)"
        case .VES:
            return "베네주엘라 볼리바르 (VES)"
        case .VND:
            return "베트남 동 (VND)"
        case .VUV:
            return "바누아투 바투 (VUV)"
        case .WST:
            return "사모아 탈라 (WST)"
        case .XAF:
            return "중앙아프리카 CFA 프랑 (XAF)"
        case .XCD:
            return "동카리브 달러 (XCD)"
        case .XDR:
            return "특별인출권 (XDR)"
        case .XOF:
            return "서아프리카 CFA 프랑 (XOF)"
        case .XPF:
            return "CFP 프랑 (XPF)"
        case .YER:
            return "예멘 리알 (YER)"
        case .ZAR:
            return "남아프리카 랜드 (ZAR)"
        case .ZMW:
            return "잠비아 콰쳐 (ZMW)"
        case .ZWL:
            return "짐바브웨 달러 (ZWL)"
        }
    }
}
