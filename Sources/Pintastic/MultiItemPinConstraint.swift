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

/// Represents a constraint that can be applied to one or more `Pinnable` items
public enum MultiItemPinConstraint: String {

    /// Relational constraint with leading edges pinned
    case leadingEdges = "pin.relational.leading.leading"

    /// Relational constraint with trailing edges pinned
    case trailingEdges = "pin.relational.trailing.trailing"

    /// Relational constraint with top edges pinned
    case topEdges = "pin.relational.top.top"

    /// Relational constraint with bottom edges pinned
    case bottomEdges = "pin.relational.bottom.bottom"

    /// Relational constraint with bottom edge of primary item pinned to top edge of second item
    case above = "pin.relational.bottom.top"

    /// Relational constraint with top edge of primary item pinned to bottom edge of second item
    case below = "pin.relational.top.bottom"

    /// Relational constraint with leading edge of primary item pinned to trailing edge of second item
    case after = "pin.relational.leading.trailing"

    /// Relational constraint with trailing edge of primary item pinned to leading edge of second item
    case before = "pin.relational.trailing.leading"

    /// Relational constraint with horizontal centers pinned
    case horizontalCenters = "pin.relational.hcenter.hcenter"

    /// Relational constraint with vertical centers pinned
    case verticalCenters = "pin.relational.vcenter.vcenter"

    /// Relational constraint with equal widths
    case widths = "pin.relational.width.width"

    /// Relational constraint with equal heights
    case heights = "pin.relational.height.height"

    /// Relational constraint with leading edge of primary item constrained to horizontal center of second item
    case leadingEdgeToHorizontalCenter = "pin.relational.leading.hcenter"

    /// Relational constraint with trailing edge of primary item constrained to horizontal center of second item
    case trailingEdgeToHorizontalCenter = "pin.relational.trailing.hcenter"

    /// Relational constraint with top edge of primary item constrained to vertical center of second item
    case topEdgeToVerticalCenter = "pin.relational.top.vcenter"

    /// Relational constraint with bottom edge of primary item constrained to vertical center of second item
    case bottomEdgeToVerticalCenter = "pin.relational.bottom.vcenter"
}
