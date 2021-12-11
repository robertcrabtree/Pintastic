# Pintastic

Pintastic is a Swift framework for iOS that enables developers to layout views easily and quickly.

## Why Use Pintastic

* Method chaining makes Pintastic fun and easy to use. Save a lot of typing and start getting stuff done!
* It's lightweight and low risk.

```swift
let container = UIView()
container.translatesAutoresizingMaskIntoConstraints = false
container.backgroundColor = .orange

let nested = UIView()
nested.translatesAutoresizingMaskIntoConstraints = false
nested.backgroundColor = .green

view.addSubview(container)
container.addSubview(nested)

container
    .pin(to: view.safeAreaLayoutGuide)
    .pinEdges()
    .activate()

nested
    .pin()
    .pinWidthEqualToHeight()
    .activate()

nested
    .pin(to: container)
    .pinCenters()
    .pinWidths(multiplier: 0.5)
    .activate()
```

## Key Features

* Easy to use wrapper around autolayout
* Supports most common layout scenarios
* Integrates seamlessly with `NSLayoutConstraint` and `NSLayoutAnchor` when more fine-tuning is required
* Method chaining means fewer constants and variables
* Supports `UIView` and `UILayoutGuide`
* Lightweight

## Getting Started

More on this soon.

## Basic Idea

There are two types of pins. A `SinglePin` and a `DoublePin`. Use the `SinglePin` for sizing a `UIView` when the size is independent of other views. Use the `DoublePin` when positioning or sizing a `UIView` in relation to another `UIView`.

## Examples

#### Edges

Here's how you would constrain the edges of a view.

```Swift
subview
    .pin(to: container)
    .pinEdges()
    .activate()

subview
    .pin(to: container)
    .pinLeadingEdges(constant: 10)
    .pinTrailingEdges(constant: -10)
    .activate()
```

#### Sizing

Here's how you would do some basic sizing.

```Swift
subview
    .pin()
    .pinWidth(constant: 100.0) // constant width
    .pinHeight(constant: 100.0) // constant height
    .activate()

subview
    .pin(to: container)
    .pinWidths(multiplier: 0.5) // width relative to another
    .pinHeights(multiplier: 0.5) // height relative to another
    .activate()
```

#### Positioning

Here's how you would position a view relative to another.

```Swift
leftView
    .pin(to: centerView)
    .pinToLeft(constant: -20)
    .activate()

topView
    .pin(to: centerView)
    .pinAbove(constant: -20)
    .activate()
```

#### Centering

Here's how views are centered.

```Swift
centerView
    .pin(to: container)
    .pinCenters()
    .activate()

centerView
    .pin(to: container)
    .pinHorizontalCenters()
    .pinVerticalCenters()
    .activate()
```

#### Custom Constraints

If you need a finer granularity of control you can add custom constraints.

```Swift
let constraintID = "left.width.equal.to.right.height"
leftView
    .pin(to: rightView)
    .addConstraint(withIdentifier: constraintID) {
        leftView.widthAnchor.constraint(equalTo: rightView.heightAnchor)
    }
    .constraint(withIdentifier: constraintID, handler: { constraint in
        constraint?.priority =  .defaultLow
    })
    .activate()
```

#### Modifications

Sometimes you need to alter constraint values beyond the time of initialization.

```Swift
let pin = subview
    .pin()
    .pinWidth(constant: 100)
    .pinHeight(constant: 100)
    .activate()

// ...

if let widthConstraint = pin.constraint(ofType: .width) {
    widthConstraint.constant *= 2.0
}

if let heightConstraint = pin.constraint(ofType: .height) {
    heightConstraint.constant *= 2.0
}
```

## Contributing

More on this soon.

## License

Pintastic is published under the Apache 2.0 license.
