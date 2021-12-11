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
    public func trailingEdges(constant: CGFloat = 0.0) -> DoublePin {
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
    public func topEdges(constant: CGFloat = 0.0) -> DoublePin {
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
    public func bottomEdges(constant: CGFloat = 0.0) -> DoublePin {
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
    public func above(constant: CGFloat = 0.0) -> DoublePin {
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
    public func below(constant: CGFloat = 0.0) -> DoublePin {
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
    public func before(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .before,
            constraint: primaryItem.trailingAnchor.constraint(
                equalTo: secondaryItem.leadingAnchor,
                constant: constant
            )
        )
    }

    /// Pin the leading edge of the primary item to the trailing edge of the secondary item
    /// - Parameter constant: A positive value will create space betwen the primary and secondary items
    /// - Returns: A reference to the `Pin`
    public func after(constant: CGFloat = 0.0) -> DoublePin {
        addConstraint(
            .after,
            constraint: primaryItem.leadingAnchor.constraint(
                equalTo: secondaryItem.trailingAnchor,
                constant: constant
            )
        )
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
    public func verticalCenters(multiplier: CGFloat = 1.0) -> DoublePin {
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
    public func equalWidths(multiplier: CGFloat = 1.0) -> DoublePin {
        addConstraint(
            .equalWidths,
            constraint: primaryItem.widthAnchor.constraint(
                equalTo: secondaryItem.widthAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Constrain the primary item height to the width of the secondary item
    /// - Parameter multiplier: The height multiplier
    /// - Returns: A reference to the `Pin`
    public func equalHeights(multiplier: CGFloat = 1.0) -> DoublePin {
        addConstraint(
            .equalHeights,
            constraint: primaryItem.heightAnchor.constraint(
                equalTo: secondaryItem.heightAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Pin the leading edge of the primary item to the center of the secondary item
    /// - Parameter constant: A positive value will create space between the item and the secondary item
    /// - Returns: A reference to the `Pin`
    public func leadingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
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
    public func trailingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> DoublePin {
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
    public func topEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
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
    public func bottomEdgeToVerticalCenter(constant: CGFloat = 0.0) -> DoublePin {
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
