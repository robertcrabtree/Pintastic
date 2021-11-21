//
//  Pin+State.swift
//  Pintastic
//
//  Created by Rob on 11/20/21.
//

import Foundation

public extension Pin {

    /// An enum that indicates whether or not the constraints are active
    enum State {

        /// The `Pin` is inactive (the default state)
        case inactive

        /// The `Pin` is active
        case active
    }
}
