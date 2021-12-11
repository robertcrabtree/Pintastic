//
//  DoublePin.swift
//  Pintastic
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
    public func pinEdges() -> DoublePin {
        pinLeadingEdges().pinTrailingEdges().pinTopEdges().pinBottomEdges()
    }

    /// Pin the leading edges of the primary item to the secondary item
    /// - Parameter constant: A positive value will inset the leading edge by this value.
    /// - Returns: A reference to the `Pin`
    public func pinLeadingEdges(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .leadingEdges,
            constraint: primaryItem.leadingAnchor.constraint(
                equalTo: secondaryItem.leadingAnchor,
                constant: constant
            )
        )
    }

    /// Pin the trailing edges of the primary item to the secondary item
    /// - Parameter constant: A negative value will inset the trailing edge by this value.
    /// - Returns: A reference to the `Pin`
    public func pinTrailingEdges(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .trailingEdges,
            constraint: primaryItem.trailingAnchor.constraint(
                equalTo: secondaryItem.trailingAnchor,
                constant: constant
            )
        )
    }

    /// Pin the top edge of the primary item to the top edge of the secondary item.
    /// - Parameter constant: A positive value will inset the top edge by this value.
    /// - Returns: A reference to the `Pin`
    public func pinTopEdges(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .topEdges,
            constraint: primaryItem.topAnchor.constraint(
                equalTo: secondaryItem.topAnchor,
                constant: constant
            )
        )
    }

    /// Pin the bottom edge of the primary item to the bottom edge of the secondary item.
    /// - Parameter constant: A negative value will inset the bottom edge by this value.
    /// - Returns: A reference to the `Pin`
    public func pinBottomEdges(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .bottomEdges,
            constraint: primaryItem.bottomAnchor.constraint(
                equalTo: secondaryItem.bottomAnchor,
                constant: constant
            )
        )
    }

    /// Pin the bottom of the primary item to the top of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func pinAbove(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .above,
            constraint: primaryItem.bottomAnchor.constraint(
                equalTo: secondaryItem.topAnchor,
                constant: constant
            )
        )
    }

    /// Pin the top of the primary item to the bottom of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func pinBelow(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .below,
            constraint: primaryItem.topAnchor.constraint(
                equalTo: secondaryItem.bottomAnchor,
                constant: constant
            )
        )
    }

    /// Pin the trailing edge of the primary item to the leading edge of the secondary item
    /// - Parameter constant: A negative value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func pinToLeft(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .toLeft,
            constraint: primaryItem.trailingAnchor.constraint(
                equalTo: secondaryItem.leadingAnchor,
                constant: constant
            )
        )
    }

    /// Pin the leading edge of the primary item to the trailing edge of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func pinToRight(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .toRight,
            constraint: primaryItem.leadingAnchor.constraint(
                equalTo: secondaryItem.trailingAnchor,
                constant: constant
            )
        )
    }

    /// Pin the horizontal and vertical centers of the primary to the secondary item
    /// - Returns: A reference to the `Pin`
    public func pinCenters() -> DoublePin {
        pinHorizontalCenters().pinVerticalCenters()
    }

    /// Pin the horizontal centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func pinHorizontalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
        addConstraint(
            .horizontalCenters,
            constraint: NSLayoutConstraint(
                item: primaryItem,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: secondaryItem,
                attribute: .centerX,
                multiplier: multiplier,
                constant: 0.0
            )
        )
    }

    /// Pin the vertical centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func pinVerticalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
        addConstraint(
            .verticalCenters,
            constraint: NSLayoutConstraint(
                item: primaryItem,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: secondaryItem,
                attribute: .centerY,
                multiplier: multiplier,
                constant: 0.0
            )
        )
    }

    /// Constrain the primary item width to the width of the secondary item
    /// - Parameter multiplier: The width multiplier
    /// - Returns: A reference to the `Pin`
    public func pinWidths(multiplier: CGFloat = 1.0) -> DoublePin {
        addConstraint(
            .widths,
            constraint: primaryItem.widthAnchor.constraint(
                equalTo: secondaryItem.widthAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Constrain the primary item height to the width of the secondary item
    /// - Parameter multiplier: The height multiplier
    /// - Returns: A reference to the `Pin`
    public func pinHeights(multiplier: CGFloat = 1.0) -> DoublePin {
        addConstraint(
            .heights,
            constraint: primaryItem.heightAnchor.constraint(
                equalTo: secondaryItem.heightAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Pin the leading edge of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func pinLeadingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .leadingEdgeToHorizontalCenter,
            constraint: primaryItem.leadingAnchor.constraint(
                equalTo: secondaryItem.centerXAnchor,
                constant: constant
            )
        )
    }

    /// Pin the trailing edge of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func pinTrailingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .trailingEdgeToHorizontalCenter,
            constraint: primaryItem.trailingAnchor.constraint(
                equalTo: secondaryItem.centerXAnchor,
                constant: constant
            )
        )
    }

    /// Pin the top of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func pinTopEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .topEdgeToVerticalCenter,
            constraint: primaryItem.topAnchor.constraint(
                equalTo: secondaryItem.centerYAnchor,
                constant: constant
            )
        )
    }

    /// Pin the bottom of the primary item to the center of the secondary item
    /// - Parameter constant: A negative value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func pinBottomEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .bottomEdgeToVerticalCenter,
            constraint: primaryItem.bottomAnchor.constraint(
                equalTo: secondaryItem.centerYAnchor,
                constant: constant
            )
        )
    }

    private func addConstraint(_ type: Constraint, constraint: NSLayoutConstraint) -> Self {
        addConstraint(withIdentifier: type.rawValue, constraint: constraint)
    }

    private let primaryItem: Pinnable
    private let secondaryItem: Pinnable
}
