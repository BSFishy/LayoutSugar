# LayoutSugar

[![Version](https://img.shields.io/cocoapods/v/LayoutSugar.svg?style=flat)](https://cocoapods.org/pods/LayoutSugar)
[![License](https://img.shields.io/cocoapods/l/LayoutSugar.svg?style=flat)](https://cocoapods.org/pods/LayoutSugar)
[![Platform](https://img.shields.io/cocoapods/p/LayoutSugar.svg?style=flat)](https://cocoapods.org/pods/LayoutSugar)

LayoutSugar is the layout framework stripped from the [Material](https://github.com/CosmicMind/Material) project. There are some changes to the actual code, and most of the documentation has been rewritten, but for the most part, this works like it does in Material. The reason it got put into a separate project is because I wanted to take advantage of the nice layout capabilities, but lost my use for the other components added by Material.

## Installation
LayoutSugar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LayoutSugar'
```

## Example
To use LayoutSugar, your code might look something like so:
```swift
view.layout(subview)
    .top(20)
    .leading(10)
    .trailing(10)
    .bottom(5)
```

You can also set thing like multipliers and priorities:
```swift
view.layout(subview)
    .top(20).multiplier(2).priority(500)
```

Views can also be laid out based on specific anchors and using specific relationships:
```swift
view.layout(subview)
    .top(otherView.bottom, 20, >=)
```

All of this code should be located when the view is first loaded, which would be in the view controller's `viewDidLoad` method.

## Information

### Author
Matt Provost, mprovost@webcreek.com

### License
LayoutSugar is available under the MIT license. See the LICENSE file for more info.

### Credits
Full credit goes to [CosmicMind](https://github.com/CosmicMind) for making [Material](https://github.com/CosmicMind/Material). Most of the code in this project is derived from that repository.
