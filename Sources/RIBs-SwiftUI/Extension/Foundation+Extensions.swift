//
//  Foundation+Extensions.swift
//  RIBs
//
//  Created by Valery Kokanov on 09.11.2020.
//

import Foundation

/// Array extensions.
public extension Array {
    /// Remove the given element from this array, by comparing pointer references.
    ///
    /// - parameter element: The element to remove.
    mutating func removeElementByReference(_ element: Element) {
        guard
            let objIndex = firstIndex(where: { $0 as AnyObject === element as AnyObject })
        else { return }
        remove(at: objIndex)
    }
}
