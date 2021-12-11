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

public extension SingleItemPin {

    /// Represents a constraint that can be applied to one or more `Pinnable` items
    enum Constraint: String {

        /// Discrete constraint with a specified width
        case width = "pin.discrete.width"

        /// Discrete constraint with a specified height
        case height = "pin.discrete.height"

        /// Discrete constraint with equal width and height
        case widthEqualToHeight = "pin.discrete.width.height"

        /// Discrete constraint with equal height and width
        case heightEqualToWidth = "pin.discrete.height.width"
    }
}
