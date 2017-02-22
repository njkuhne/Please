//
//  Cache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

class Cache<T: Cachable> {
	static func cache(url: URL) {
		
	}
	static func retrieve(url: URL, completion: ((T) -> Void)? = nil) {
		
	}
}


extension Cache {
	static func cache(url: String) {
		if let url = URL(string: url) {
			cache(url: url)
		}
	}
	static func retrieve(url: String, completion: ((T) -> Void)? = nil) {
		if let url = URL(string: url) {
			retrieve(url: url, completion: completion)
		}
	}
}
