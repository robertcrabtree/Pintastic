//
//  File.swift
//  
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
        self.primaryItem = item
    }

    /// Constrain the width of the primary item to the the specified constant
    /// - Parameter constant: The desired width
    /// - Returns: A reference to the `Pin`
    public func width(constant: CGFloat) -> SinglePin {
        addConstraint(
            .width,
            constraint: primaryItem.widthAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the height of the primary item to the the specified constant
    /// - Parameter constant: The desired height
    /// - Returns: A reference to the `Pin`
    public func height(constant: CGFloat) -> SinglePin {
        addConstraint(
            .height,
            constraint: primaryItem.heightAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func widthToHeight(multiplier: CGFloat = 1.0) -> SinglePin {
        addConstraint(
            .widthToHeight,
            constraint: primaryItem.widthAnchor.constraint(
                equalTo: primaryItem.heightAnchor,
                multiplier: multiplier
            )
        )
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `Pin`
    public func heightToWidth(multiplier: CGFloat = 1.0) -> SinglePin {
        addConstraint(
            .heightToWidth,
            constraint: primaryItem.heightAnchor.constraint(
                equalTo: primaryItem.widthAnchor,
                multiplier: multiplier
            )
        )
    }

    private let primaryItem: Pinnable

    private func addConstraint(_ type: Constraint, constraint: NSLayoutConstraint) -> Self {
        addConstraint(withIdentifier: type.rawValue, constraint: constraint)
    }
}
