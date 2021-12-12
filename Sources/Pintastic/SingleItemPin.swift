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

public final class SingleItemPin: PinBase<SingleItemPinConstraint> {

    /// Initialize a `SingleItemPin` with the item to apply constraints to
    /// - Parameter item: The `Pinnable` item you wish to apply constraints to
    public init(item: Pinnable) {
        self.item = item
        super.init()
    }

    /// Constrain the width of the primary item to the the specified constant
    /// - Parameter constant: The desired width
    /// - Returns: A reference to the `SingleItemPin`
    public func pinWidth(constant: CGFloat) -> SingleItemPin {
        addConstraint(
            .width,
            constraint: item.widthAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the height of the primary item to the the specified constant
    /// - Parameter constant: The desired height
    /// - Returns: A reference to the `SingleItemPin`
    public func pinHeight(constant: CGFloat) -> SingleItemPin {
        addConstraint(
            .height,
            constraint: item.heightAnchor.constraint(equalToConstant: constant)
        )
    }

    /// Constrain the primary item width and height to the specified values
    /// - Parameters:
    ///   - width: The item width
    ///   - height: The item height
    /// - Returns: A reference to the `SingleItemPin`
    public func pin(width: CGFloat, height: CGFloat) -> SingleItemPin {
        pinWidth(constant: width).pinHeight(constant: height)
    }

    /// Constrain the primary item size to the specified value
    /// - Parameter size: The item size
    /// - Returns: A reference to the `SingleItemPin`
    public func pin(size: CGSize) -> SingleItemPin {
        pin(width: size.width, height: size.height)
    }

    /// Constrain the primary item width to the primary item height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `SingleItemPin`
    public func pinWidthEqualToHeight(multiplier: CGFloat = 1.0) -> SingleItemPin {
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
    /// - Returns: A reference to the `SingleItemPin`
    public func pinHeightEqualToWidth(multiplier: CGFloat = 1.0) -> SingleItemPin {
        addConstraint(
            .heightEqualToWidth,
            constraint: item.heightAnchor.constraint(
                equalTo: item.widthAnchor,
                multiplier: multiplier
            )
        )
    }

    private let item: Pinnable
}

public extension Pinnable {

    /// Use the `makePin()` method to apply trivial constraints to an item such as width and height constraints.
    ///
    /// ```
    /// view
    ///     .makePin()
    ///     .pinWidth(constant: 100)
    ///     .pinHeight(constant: 100)
    ///     .activate()
    /// ```
    ///
    /// - Returns: A reference to the `SingleItemPin`
    func makePin() -> SingleItemPin {
        SingleItemPin(item: self)
    }

    /// Constrain the width of the receiver to the the specified constant
    /// - Parameter constant: The desired width
    /// - Returns: A reference to the `SingleItemPin`
    func pinWidth(constant: CGFloat) -> SingleItemPin {
        SingleItemPin(item: self)
            .pinWidth(constant: constant)
    }

    /// Constrain the height of the receiver to the the specified constant
    /// - Parameter constant: The desired height
    /// - Returns: A reference to the `SingleItemPin`
    func pinHeight(constant: CGFloat) -> SingleItemPin {
        SingleItemPin(item: self)
            .pinHeight(constant: constant)
    }

    /// Constrain the receiver width and height to the specified values
    /// - Parameters:
    ///   - width: The item width
    ///   - height: The item height
    /// - Returns: A reference to the `SingleItemPin`
    func pin(width: CGFloat, height: CGFloat) -> SingleItemPin {
        SingleItemPin(item: self)
            .pin(width: width, height: height)
    }

    /// Constrain the receiver size to the specified value
    /// - Parameter size: The item size
    /// - Returns: A reference to the `SingleItemPin`
    func pin(size: CGSize) -> SingleItemPin {
        SingleItemPin(item: self)
            .pin(size: size)
    }

    /// Constrain the receiver width to the receiver height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `SingleItemPin`
    func pinWidthEqualToHeight(multiplier: CGFloat = 1.0) -> SingleItemPin {
        SingleItemPin(item: self)
            .pinWidthEqualToHeight(multiplier: multiplier)
    }

    /// Constrain the receiver width to the receiver height
    /// - Parameter multiplier: The multiplier
    /// - Returns: A reference to the `SingleItemPin`
    func pinHeightEqualToWidth(multiplier: CGFloat = 1.0) -> SingleItemPin {
        SingleItemPin(item: self)
            .pinHeightEqualToWidth(multiplier: multiplier)
    }
}
