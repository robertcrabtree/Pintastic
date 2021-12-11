////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 Robert Crabtree
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Foundation
import UIKit

/// An autolayout wrapper that  uses method chaining to constrain views.
/// Use this class to apply constraints to a view in relation to another view.
///
/// You can create a `MultiItemPin` by calling `pin(to:)` on a `Pinnable` item.
/// ```
/// view
///     .pin(to: containerView)
///     .pinEdges()
///     .activate()
/// ```
public final class MultiItemPin: PinBase<MultiItemPinConstraint> {

    /// Initialize a `MultiItemPin` with the item(s) to apply constraints to
    /// - Parameter primaryItem: The `Pinnable` item you wish to apply constraints to
    /// - Parameter secondaryItem: The second `Pinnable` item you wish to apply constraints to
    public init(primaryItem: Pinnable, secondaryItem: Pinnable) {
        self.primaryItem = primaryItem
        self.secondaryItem = secondaryItem
        super.init()
    }

    /// Pin the edges of the primary item to the secondary item
    /// - Returns: A reference to the `MultiItemPin`
    public func pinEdges() -> MultiItemPin {
        pinLeadingEdges().pinTrailingEdges().pinTopEdges().pinBottomEdges()
    }

    /// Pin the leading edges of the primary item to the secondary item
    /// - Parameter constant: A positive value will inset the leading edge by this value.
    /// - Returns: A reference to the `MultiItemPin`
    public func pinLeadingEdges(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinTrailingEdges(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinTopEdges(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinBottomEdges(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinAbove(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinBelow(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinBefore(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinAfter(constant: CGFloat = 0.0) -> MultiItemPin {
        addConstraint(
            .after,
            constraint: primaryItem.leadingAnchor.constraint(
                equalTo: secondaryItem.trailingAnchor,
                constant: constant
            )
        )
    }

    /// Pin the horizontal and vertical centers of the primary to the secondary item
    /// - Returns: A reference to the `MultiItemPin`
    public func pinCenters() -> MultiItemPin {
        pinHorizontalCenters().pinVerticalCenters()
    }

    /// Pin the horizontal centers of the primary item and the secondary item
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `MultiItemPin`
    public func pinHorizontalCenters(multiplier: CGFloat = 1.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinVerticalCenters(multiplier: CGFloat = 1.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinWidths(multiplier: CGFloat = 1.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinHeights(multiplier: CGFloat = 1.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinLeadingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinTrailingEdgeToHorizontalCenter(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinTopEdgeToVerticalCenter(constant: CGFloat = 0.0) -> MultiItemPin {
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
    /// - Returns: A reference to the `MultiItemPin`
    public func pinBottomEdgeToVerticalCenter(constant: CGFloat = 0.0) -> MultiItemPin {
        addConstraint(
            .bottomEdgeToVerticalCenter,
            constraint: primaryItem.bottomAnchor.constraint(
                equalTo: secondaryItem.centerYAnchor,
                constant: constant
            )
        )
    }

    private let primaryItem: Pinnable
    private let secondaryItem: Pinnable
}
