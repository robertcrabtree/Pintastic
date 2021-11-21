//
//  Pin+Constraint.swift
//  Pintastic
//
//  Created by Rob on 11/20/21.
//

import Foundation

public extension Pin {

    /// Represents a constraint that can be applied to one or more `Pinnable` items
    enum Constraint {

        /// Relational constraint with leading edges pinned
        case leadingEdges

        /// Relational constraint with trailing edges pinned
        case trailingEdges

        /// Relational constraint with top edges pinned
        case topEdges

        /// Relational constraint with bottom edges pinned
        case bottomEdges

        /// Relational constraint with bottom edge of primary item pinned to top edge of second item
        case bottomAndTopEdges

        /// Relational constraint with top edge of primary item pinned to bottom edge of second item
        case topAndBottomEdges

        /// Relational constraint with leading edge of primary item pinned to trailing edge of second item
        case leadingAndTrailingEdges

        /// Relational constraint with trailing edge of primary item pinned to leading edge of second item
        case trailingAndLeadingEdges

        /// Relational constraint with horizontal centers pinned
        case horizontalCenters

        /// Relational constraint with vertical centers pinned
        case verticalCenters

        /// Discreet constraint with a specified width
        case width

        /// Discreet constraint with a specified height
        case height

        /// Relational constraint with equal widths
        case equalWidths

        /// Relational constraint with equal heights
        case equalHeights

        /// Relational constraint with leading edge of primary item constrained to horizontal center of second item
        case leadingEdgeAndCenter

        /// Relational constraint with trailing edge of primary item constrained to horizontal center of second item
        case trailingEdgeAndCenter

        /// Relational constraint with top edge of primary item constrained to vertical center of second item
        case topEdgeAndCenter

        /// Relational constraint with bottom edge of primary item constrained to vertical center of second item
        case bottomEdgeAndCenter
    }
}
