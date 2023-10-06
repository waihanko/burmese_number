# Burmese Number

Burmese Number is a Dart utility for converting numbers to Burmese text representations.


## Usage

### Static Function Call

```dart
String result = BurmeseNumHelper.convertToLongNumber(number: "5980000.55", numberFormat: NumberFormat.plainText);
//ငါးဆယ့်ကိုးသိန်းရှစ်သောင်းဒဿမငါးငါး

String result = BurmeseNumHelper.convertToLongNumber(number: "5980000.55", numberFormat: NumberFormat.numberInText);
//၅ဆယ့်၉သိန်း၈သောင်းဒဿမ၅၅

String result =  BurmeseNumHelper.convertToSimpleNumber(number:  "5980000.55");
//၅၉၈၀၀၀၀.၅၅
```

### Extension Function Call

```dart
String result = "5980000.55".convertToLongNumber(numberFormat: NumberFormat.plainText);
//ငါးဆယ့်ကိုးသိန်းရှစ်သောင်းဒဿမငါးငါး

String result = "5980000.55".convertToLongNumber(numberFormat: NumberFormat.numberInText);
//၅ဆယ့်၉သိန်း၈သောင်းဒဿမ၅၅

String result = "5980000.55".convertToSimpleNumber();
//၅၉၈၀၀၀၀.၅၅
```


