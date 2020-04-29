![SAINI UTILS](https://user-images.githubusercontent.com/39442131/68613786-8c888300-04e5-11ea-8670-dfaeee7290b0.png)

[![CI Status](https://img.shields.io/travis/rohitsaini91/SainiUtils.svg?style=flat)](https://travis-ci.org/rohitsaini91/SainiUtils)
[![Version](https://img.shields.io/cocoapods/v/SainiUtils.svg?style=flat)](https://cocoapods.org/pods/SainiUtils)
[![License](https://img.shields.io/cocoapods/l/SainiUtils.svg?style=flat)](https://cocoapods.org/pods/SainiUtils)
[![Platform](https://img.shields.io/cocoapods/p/SainiUtils.svg?style=flat)](https://cocoapods.org/pods/SainiUtils)

# Introduction

SainiUtils is used to extend the basic functionality of UIKit elements like UIView,UIButton,UITextfield etc.

# Purpose

SainiUtils basic purpose to reduce your development time by extened the basic functionality of UIKit elements.


# Installation

SainiUtils is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SainiUtils'
```

# How to Use
```swift
let demoView = UIView()
demoView.sainiFeatureName()//Just use the below given function names.

//example
let demoLabel = UILabel()
demoLabel.sainiAddTapGesture{
print("I can now click on UILabel")
demoLabel.sainiRotate()//Oh cool its rotating 
}

```

# Features

| UIView        | 
| ------------- |
| 1.)sainiCircle   | 
| 2.)sainiBlur     | 
| 3.)sainiGradientColor |
| 4.)sainiCornerRadius |
| 5.)sainiRoundCorners | 
| 6.)sainiShadow | 
| 7.)sainiShadowWithCornerRadius |
| 8.)sainiShadowWithGradientAndCornerRadius | 
| 9.)sainiGrowAndShrink | 
| 10.)sainiRotate | 
| 11.)sainiStopRotating | 
| 12.)sainiTapToChangeColor | 
| 13.)sainiScreenshot | 
| 14.)sainiAddBorderWithColor | 
| 15.)sainiDrawDashedBorderAroundView | 
| 16.)sainiFadeIn | 
| 17.)sainiFadeOut | 
| 18.)sainiFadeOutInfinite | 
| 19.)sainiFadeInInfinite | 
| 20.)sainiShowLoader | 
| 21.)sainiRemoveLoader | 
| 22.)sainiRotateByAngle | 
| 23.)sainiDashedLine | 
| 24.)sainiAddTapGesture | 
| 25.)sainiPulsate | 
| 26.)sainiFlash | 
| 27.)sainiShake | 
| 28.)sainiShowToast |  

| UITextField   | 
| ------------- |
| 29.)sainiSetLeftPadding |
| 30.)sainiSetRightPadding |
| 31.)sainiSetLeftIcon |
| 32.)sainiSetRightIcon |

| UITableView   | 
| ------------- |
| 33.)sainiSetEmptyMessage |
| 34.)restore |

| Date   | 
| ------------- |
| 35.)sianiFirstDayOfWeek |
| 36.)sainiAddWeeks |
| 37.)sainiWeeksAgo |
| 38.)sainiAddDays |
| 39.)sainiDaysAgo |
| 40.)sainiAddHours |
| 41.)sainiHoursAgo |
| 42.)sainiAddMinutes |
| 43.)sainiMinutesAgo |
| 44.)sainiStartOfDay |
| 45.)sainiEndOfDay |
| 46.)sainiZeroBasedDayOfWeek |
| 47.)sainiHoursFrom |
| 48.)sainiDaysBetween |
| 49.)sainiPercentageOfDay |
| 50.)sainiNumberOfWeeksInMonth |
| 51.)sainiFormattedDateString |



# Some handy Functions
## sainiColorFromHex
```swift
let demoLbl = UILabel()
demoLbl.textColor = sainiColorFromHex(hex: "#687f9")
```
## sainiCompressImage
```swift
 //Image Compression to 10th of original size
 let image = sainiCompressImage(image: UIImage(named: "someImage"))
```

## sainiSignatureView
```swift

 //Assign sainiSignatureView to any UIView class and it will behave as an signatureView 
 
```

## sainiCardView
```swift

 //Assign sainiCardView to any UIView class and it will behave as an CardView 
 
```
## sainiTimesAgo
```swift

 let timeAgoStr = sainiTimesAgo(78789877387)
      print(timeAgoStr)
      //2 Min ago
 
```



# Author

rohitsaini91, rohitsainier@gmail.com

# License

SainiUtils is available under the MIT license. See the LICENSE file for more info.
