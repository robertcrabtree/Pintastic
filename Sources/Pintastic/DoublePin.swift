//
//  File.swift
//  
//
//  Created by Rob on 12/11/21.
//

import Foundation
import UIKit

public final class DoublePin: Pinning {

    public var constraints: [String : NSLayoutConstraint] = [:]

    /// Initialize a `Pin` with the item(s) to apply constraints to
    /// - Parameter item: The `Pinnable` item you wish to apply constraints to
    public init(primaryItem: Pinnable, secondaryItem: Pinnable) {
        self.primaryItem = primaryItem
        self.secondaryItem = secondaryItem
    }

    /// Pin the edges of the primary item to the secondary item
    /// - Returns: A reference to the `Pin`
    public func edges() -> DoublePin {
        leadingEdges().trailingEdges().topEdges().bottomEdges()
    }

    /// Pin the leading edges of the primary item to the secondary item
    /// - Parameter constant: A positive value will inset the leading edge by this value.
    /// - Returns: A reference to the `Pin`
    public func leadingEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.leadingEdges) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: constant)
        }
    }

    /// Pin the trailing edges of the primary item to the secondary item
    /// - Parameter constant: A negative value will inset the trailing edge by this value.
    /// - Returns: A reference to the `Pin`
    public func trailingEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.trailingEdges) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: constant)
        }
    }

    /// Pin the top edge of the primary item to the top edge of the secondary item.
    /// - Parameter constant: A positive value will inset the top edge by this value.
    /// - Returns: A reference to the `Pin`
    public func topEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.topEdges) { other in
            primaryItem.topAnchor.constraint(equalTo: other.topAnchor, constant: constant)
        }
    }

    /// Pin the bottom edge of the primary item to the bottom edge of the secondary item.
    /// - Parameter constant: A negative value will inset the bottom edge by this value.
    /// - Returns: A reference to the `Pin`
    public func bottomEdges(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.bottomEdges) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: constant)
        }
    }

    /// Pin the bottom of the primary item to the top of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func above(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.above) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.topAnchor, constant: constant)
        }
    }

    /// Pin the top of the primary item to the bottom of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func below(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.below) { other in
            primaryItem.topAnchor.constraint(equalTo: other.bottomAnchor, constant: constant)
        }
    }

    /// Pin the trailing edge of the primary item to the leading edge of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func before(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.before) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.leadingAnchor, constant: constant)
        }
    }

    /// Pin the leading edge of the primary item to the trailing edge of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func after(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.after) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.trailingAnchor, constant: constant)
        }
    }

    /// Pin the horizontal and vertical centers of the primary to the secondary item
    /// - Returns: A reference to the `Pin`
    public func centers() -> DoublePin {
        horizontalCenters().verticalCenters()
    }

    /// Pin the horizontal centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func horizontalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.horizontalCenters) { other in
            NSLayoutConstraint(
                item: primaryItem,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: other,
                attribute: .centerX,
                multiplier: multiplier,
                constant: 0.0
            )
        }
    }

    /// Pin the vertical centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func verticalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.verticalCenters) { other in
            NSLayoutConstraint(
                item: primaryItem,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: other,
                attribute: .centerY,
                multiplier: multiplier,
                constant: 0.0
            )
        }
    }

    /// Constrain the primary item width to the width of the secondary item
    /// - Parameter multiplier: The width multiplier
    /// - Returns: A reference to the `Pin`
    public func equalWidths(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.equalWidths) { other in
            primaryItem.widthAnchor.constraint(equalTo: other.widthAnchor, multiplier: multiplier)
        }
    }

    /// Constrain the primary item height to the width of the secondary item
    /// - Parameter multiplier: The height multiplier
    /// - Returns: A reference to the `Pin`
    public func equalHeights(multiplier: CGFloat = 1.0) -> DoublePin {
        addRelationalConstraint(.equalHeights) { other in
            primaryItem.heightAnchor.constraint(equalTo: other.heightAnchor, multiplier: multiplier)
        }
    }

    /// Pin the leading edge of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func leadingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.leadingToHorizontalCenter) { other in
            primaryItem.leadingAnchor.constraint(equalTo: other.centerXAnchor, constant: constant)
        }
    }

    /// Pin the trailing edge of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func trailingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.trailingToHorizontalCenter) { other in
            primaryItem.trailingAnchor.constraint(equalTo: other.centerXAnchor, constant: constant)
        }
    }

    /// Pin the top of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func topEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.topToVerticalCenter) { other in
            primaryItem.topAnchor.constraint(equalTo: other.centerYAnchor, constant: constant)
        }
    }

    /// Pin the bottom of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func bottomEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addRelationalConstraint(.bottomToVerticalCenter) { other in
            primaryItem.bottomAnchor.constraint(equalTo: other.centerYAnchor, constant: constant)
        }
    }

    private func addRelationalConstraint(
        _ key: Constraint,
        block: (Pinnable) -> NSLayoutConstraint
    ) -> DoublePin {
        addConstraint(key, constraint: block(secondaryItem))
    }

    private func addConstraint(_ type: Constraint, constraint: NSLayoutConstraint) -> Self {
        addConstraint(withIdentifier: type.rawValue, constraint: constraint)
    }

    private let primaryItem: Pinnable
    private let secondaryItem: Pinnable
}
