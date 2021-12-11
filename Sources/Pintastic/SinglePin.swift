//
//  SinglePin.swift
//  Pintastic
//
//  Created by Rob on 12/11/21.
//

import Foundation
import UIKit

public final class SinglePin: Pinning {

    public var constraints: [String : NSLayoutConstraint] = [:]

    /// Initialize a `Pin` with the item(s) to apply constraints to
    /// - Parameter item: The `Pinnable` item you wish to apply constraints to
    public init(item: Pinnable) {
        self.item = item
    }

    /// Constrain the width of the primary item to the the specified constant
    /// - Parameter constant: The desired width
    /// - Returns: A reference to the `Pin`
    public func pinWidth(constant: CGFloat) -> SinglePin {
        addConstraint(
            .width,
            constraint: item.widthAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the height of the primary item to the the specified constant
    /// - Parameter constant: The desired height
    /// - Returns: A reference to the `Pin`
    public func pinHeight(constant: CGFloat) -> SinglePin {
        addConstraint(
            .height,
            constraint: item.heightAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func pinWidthEqualToHeight(multiplier: CGFloat = 1.0) -> SinglePin {
        addConstraint(
            .widthEqualToHeight,
            constraint: item.widthAnchor.constraint(
                equalTo: item.heightAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func pinHeightEqualToWidth(multiplier: CGFloat = 1.0) -> SinglePin {
        addConstraint(
            .heightEqualToWidth,
            constraint: item.heightAnchor.constraint(
                equalTo: item.widthAnchor,
                multiplier: multiplier
            )
        )
    }

    private let item: Pinnable

    private func addConstraint(_ type: Constraint, constraint: NSLayoutConstraint) -> Self {
        addConstraint(withIdentifier: type.rawValue, constraint: constraint)
    }
}
