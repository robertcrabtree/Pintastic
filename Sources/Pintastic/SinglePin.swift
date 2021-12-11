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
