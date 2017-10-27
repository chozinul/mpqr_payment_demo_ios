//
//  CurrencyEnum.m
//  MasterpassQRCoreSDKV2
//
//  Created by MasterCard on 22/9/17.
//  Copyright © 2017 MasterCard. All rights reserved.
//

#import "CurrencyEnum.h"

@implementation CurrencyEnumLookup

+ (NSString* _Nullable) getCurrencyCodeNumeric:(enum CurrencyEnum) inputEnum
{
    switch (inputEnum) {
        case ADP: return @"020"; break;
        case AED: return @"784"; break;
        case AFA: return @"004"; break;
        case AFN: return @"971"; break;
        case ALL: return @"008"; break;
        case AMD: return @"051"; break;
        case ANG: return @"532"; break;
        case AOA: return @"973"; break;
        case ARS: return @"032"; break;
        case ATS: return @"040"; break;
        case AUD: return @"036"; break;
        case AWG: return @"533"; break;
        case AYM: return @"945"; break;
        case AZM: return @"031"; break;
        case AZN: return @"944"; break;
        case BAM: return @"977"; break;
        case BBD: return @"052"; break;
        case BDT: return @"050"; break;
        case BEF: return @"056"; break;
        case BGL: return @"100"; break;
        case BGN: return @"975"; break;
        case BHD: return @"048"; break;
        case BIF: return @"108"; break;
        case BMD: return @"060"; break;
        case BND: return @"096"; break;
        case BOB: return @"068"; break;
        case BOV: return @"984"; break;
        case BRL: return @"986"; break;
        case bsd: return @"044"; break;
        case BTN: return @"064"; break;
        case BWP: return @"072"; break;
        case BYB: return @"112"; break;
        case BYR: return @"974"; break;
        case BYN: return @"933"; break;
        case BZD: return @"084"; break;
        case CAD: return @"124"; break;
        case CDF: return @"976"; break;
        case CHE: return @"947"; break;
        case CHF: return @"756"; break;
        case CHW: return @"948"; break;
        case CLF: return @"990"; break;
        case CLP: return @"152"; break;
        case CNY: return @"156"; break;
        case COP: return @"170"; break;
        case COU: return @"970"; break;
        case CRC: return @"188"; break;
        case CSD: return @"891"; break;
        case CUC: return @"931"; break;
        case CUP: return @"192"; break;
        case CVE: return @"132"; break;
        case CYP: return @"196"; break;
        case CZK: return @"203"; break;
        case DEM: return @"276"; break;
        case DJF: return @"262"; break;
        case DKK: return @"208"; break;
        case DOP: return @"214"; break;
        case DZD: return @"012"; break;
        case EEK: return @"233"; break;
        case EGP: return @"818"; break;
        case ERN: return @"232"; break;
        case ESP: return @"724"; break;
        case ETB: return @"230"; break;
        case EUR: return @"978"; break;
        case FIM: return @"246"; break;
        case FJD: return @"242"; break;
        case FKP: return @"238"; break;
        case FRF: return @"250"; break;
        case GBP: return @"826"; break;
        case GEL: return @"981"; break;
        case GHC: return @"288"; break;
        case GHS: return @"936"; break;
        case GIP: return @"292"; break;
        case GMD: return @"270"; break;
        case GNF: return @"324"; break;
        case GTQ: return @"320"; break;
        case GWP: return @"624"; break;
        case GYD: return @"328"; break;
        case HKD: return @"344"; break;
        case HNL: return @"340"; break;
        case HRK: return @"191"; break;
        case HTG: return @"332"; break;
        case HUF: return @"348"; break;
        case IDR: return @"360"; break;
        case IEP: return @"372"; break;
        case ILS: return @"376"; break;
        case INR: return @"356"; break;
        case IQD: return @"368"; break;
        case IRR: return @"364"; break;
        case ISK: return @"352"; break;
        case ITL: return @"380"; break;
        case JMD: return @"388"; break;
        case JOD: return @"400"; break;
        case JPY: return @"392"; break;
        case KES: return @"404"; break;
        case KGS: return @"417"; break;
        case KHR: return @"116"; break;
        case KMF: return @"174"; break;
        case KPW: return @"408"; break;
        case KRW: return @"410"; break;
        case KWD: return @"414"; break;
        case KYD: return @"136"; break;
        case KZT: return @"398"; break;
        case LAK: return @"418"; break;
        case LBP: return @"422"; break;
        case LKR: return @"144"; break;
        case LRD: return @"430"; break;
        case LSL: return @"426"; break;
        case LVL: return @"428"; break;
        case LYD: return @"434"; break;
        case MAD: return @"504"; break;
        case MDL: return @"498"; break;
        case MGA: return @"969"; break;
        case MGF: return @"450"; break;
        case MKD: return @"807"; break;
        case MMK: return @"104"; break;
        case MNT: return @"496"; break;
        case MOP: return @"446"; break;
        case MRO: return @"478"; break;
        case MTL: return @"470"; break;
        case MUR: return @"480"; break;
        case MVR: return @"462"; break;
        case MWK: return @"454"; break;
        case MXN: return @"484"; break;
        case MXV: return @"979"; break;
        case MYR: return @"458"; break;
        case MZN: return @"943"; break;
        case NAD: return @"516"; break;
        case NGN: return @"566"; break;
        case NIO: return @"558"; break;
        case NLG: return @"528"; break;
        case NOK: return @"578"; break;
        case NPR: return @"524"; break;
        case NZD: return @"554"; break;
        case OMR: return @"512"; break;
        case PAB: return @"590"; break;
        case PEN: return @"604"; break;
        case PGK: return @"598"; break;
        case PHP: return @"608"; break;
        case PKR: return @"586"; break;
        case PLN: return @"985"; break;
        case PTE: return @"620"; break;
        case PYG: return @"600"; break;
        case QAR: return @"634"; break;
        case ROL: return @"642"; break;
        case RON: return @"946"; break;
        case RSD: return @"941"; break;
        case RUB: return @"643"; break;
        case RWF: return @"646"; break;
        case SAR: return @"682"; break;
        case SBD: return @"090"; break;
        case SCR: return @"690"; break;
        case SDD: return @"736"; break;
        case SDG: return @"938"; break;
        case SEK: return @"752"; break;
        case SGD: return @"702"; break;
        case SHP: return @"654"; break;
        case SIT: return @"705"; break;
        case SKK: return @"703"; break;
        case SLL: return @"694"; break;
        case SOS: return @"706"; break;
        case SRD: return @"968"; break;
        case SRG: return @"740"; break;
        case SSP: return @"728"; break;
        case STD: return @"678"; break;
        case SVC: return @"222"; break;
        case SYP: return @"760"; break;
        case SZL: return @"748"; break;
        case THB: return @"764"; break;
        case TJS: return @"972"; break;
        case TMM: return @"795"; break;
        case TMT: return @"934"; break;
        case TND: return @"788"; break;
        case TOP: return @"776"; break;
        case TPE: return @"626"; break;
        case TRL: return @"792"; break;
        case TRY: return @"949"; break;
        case TTD: return @"780"; break;
        case TWD: return @"901"; break;
        case TZS: return @"834"; break;
        case UAH: return @"980"; break;
        case UGX: return @"800"; break;
        case USD: return @"840"; break;
        case USN: return @"997"; break;
        case USS: return @"998"; break;
        case UYI: return @"940"; break;
        case UYU: return @"858"; break;
        case UZS: return @"860"; break;
        case VEB: return @"862"; break;
        case VEF: return @"937"; break;
        case VND: return @"704"; break;
        case VUV: return @"548"; break;
        case WST: return @"882"; break;
        case XAF: return @"950"; break;
        case XAG: return @"961"; break;
        case XAU: return @"959"; break;
        case XBA: return @"955"; break;
        case XBB: return @"956"; break;
        case XBC: return @"957"; break;
        case XBD: return @"958"; break;
        case XCD: return @"951"; break;
        case XDR: return @"960"; break;
        case XOF: return @"952"; break;
        case XPD: return @"964"; break;
        case XPF: return @"953"; break;
        case XPT: return @"962"; break;
        case XSU: return @"994"; break;
        case XTS: return @"963"; break;
        case XUA: return @"965"; break;
        case XXX: return @"999"; break;
        case YER: return @"886"; break;
        case YUM: return @"891"; break;
        case ZAR: return @"710"; break;
        case ZMK: return @"894"; break;
        case ZMW: return @"967"; break;
        case ZWD: return @"716"; break;
        case ZWL: return @"932"; break;
        case ZWN: return @"942"; break;
        case ZWR: return @"935"; break;
        default: break;
    }
    return @"";
}

+ (NSString* _Nullable) getAlphaCode:(enum CurrencyEnum) inputEnum
{
     switch (inputEnum) {
         case HRK: return @"HRK"; break;//1
         case HUF: return @"HUF"; break;//2
         case SDD: return @"SDD"; break;//3
         case CDF: return @"CDF"; break;//4
         case ILS: return @"ILS"; break;//5
         case NGN: return @"NGN"; break;//6
         case GYD: return @"GYD"; break;//7
         case BYR: return @"BYR"; break;//8
         case BHD: return @"BHD"; break;//9
         case SZL: return @"SZL"; break;//10
         case NLG: return @"NLG"; break;//11
         case CYP: return @"CYP"; break;//12
         case INR: return @"INR"; break;//13
         case SDG: return @"SDG"; break;//14
         case USS: return @"USS"; break;//15
         case UYI: return @"UYI"; break;//16
         case PEN: return @"PEN"; break;//17
         case EUR: return @"EUR"; break;//18
         case QAR: return @"QAR"; break;//19
         case PGK: return @"PGK"; break;//20
         case LRD: return @"LRD"; break;//21
         case ISK: return @"ISK"; break;//22
         case SYP: return @"SYP"; break;//23
         case ADP: return @"ADP"; break;//24
         case TRY: return @"TRY"; break;//25
         case UAH: return @"UAH"; break;//26
         case SGD: return @"SGD"; break;//27
         case MMK: return @"MMK"; break;//28
         case NIO: return @"NIO"; break;//29
         case BIF: return @"BIF"; break;//30
         case CHE: return @"CHE"; break;//31
         case AFN: return @"AFN"; break;//32
         case LKR: return @"LKR"; break;//33
         case GTQ: return @"GTQ"; break;//34
         case CHF: return @"CHF"; break;//35
         case ITL: return @"ITL"; break;//36
         case XPT: return @"XPT"; break;//37
         case THB: return @"THB"; break;//38
         case AMD: return @"AMD"; break;//39
         case XBA: return @"XBA"; break;//40
         case AOA: return @"AOA"; break;//41
         case VEB: return @"VEB"; break;//42
         case BGL: return @"BGL"; break;//43
         case XBB: return @"XBB"; break;//44
         case SEK: return @"SEK"; break;//45
         case ZWD: return @"ZWD"; break;//46
         case SAR: return @"SAR"; break;//47
         case KWD: return @"KWD"; break;//48
         case IRR: return @"IRR"; break;//49
         case WST: return @"WST"; break;//50
         case XBC: return @"XBC"; break;//51
         case BGN: return @"BGN"; break;//52
         case BMD: return @"BMD"; break;//53
         case GWP: return @"GWP"; break;//54
         case PHP: return @"PHP"; break;//55
         case XBD: return @"XBD"; break;//56
         case XAF: return @"XAF"; break;//57
         case ZMW: return @"ZMW"; break;//58
         case BDT: return @"BDT"; break;//59
         case NOK: return @"NOK"; break;//60
         case DEM: return @"DEM"; break;//61
         case BOB: return @"BOB"; break;//62
         case YUM: return @"YUM"; break;//63
         case TZS: return @"TZS"; break;//64
         case BND: return @"BND"; break;//65
         case VEF: return @"VEF"; break;//66
         case ANG: return @"ANG"; break;//67
         case EEK: return @"EEK"; break;//68
         case SCR: return @"SCR"; break;//69
         case VUV: return @"VUV"; break;//70
         case XAG: return @"XAG"; break;//71
         case KYD: return @"KYD"; break;//72
         case DJF: return @"DJF"; break;//73
         case XCD: return @"XCD"; break;//74
         case XTS: return @"XTS"; break;//75
         case XSU: return @"XSU"; break;//76
         case CLF: return @"CLF"; break;//77
         case LSL: return @"LSL"; break;//78
         case MOP: return @"MOP"; break;//79
         case ALL: return @"ALL"; break;//80
         case UZS: return @"UZS"; break;//81
         case GHC: return @"GHC"; break;//82
         case PLN: return @"PLN"; break;//83
         case UYU: return @"UYU"; break;//84
         case LYD: return @"LYD"; break;//85
         case JPY: return @"JPY"; break;//86
         case MNT: return @"MNT"; break;//87
         case FJD: return @"FJD"; break;//88
         case ZWL: return @"ZWL"; break;//89
         case KPW: return @"KPW"; break;//90
         case PKR: return @"PKR"; break;//91
         case MRO: return @"MRO"; break;//92
         case GBP: return @"GBP"; break;//93
         case MTL: return @"MTL"; break;//94
         case OMR: return @"OMR"; break;//95
         case LVL: return @"LVL"; break;//96
         case SHP: return @"SHP"; break;//97
         case SKK: return @"SKK"; break;//98
         case GEL: return @"GEL"; break;//99
         case ZWN: return @"ZWN"; break;//100
         case PTE: return @"PTE"; break;//101
         case TND: return @"TND"; break;//102
         case DKK: return @"DKK"; break;//103
         case KRW: return @"KRW"; break;//104
         case NPR: return @"NPR"; break;//105
         case bsd: return @"BSD"; break;//106
         case CRC: return @"CRC"; break;//107
         case EGP: return @"EGP"; break;//108
         case AUD: return @"AUD"; break;//109
         case MAD: return @"MAD"; break;//110
         case SLL: return @"SLL"; break;//111
         case MWK: return @"MWK"; break;//112
         case RSD: return @"RSD"; break;//113
         case ZWR: return @"ZWR"; break;//114
         case NZD: return @"NZD"; break;//115
         case CSD: return @"CSD"; break;//116
         case SRD: return @"SRD"; break;//117
         case CLP: return @"CLP"; break;//118
         case ROL: return @"ROL"; break;//119
         case HKD: return @"HKD"; break;//120
         case CHW: return @"CHW"; break;//121
         case FIM: return @"FIM"; break;//122
         case NAD: return @"NAD"; break;//123
         case RUB: return @"RUB"; break;//124
         case GMD: return @"GMD"; break;//125
         case SIT: return @"SIT"; break;//126
         case TPE: return @"TPE"; break;//127
         case XXX: return @"XXX"; break;//128
         case VND: return @"VND"; break;//129
         case LAK: return @"LAK"; break;//130
         case CUC: return @"CUC"; break;//131
         case RON: return @"RON"; break;//132
         case MUR: return @"MUR"; break;//133
         case XAU: return @"XAU"; break;//134
         case SRG: return @"SRG"; break;//135
         case BRL: return @"BRL"; break;//136
         case MXN: return @"MXN"; break;//137
         case STD: return @"STD"; break;//138
         case TMM: return @"TMM"; break;//139
         case AWG: return @"AWG"; break;//140
         case MVR: return @"MVR"; break;//141
         case PAB: return @"PAB"; break;//142
         case TJS: return @"TJS"; break;//143
         case GNF: return @"GNF"; break;//144
         case MGA: return @"MGA"; break;//145
         case XDR: return @"XDR"; break;//146
         case BYB: return @"BYB"; break;//147
         case COP: return @"COP"; break;//148
         case ETB: return @"ETB"; break;//149
         case IEP: return @"IEP"; break;//150
         case IDR: return @"IDR"; break;//151
         case ZAR: return @"ZAR"; break;//152
         case SVC: return @"SVC"; break;//153
         case CVE: return @"CVE"; break;//154
         case TTD: return @"TTD"; break;//155
         case GIP: return @"GIP"; break;//156
         case PYG: return @"PYG"; break;//157
         case MZN: return @"MZN"; break;//158
         case FKP: return @"FKP"; break;//159
         case KZT: return @"KZT"; break;//160
         case UGX: return @"UGX"; break;//161
         case USD: return @"USD"; break;//162
         case ARS: return @"ARS"; break;//163
         case GHS: return @"GHS"; break;//164
         case RWF: return @"RWF"; break;//165
         case DOP: return @"DOP"; break;//166
         case BOV: return @"BOV"; break;//167
         case FRF: return @"FRF"; break;//168
         case LBP: return @"LBP"; break;//169
         case BTN: return @"BTN"; break;//170
         case BZD: return @"BZD"; break;//171
         case MYR: return @"MYR"; break;//172
         case YER: return @"YER"; break;//173
         case JMD: return @"JMD"; break;//174
         case MGF: return @"MGF"; break;//175
         case TOP: return @"TOP"; break;//176
         case SOS: return @"SOS"; break;//177
         case COU: return @"COU"; break;//178
         case TMT: return @"TMT"; break;//179
         case MDL: return @"MDL"; break;//180
         case XPD: return @"XPD"; break;//181
         case TRL: return @"TRL"; break;//182
         case ATS: return @"ATS"; break;//183
         case XOF: return @"XOF"; break;//184
         case TWD: return @"TWD"; break;//185
         case BBD: return @"BBD"; break;//186
         case MXV: return @"MXV"; break;//187
         case AFA: return @"AFA"; break;//188
         case CAD: return @"CAD"; break;//189
         case CNY: return @"CNY"; break;//190
         case JOD: return @"JOD"; break;//191
         case XPF: return @"XPF"; break;//192
         case IQD: return @"IQD"; break;//193
         case AYM: return @"AYM"; break;//194
         case HNL: return @"HNL"; break;//195
         case AED: return @"AED"; break;//196
         case ERN: return @"ERN"; break;//197
         case KES: return @"KES"; break;//198
         case SSP: return @"SSP"; break;//199
         case KMF: return @"KMF"; break;//200
         case DZD: return @"DZD"; break;//201
         case MKD: return @"MKD"; break;//202
         case AZM: return @"AZM"; break;//203
         case CUP: return @"CUP"; break;//204
         case BWP: return @"BWP"; break;//205
         case AZN: return @"AZN"; break;//206
         case SBD: return @"SBD"; break;//207
         case XUA: return @"XUA"; break;//208
         case BYN: return @"BYN"; break;//209
         case KGS: return @"KGS"; break;//210
         case USN: return @"USN"; break;//211
         case ESP: return @"ESP"; break;//212
         case KHR: return @"KHR"; break;//213
         case ZMK: return @"ZMK"; break;//214
         case BEF: return @"BEF"; break;//215
         case HTG: return @"HTG"; break;//216
         case CZK: return @"CZK"; break;//217
         case BAM: return @"BAM"; break;//218
         default: break;
     }
    return @"";
}
+ (enum CurrencyEnum) enumFor:(NSString* _Nonnull) input
{
    if ([input isEqualToString:@"191"]) return HRK;
    if ([input isEqualToString:@"348"]) return HUF;
    if ([input isEqualToString:@"736"]) return SDD;
    if ([input isEqualToString:@"976"]) return CDF;
    if ([input isEqualToString:@"376"]) return ILS;
    if ([input isEqualToString:@"566"]) return NGN;
    if ([input isEqualToString:@"328"]) return GYD;
    if ([input isEqualToString:@"974"]) return BYR;
    if ([input isEqualToString:@"048"]) return BHD;
    if ([input isEqualToString:@"748"]) return SZL;
    if ([input isEqualToString:@"528"]) return NLG;
    if ([input isEqualToString:@"196"]) return CYP;
    if ([input isEqualToString:@"356"]) return INR;
    if ([input isEqualToString:@"938"]) return SDG;
    if ([input isEqualToString:@"998"]) return USS;
    if ([input isEqualToString:@"940"]) return UYI;
    if ([input isEqualToString:@"604"]) return PEN;
    if ([input isEqualToString:@"978"]) return EUR;
    if ([input isEqualToString:@"634"]) return QAR;
    if ([input isEqualToString:@"598"]) return PGK;
    if ([input isEqualToString:@"430"]) return LRD;
    if ([input isEqualToString:@"352"]) return ISK;
    if ([input isEqualToString:@"760"]) return SYP;
    if ([input isEqualToString:@"020"]) return ADP;
    if ([input isEqualToString:@"949"]) return TRY;
    if ([input isEqualToString:@"980"]) return UAH;
    if ([input isEqualToString:@"702"]) return SGD;
    if ([input isEqualToString:@"104"]) return MMK;
    if ([input isEqualToString:@"558"]) return NIO;
    if ([input isEqualToString:@"108"]) return BIF;
    if ([input isEqualToString:@"947"]) return CHE;
    if ([input isEqualToString:@"971"]) return AFN;
    if ([input isEqualToString:@"144"]) return LKR;
    if ([input isEqualToString:@"320"]) return GTQ;
    if ([input isEqualToString:@"756"]) return CHF;
    if ([input isEqualToString:@"380"]) return ITL;
    if ([input isEqualToString:@"962"]) return XPT;
    if ([input isEqualToString:@"764"]) return THB;
    if ([input isEqualToString:@"051"]) return AMD;
    if ([input isEqualToString:@"955"]) return XBA;
    if ([input isEqualToString:@"973"]) return AOA;
    if ([input isEqualToString:@"862"]) return VEB;
    if ([input isEqualToString:@"100"]) return BGL;
    if ([input isEqualToString:@"956"]) return XBB;
    if ([input isEqualToString:@"752"]) return SEK;
    if ([input isEqualToString:@"716"]) return ZWD;
    if ([input isEqualToString:@"682"]) return SAR;
    if ([input isEqualToString:@"414"]) return KWD;
    if ([input isEqualToString:@"364"]) return IRR;
    if ([input isEqualToString:@"882"]) return WST;
    if ([input isEqualToString:@"957"]) return XBC;
    if ([input isEqualToString:@"975"]) return BGN;
    if ([input isEqualToString:@"060"]) return BMD;
    if ([input isEqualToString:@"624"]) return GWP;
    if ([input isEqualToString:@"608"]) return PHP;
    if ([input isEqualToString:@"958"]) return XBD;
    if ([input isEqualToString:@"950"]) return XAF;
    if ([input isEqualToString:@"967"]) return ZMW;
    if ([input isEqualToString:@"050"]) return BDT;
    if ([input isEqualToString:@"578"]) return NOK;
    if ([input isEqualToString:@"276"]) return DEM;
    if ([input isEqualToString:@"068"]) return BOB;
    if ([input isEqualToString:@"891"]) return YUM;
    if ([input isEqualToString:@"834"]) return TZS;
    if ([input isEqualToString:@"096"]) return BND;
    if ([input isEqualToString:@"937"]) return VEF;
    if ([input isEqualToString:@"532"]) return ANG;
    if ([input isEqualToString:@"233"]) return EEK;
    if ([input isEqualToString:@"690"]) return SCR;
    if ([input isEqualToString:@"548"]) return VUV;
    if ([input isEqualToString:@"961"]) return XAG;
    if ([input isEqualToString:@"136"]) return KYD;
    if ([input isEqualToString:@"262"]) return DJF;
    if ([input isEqualToString:@"951"]) return XCD;
    if ([input isEqualToString:@"963"]) return XTS;
    if ([input isEqualToString:@"994"]) return XSU;
    if ([input isEqualToString:@"990"]) return CLF;
    if ([input isEqualToString:@"426"]) return LSL;
    if ([input isEqualToString:@"446"]) return MOP;
    if ([input isEqualToString:@"008"]) return ALL;
    if ([input isEqualToString:@"860"]) return UZS;
    if ([input isEqualToString:@"288"]) return GHC;
    if ([input isEqualToString:@"985"]) return PLN;
    if ([input isEqualToString:@"858"]) return UYU;
    if ([input isEqualToString:@"434"]) return LYD;
    if ([input isEqualToString:@"392"]) return JPY;
    if ([input isEqualToString:@"496"]) return MNT;
    if ([input isEqualToString:@"242"]) return FJD;
    if ([input isEqualToString:@"932"]) return ZWL;
    if ([input isEqualToString:@"408"]) return KPW;
    if ([input isEqualToString:@"586"]) return PKR;
    if ([input isEqualToString:@"478"]) return MRO;
    if ([input isEqualToString:@"826"]) return GBP;
    if ([input isEqualToString:@"470"]) return MTL;
    if ([input isEqualToString:@"512"]) return OMR;
    if ([input isEqualToString:@"428"]) return LVL;
    if ([input isEqualToString:@"654"]) return SHP;
    if ([input isEqualToString:@"703"]) return SKK;
    if ([input isEqualToString:@"981"]) return GEL;
    if ([input isEqualToString:@"942"]) return ZWN;
    if ([input isEqualToString:@"620"]) return PTE;
    if ([input isEqualToString:@"788"]) return TND;
    if ([input isEqualToString:@"208"]) return DKK;
    if ([input isEqualToString:@"410"]) return KRW;
    if ([input isEqualToString:@"524"]) return NPR;
    if ([input isEqualToString:@"044"]) return bsd;
    if ([input isEqualToString:@"188"]) return CRC;
    if ([input isEqualToString:@"818"]) return EGP;
    if ([input isEqualToString:@"036"]) return AUD;
    if ([input isEqualToString:@"504"]) return MAD;
    if ([input isEqualToString:@"694"]) return SLL;
    if ([input isEqualToString:@"454"]) return MWK;
    if ([input isEqualToString:@"941"]) return RSD;
    if ([input isEqualToString:@"935"]) return ZWR;
    if ([input isEqualToString:@"554"]) return NZD;
    if ([input isEqualToString:@"891"]) return CSD;
    if ([input isEqualToString:@"968"]) return SRD;
    if ([input isEqualToString:@"152"]) return CLP;
    if ([input isEqualToString:@"642"]) return ROL;
    if ([input isEqualToString:@"344"]) return HKD;
    if ([input isEqualToString:@"948"]) return CHW;
    if ([input isEqualToString:@"246"]) return FIM;
    if ([input isEqualToString:@"516"]) return NAD;
    if ([input isEqualToString:@"643"]) return RUB;
    if ([input isEqualToString:@"270"]) return GMD;
    if ([input isEqualToString:@"705"]) return SIT;
    if ([input isEqualToString:@"626"]) return TPE;
    if ([input isEqualToString:@"999"]) return XXX;
    if ([input isEqualToString:@"704"]) return VND;
    if ([input isEqualToString:@"418"]) return LAK;
    if ([input isEqualToString:@"931"]) return CUC;
    if ([input isEqualToString:@"946"]) return RON;
    if ([input isEqualToString:@"480"]) return MUR;
    if ([input isEqualToString:@"959"]) return XAU;
    if ([input isEqualToString:@"740"]) return SRG;
    if ([input isEqualToString:@"986"]) return BRL;
    if ([input isEqualToString:@"484"]) return MXN;
    if ([input isEqualToString:@"678"]) return STD;
    if ([input isEqualToString:@"795"]) return TMM;
    if ([input isEqualToString:@"533"]) return AWG;
    if ([input isEqualToString:@"462"]) return MVR;
    if ([input isEqualToString:@"590"]) return PAB;
    if ([input isEqualToString:@"972"]) return TJS;
    if ([input isEqualToString:@"324"]) return GNF;
    if ([input isEqualToString:@"969"]) return MGA;
    if ([input isEqualToString:@"960"]) return XDR;
    if ([input isEqualToString:@"112"]) return BYB;
    if ([input isEqualToString:@"170"]) return COP;
    if ([input isEqualToString:@"230"]) return ETB;
    if ([input isEqualToString:@"372"]) return IEP;
    if ([input isEqualToString:@"360"]) return IDR;
    if ([input isEqualToString:@"710"]) return ZAR;
    if ([input isEqualToString:@"222"]) return SVC;
    if ([input isEqualToString:@"132"]) return CVE;
    if ([input isEqualToString:@"780"]) return TTD;
    if ([input isEqualToString:@"292"]) return GIP;
    if ([input isEqualToString:@"600"]) return PYG;
    if ([input isEqualToString:@"943"]) return MZN;
    if ([input isEqualToString:@"238"]) return FKP;
    if ([input isEqualToString:@"398"]) return KZT;
    if ([input isEqualToString:@"800"]) return UGX;
    if ([input isEqualToString:@"840"]) return USD;
    if ([input isEqualToString:@"032"]) return ARS;
    if ([input isEqualToString:@"936"]) return GHS;
    if ([input isEqualToString:@"646"]) return RWF;
    if ([input isEqualToString:@"214"]) return DOP;
    if ([input isEqualToString:@"984"]) return BOV;
    if ([input isEqualToString:@"250"]) return FRF;
    if ([input isEqualToString:@"422"]) return LBP;
    if ([input isEqualToString:@"064"]) return BTN;
    if ([input isEqualToString:@"084"]) return BZD;
    if ([input isEqualToString:@"458"]) return MYR;
    if ([input isEqualToString:@"886"]) return YER;
    if ([input isEqualToString:@"388"]) return JMD;
    if ([input isEqualToString:@"450"]) return MGF;
    if ([input isEqualToString:@"776"]) return TOP;
    if ([input isEqualToString:@"706"]) return SOS;
    if ([input isEqualToString:@"970"]) return COU;
    if ([input isEqualToString:@"934"]) return TMT;
    if ([input isEqualToString:@"498"]) return MDL;
    if ([input isEqualToString:@"964"]) return XPD;
    if ([input isEqualToString:@"792"]) return TRL;
    if ([input isEqualToString:@"040"]) return ATS;
    if ([input isEqualToString:@"952"]) return XOF;
    if ([input isEqualToString:@"901"]) return TWD;
    if ([input isEqualToString:@"052"]) return BBD;
    if ([input isEqualToString:@"979"]) return MXV;
    if ([input isEqualToString:@"004"]) return AFA;
    if ([input isEqualToString:@"124"]) return CAD;
    if ([input isEqualToString:@"156"]) return CNY;
    if ([input isEqualToString:@"400"]) return JOD;
    if ([input isEqualToString:@"953"]) return XPF;
    if ([input isEqualToString:@"368"]) return IQD;
    if ([input isEqualToString:@"945"]) return AYM;
    if ([input isEqualToString:@"340"]) return HNL;
    if ([input isEqualToString:@"784"]) return AED;
    if ([input isEqualToString:@"232"]) return ERN;
    if ([input isEqualToString:@"404"]) return KES;
    if ([input isEqualToString:@"728"]) return SSP;
    if ([input isEqualToString:@"174"]) return KMF;
    if ([input isEqualToString:@"012"]) return DZD;
    if ([input isEqualToString:@"807"]) return MKD;
    if ([input isEqualToString:@"031"]) return AZM;
    if ([input isEqualToString:@"192"]) return CUP;
    if ([input isEqualToString:@"072"]) return BWP;
    if ([input isEqualToString:@"944"]) return AZN;
    if ([input isEqualToString:@"090"]) return SBD;
    if ([input isEqualToString:@"965"]) return XUA;
    if ([input isEqualToString:@"933"]) return BYN;
    if ([input isEqualToString:@"417"]) return KGS;
    if ([input isEqualToString:@"997"]) return USN;
    if ([input isEqualToString:@"724"]) return ESP;
    if ([input isEqualToString:@"116"]) return KHR;
    if ([input isEqualToString:@"894"]) return ZMK;
    if ([input isEqualToString:@"056"]) return BEF;
    if ([input isEqualToString:@"332"]) return HTG;
    if ([input isEqualToString:@"203"]) return CZK;
    if ([input isEqualToString:@"977"]) return BAM;
    return NSNotFound;
}

+ (int) getDecimalPointOfAlphaCode:(NSString *)input
{
    NSDictionary* dictDecimalPoint = @{
                                       @"AFN":@"2",
                                       @"EUR":@"2",
                                       @"ALL":@"2",
                                       @"DZD":@"2",
                                       @"USD":@"2",
                                       @"EUR":@"2",
                                       @"AOA":@"2",
                                       @"XCD":@"2",
                                       @"XCD":@"2",
                                       @"ARS":@"2",
                                       @"AMD":@"2",
                                       @"AWG":@"2",
                                       @"AUD":@"2",
                                       @"EUR":@"2",
                                       @"AZN":@"2",
                                       @"BSD":@"2",
                                       @"BHD":@"3",
                                       @"BDT":@"2",
                                       @"BBD":@"2",
                                       @"BYN":@"2",
                                       @"EUR":@"2",
                                       @"BZD":@"2",
                                       @"XOF":@"0",
                                       @"BMD":@"2",
                                       @"INR":@"2",
                                       @"BTN":@"2",
                                       @"BOB":@"2",
                                       @"BOV":@"2",
                                       @"USD":@"2",
                                       @"BAM":@"2",
                                       @"BWP":@"2",
                                       @"NOK":@"2",
                                       @"BRL":@"2",
                                       @"USD":@"2",
                                       @"BND":@"2",
                                       @"BGN":@"2",
                                       @"XOF":@"0",
                                       @"BIF":@"0",
                                       @"CVE":@"2",
                                       @"KHR":@"2",
                                       @"XAF":@"0",
                                       @"CAD":@"2",
                                       @"KYD":@"2",
                                       @"XAF":@"0",
                                       @"XAF":@"0",
                                       @"CLP":@"0",
                                       @"CLF":@"4",
                                       @"CNY":@"2",
                                       @"AUD":@"2",
                                       @"AUD":@"2",
                                       @"COP":@"2",
                                       @"COU":@"2",
                                       @"KMF":@"0",
                                       @"CDF":@"2",
                                       @"XAF":@"0",
                                       @"NZD":@"2",
                                       @"CRC":@"2",
                                       @"XOF":@"0",
                                       @"HRK":@"2",
                                       @"CUP":@"2",
                                       @"CUC":@"2",
                                       @"ANG":@"2",
                                       @"EUR":@"2",
                                       @"CZK":@"2",
                                       @"DKK":@"2",
                                       @"DJF":@"0",
                                       @"XCD":@"2",
                                       @"DOP":@"2",
                                       @"USD":@"2",
                                       @"EGP":@"2",
                                       @"SVC":@"2",
                                       @"USD":@"2",
                                       @"XAF":@"0",
                                       @"ERN":@"2",
                                       @"EUR":@"2",
                                       @"ETB":@"2",
                                       @"EUR":@"2",
                                       @"FKP":@"2",
                                       @"DKK":@"2",
                                       @"FJD":@"2",
                                       @"EUR":@"2",
                                       @"EUR":@"2",
                                       @"EUR":@"2",
                                       @"XPF":@"0",
                                       @"EUR":@"2",
                                       @"XAF":@"0",
                                       @"GMD":@"2",
                                       @"GEL":@"2",
                                       @"EUR":@"2",
                                       @"GHS":@"2",
                                       @"GIP":@"2",
                                       @"EUR":@"2",
                                       @"DKK":@"2",
                                       @"XCD":@"2",
                                       @"EUR":@"2",
                                       @"USD":@"2",
                                       @"GTQ":@"2",
                                       @"GBP":@"2",
                                       @"GNF":@"0",
                                       @"XOF":@"0",
                                       @"GYD":@"2",
                                       @"HTG":@"2",
                                       @"USD":@"2",
                                       @"AUD":@"2",
                                       @"EUR":@"2",
                                       @"HNL":@"2",
                                       @"HKD":@"2",
                                       @"HUF":@"2",
                                       @"ISK":@"0",
                                       @"INR":@"2",
                                       @"IDR":@"2",
                                       @"IRR":@"2",
                                       @"IQD":@"3",
                                       @"EUR":@"2",
                                       @"GBP":@"2",
                                       @"ILS":@"2",
                                       @"EUR":@"2",
                                       @"JMD":@"2",
                                       @"JPY":@"0",
                                       @"GBP":@"2",
                                       @"JOD":@"3",
                                       @"KZT":@"2",
                                       @"KES":@"2",
                                       @"AUD":@"2",
                                       @"KPW":@"2",
                                       @"KRW":@"0",
                                       @"KWD":@"3",
                                       @"KGS":@"2",
                                       @"LAK":@"2",
                                       @"EUR":@"2",
                                       @"LBP":@"2",
                                       @"LSL":@"2",
                                       @"ZAR":@"2",
                                       @"LRD":@"2",
                                       @"LYD":@"3",
                                       @"CHF":@"2",
                                       @"EUR":@"2",
                                       @"EUR":@"2",
                                       @"MOP":@"2",
                                       @"MKD":@"2",
                                       @"MGA":@"2",
                                       @"MWK":@"2",
                                       @"MYR":@"2",
                                       @"MVR":@"2",
                                       @"XOF":@"0",
                                       @"EUR":@"2",
                                       @"USD":@"2",
                                       @"EUR":@"2",
                                       @"MRO":@"2",
                                       @"MUR":@"2",
                                       @"EUR":@"2",
                                       @"MXN":@"2",
                                       @"MXV":@"2",
                                       @"USD":@"2",
                                       @"MDL":@"2",
                                       @"EUR":@"2",
                                       @"MNT":@"2",
                                       @"EUR":@"2",
                                       @"XCD":@"2",
                                       @"MAD":@"2",
                                       @"MZN":@"2",
                                       @"MMK":@"2",
                                       @"NAD":@"2",
                                       @"ZAR":@"2",
                                       @"AUD":@"2",
                                       @"NPR":@"2",
                                       @"EUR":@"2",
                                       @"XPF":@"0",
                                       @"NZD":@"2",
                                       @"NIO":@"2",
                                       @"XOF":@"0",
                                       @"NGN":@"2",
                                       @"NZD":@"2",
                                       @"AUD":@"2",
                                       @"USD":@"2",
                                       @"NOK":@"2",
                                       @"OMR":@"3",
                                       @"PKR":@"2",
                                       @"USD":@"2",
                                       @"PAB":@"2",
                                       @"USD":@"2",
                                       @"PGK":@"2",
                                       @"PYG":@"0",
                                       @"PEN":@"2",
                                       @"PHP":@"2",
                                       @"NZD":@"2",
                                       @"PLN":@"2",
                                       @"EUR":@"2",
                                       @"USD":@"2",
                                       @"QAR":@"2",
                                       @"EUR":@"2",
                                       @"RON":@"2",
                                       @"RUB":@"2",
                                       @"RWF":@"0",
                                       @"EUR":@"2",
                                       @"SHP":@"2",
                                       @"XCD":@"2",
                                       @"XCD":@"2",
                                       @"EUR":@"2",
                                       @"EUR":@"2",
                                       @"XCD":@"2",
                                       @"WST":@"2",
                                       @"EUR":@"2",
                                       @"STD":@"2",
                                       @"SAR":@"2",
                                       @"XOF":@"0",
                                       @"RSD":@"2",
                                       @"SCR":@"2",
                                       @"SLL":@"2",
                                       @"SGD":@"2",
                                       @"ANG":@"2",
                                       @"EUR":@"2",
                                       @"EUR":@"2",
                                       @"SBD":@"2",
                                       @"SOS":@"2",
                                       @"ZAR":@"2",
                                       @"SSP":@"2",
                                       @"EUR":@"2",
                                       @"LKR":@"2",
                                       @"SDG":@"2",
                                       @"SRD":@"2",
                                       @"NOK":@"2",
                                       @"SZL":@"2",
                                       @"SEK":@"2",
                                       @"CHF":@"2",
                                       @"CHE":@"2",
                                       @"CHW":@"2",
                                       @"SYP":@"2",
                                       @"TWD":@"2",
                                       @"TJS":@"2",
                                       @"TZS":@"2",
                                       @"THB":@"2",
                                       @"USD":@"2",
                                       @"XOF":@"0",
                                       @"NZD":@"2",
                                       @"TOP":@"2",
                                       @"TTD":@"2",
                                       @"TND":@"3",
                                       @"TRY":@"2",
                                       @"TMT":@"2",
                                       @"USD":@"2",
                                       @"AUD":@"2",
                                       @"UGX":@"0",
                                       @"UAH":@"2",
                                       @"AED":@"2",
                                       @"GBP":@"2",
                                       @"USD":@"2",
                                       @"USD":@"2",
                                       @"USN":@"2",
                                       @"UYU":@"2",
                                       @"UYI":@"0",
                                       @"UZS":@"2",
                                       @"VUV":@"0",
                                       @"VEF":@"2",
                                       @"VND":@"0",
                                       @"USD":@"2",
                                       @"USD":@"2",
                                       @"XPF":@"0",
                                       @"MAD":@"2",
                                       @"YER":@"2",
                                       @"ZMW":@"2",
                                       @"ZWL":@"2"
                                       
                                       };
    int point = [[dictDecimalPoint objectForKey:@"ZWL"] intValue];
    return point;
}

@end
