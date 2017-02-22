//
//  Storable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

protocol Storable {
	func store(object: Cachable, for: URL) -> Bool
}
