//
//  ImageCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

class Cache<Cachable: PleaseCachable>: Fetchable, Storable {
	private let cache = NSCache<NSURL, Cachable>()
	
	// MARK: Fetchable
	func canFetch(url: URL) -> Bool {
		return (cache.object(forKey: url as NSURL) != nil)
	}
	
	func fetch(url: URL, withCompletion: @escaping ((PleaseCachable) -> Void)) {
		guard canFetch(url: url) else {
			return
		}
		if let cachable = cache.object(forKey: url as NSURL) as? PleaseCachable {
			withCompletion(cachable)
		}
	}
	
	// MARK Storable
	func store(object: PleaseCachable, forURL: URL) -> Bool {
		if let object = object as? Cachable {
			cache.setObject(object, forKey: forURL as NSURL)
			return true
		}
		return false
	}
}
