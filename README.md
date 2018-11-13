# TOBadgeView

<p align="center">
<img src="https://raw.githubusercontent.com/TimOliver/TOBadgeView/master/screenshot.jpg" width="500" style="margin:0 auto" />
</p>

[![CocoaPods](https://img.shields.io/cocoapods/dt/TOBadgeView.svg?maxAge=3600)](https://cocoapods.org/pods/TOWebContentViewController)
[![Version](https://img.shields.io/cocoapods/v/TOBadgeView.svg?style=flat)](http://cocoadocs.org/docsets/TOCropViewController)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/TimOliver/TOBadgeView/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TOBadgeView.svg?style=flat)](http://cocoadocs.org/docsets/TOWebContentViewController)
[![PayPal](https://img.shields.io/badge/paypal-donate-blue.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M4RKULAVKV7K8)

`TOBadgeView` is a very basic `UIView` subclass to provide a GPU-efficient recreation of the class iOS badge icon.

It is wholly dynamic, where all sizing, fonts and colors can be changed, and it can intelligently resize itself to fit a particular text value.

## Features

* Recreates the standard iOS badge icon and style.
* Uses Core Animation and Metal to provide VERY efficient layer compositing.

## System Requirements
iOS 9.0 and above.

## Installation

**As a CocoaPods Dependency**

Add the following to your Podfile:
```
pod 'TOBadgeView'
```

**Manual Installation**

Copy the folder `TOBadgeView` to your Xcode project.

`TOBadgeView` is an Objective-C project, but it has been written to work properly in Swift as well. If you are using it in a Swift project, don't forget to include it in your Objective-C bridging header.

## Examples

`TOBadgeView` is very bare-bones and behaves in what should be a very intuitive manner.

### Hello World Example

```swift
let badgeView = BadgeView() // Create the badge view
badgeView.text = "1"
badgeView.sizeToFit() // Change the badge view size to fit
```


## Credits
`TOBadgeView` was originally created by [Tim Oliver](http://twitter.com/TimOliverAU) as a component for [iComics](http://icomics.co), a comic reader app for iOS.

iOS Device mockups used in the screenshot created by [Pixeden](http://www.pixeden.com).

## License
TOBadgeView is licensed under the MIT License, please see the [LICENSE](LICENSE) file. ![analytics](https://ga-beacon.appspot.com/UA-5643664-16/TOBadgeView/README.md?pixel)
