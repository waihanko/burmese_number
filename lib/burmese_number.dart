library burmese_number;

class BurmeseNumHelper {


  static final List<String> _burmeseNumberInText = [
    "",
    "ဆယ်",
    "ရာ",
    "ထောင်",
    "သောင်း",
    "သိန်း",
    "သန်း",
    "ကုဋေ",
  ];


  static final Map<String, String> _numberToBurmeseNumberMapper = {
    "0": "၀",
    "1": "၁",
    "2": "၂",
    "3": "၃",
    "4": "၄",
    "5": "၅",
    "6": "၆",
    "7": "၇",
    "8": "၈",
    "9": "၉"
  };

   static String convertToSimpleNumber({
    required String number,
    bool isCommaSeparated = false,
  }) {
    if (isCommaSeparated) {
      RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      String mathFunc(Match match) => '${match[1]},';
      number = number.replaceAllMapped(reg, mathFunc);
    }

    return _numberToBurmeseNumberMapper.entries
        .fold(number, (prev, e) => prev.toString().replaceAll(e.key, e.value));
  }


  //Over 8 && NORMAL => Change To THEIN
  //Over 10 && THEIN => Change To THAN
  //Over 12 && THAN => Change To GADAY
  //Over 14 is Invalid

  static String convertToLongNumber({
    required String number,
    NumberFormat numberFormat = NumberFormat.plainText,
  }) {
    String result = "";
    if(!RegExp(r'^(?![^0-9.]+$)(\d+(\.\d+)?|\.\d+)$').hasMatch(number)) return "INVALID";
    DisplayFormat displayFormat  = DisplayFormat.defaultType;

    List<String> originalNumber = number.split(".");
    if (originalNumber[0].length > 14) {
      return "INVALID";
    } else if (originalNumber[0].length > 12 ) {
      displayFormat = DisplayFormat.d8;
    } else if (originalNumber[0].length > 10) {
      displayFormat = DisplayFormat.d7;
    } else if (originalNumber[0].length > 6) {
      displayFormat = DisplayFormat.d6;
    }

    result += _getFullNumber(
        originalNumber[0].substring(
            0, originalNumber[0].length - displayFormat.getPartition.index),
        numberFormat,
        originalNumber[0].length);

    if (originalNumber[0]
        .substring(0, originalNumber[0].length - displayFormat.getPartition.index)
        .endsWith("0")) {
      result = displayFormat.getPartition.name + result;
    } else {
      result = result + displayFormat.getPartition.name;
    }

    result += _getFullNumber(
        originalNumber[0].substring(
            originalNumber[0].length - displayFormat.getPartition.index,
            originalNumber[0].length),
        numberFormat,
        originalNumber[0].length);

    if (originalNumber.length > 1) {
      result += ".".getMMDescription;

      originalNumber[1].split("").asMap().forEach((index, element) {
        result += numberFormat == NumberFormat.plainText
            ? element.trim().getMMDescription
            : element.trim().getMMNumber;
      });
    }

    return result;
  }

  static String _getFullNumber(
      String wholeNumber,
      NumberFormat mmNumberType,
      int digitCount,
      ) {
    String result = "";
    List<String> numType2 = List.of(_burmeseNumberInText);

    if (digitCount >= 2 && !wholeNumber.endsWith("0")) {
      numType2[1] = "ဆယ့်";
    }
    if (digitCount >= 3 && !wholeNumber.endsWith("00")) {
      numType2[2] = "ရာ့";
    }
    if (digitCount >= 4 && !wholeNumber.endsWith("000")) {
      numType2[3] = "ထောင့်";
    }

    wholeNumber.split("").reversed.toList().asMap().forEach((index, element) {
      if (element == "0") return;
      String prefix = mmNumberType == NumberFormat.plainText
          ? element.trim().getMMDescription
          : element.trim().getMMNumber;
      String postFix = numType2[index];
      result = prefix + postFix + result;
    });
    return result;
  }
}

extension ConvertToSimpleNumberExtension on String {
  String convertToSimpleNumber({bool isCommaSeparated = false}) {
    return BurmeseNumHelper.convertToSimpleNumber(number: this, isCommaSeparated: isCommaSeparated);
  }

  String convertToLongNumber({NumberFormat numberType = NumberFormat.plainText,}) {
    return BurmeseNumHelper.convertToLongNumber(number: this, numberFormat: numberType);
  }

}

extension ExtendedString on String {
  String get getMMDescription {
    switch (this) {
      case ".":
        return "ဒဿမ";
      case "0":
        return "သုည";
      case "1":
        return "တစ်";
      case "2":
        return "နှစ်";
      case "3":
        return "သုံး";
      case "4":
        return "လေး";
      case "5":
        return "ငါး";
      case "6":
        return "ခြောက်";
      case "7":
        return "ခုနှစ်";
      case "8":
        return "ရှစ်";
      case "9":
        return "ကိုး";
      default:
        return "";
    }
  }

  String get getMMNumber {
    switch (this) {
      case ".":
        return ".";
      case "0":
        return "၀";
      case "1":
        return "၁";
      case "2":
        return "၂";
      case "3":
        return "၃";
      case "4":
        return "၄";
      case "5":
        return "၅";
      case "6":
        return "၆";
      case "7":
        return "၇";
      case "8":
        return "၈";
      case "9":
        return "၉";
      default:
        return "";
    }
  }
}

extension DisplayFormatExt on DisplayFormat {
  DisplayFormatVo get getPartition {
    switch (this) {
      case DisplayFormat.d6:
        return DisplayFormatVo(5, "သိန်း");
      case DisplayFormat.d7:
        return DisplayFormatVo(6, "သန်း");
      case DisplayFormat.d8:
        return DisplayFormatVo(7, "ကုဋေ");
      case DisplayFormat.defaultType:
        return DisplayFormatVo(0, "");
      default:
        return DisplayFormatVo(0, "");
    }
  }
}

class DisplayFormatVo {
  final int index;
  final String name;

  DisplayFormatVo(this.index, this.name);
}

enum NumberFormat { plainText, numberInText }

//d6 - thein,
//d7 - than
//d8 - gaday
enum DisplayFormat { d6, d7, d8, defaultType }