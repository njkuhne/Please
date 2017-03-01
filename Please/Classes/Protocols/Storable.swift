//
//  Storable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation


func uniqueIdentifier(forURL: URL) -> String {
	return "\(forURL.hashValue)"
}

protocol Storable {
	func store(object: Cachable, for: URL) -> Bool
}
