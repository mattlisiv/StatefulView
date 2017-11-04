# StatefulView
An Overlay UIView For Managing UICollectionViews

[![Build Status](https://travis-ci.org/mattlisiv/StatefulView.svg?branch=master)](https://travis-ci.org/mattlisiv/StatefulView)
![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20tvOS-lightgrey.svg)


This small library was created when utilizing the framework [IGListKit](https://github.com/Instagram/IGListKit) for displaying collections.
When adhering to the IGList protocol, there exists a method with the signature:

```swift
func emptyView(for listAdapter: ListAdapter) -> UIView?
```
This is called when no diffable items exists for the UICollectionView. 

When generically loading data, there exists default states:

1. Loading
2. Empty (No Data)
3. Error

This library attempts to simplify the transitions among thesese various state by creating a simple UIView that can handle
the generic states. It was influenced by [StatefulViewController](https://github.com/aschuch/StatefulViewController), but I found a single UIView was better for my particular use case than a view controller.

## Getting Started

Install the library via [CocoaPods](https://cocoapods.org/) by referencing in your Podfile.
```pod
  pod 'StatefulView'
```
## Simple Example

Create a StatefulView Object:
```swift
var statefulView: StatefulView = StatefulView()
```

### Set Views you would like to display for different states.

#### By class:
```swift
self.statefulView.setAvailableViews(loadingView: LoadingView())
```

#### by XIB name:
```swift
self.statefulView.setAvailableViewsByName(errorView: "ErrorView", emptyView: "EmptyView")
```

### Change states when desired:
```swift
self.statefulView.setState(state: .loading)
```

### Pass in a completion block to be executed when the view is tapped:
```
self.statefulView.setHandlers(loadingView: { print("Loading View Clicked")})
```

## Example 
See the StatefulViewExample project for a brief demo.

## Additional
Feel free to make suggestions or provide feedback regarding the library. Thanks.
