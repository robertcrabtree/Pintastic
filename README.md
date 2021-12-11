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

More on this soon.

## Getting Started

More on this soon.

## Contributing

More on this soon.

## License

Pintastic is published under the Apache 2.0 license.
