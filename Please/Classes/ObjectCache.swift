//
//  ObjectCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

class ObjectCache<T:Cachable>: Fetchable, Storable {
	let cache : NSCache<NSString,T>
	
	init() {
		self.cache = NSCache<NSString, T>()
	}
	
	// MARK: Fetchable
	func canFetch(for url: URL) -> Bool {
		return (cache.object(forKey: url.identifierString as NSString) != nil)
	}
	
	func fetch(for url: URL, completion: @escaping ((Cachable) -> Void)) {
		if let object = cache.object(forKey: url.identifierString as NSString) {
			completion(object)
		}
	}
	
	// MARK: Storable
	func store(object: Cachable, for url: URL) -> Bool {
		cache.setObject(object as! T, forKey: url.identifierString as NSString)
		return canFetch(for: url)
	}
}
