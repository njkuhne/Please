//
//  Fetchable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

protocol Fetchable {
	func canFetch(for: URL) -> Bool
	func fetch(for: URL, completion: @escaping ((Cachable) -> Void))
}
