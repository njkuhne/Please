//
//  Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

public protocol PleaseCachable: AnyObject {
	static func convertToObject(data: Data) -> PleaseCachable
	static func convertToData(cachable:PleaseCachable) -> Data
}

public class Pleaser<Cachable: PleaseCachable>: NSObject {
	public func cache(url:URL) {
		self.retrieve(url: url, completion: nil)
	}
	public func retrieve(url:URL, completion : ((Cachable) -> Void)? = nil) {
		if let fetchable = self.fetchablesThatCanFetch(url: url)?.first {
			fetchable.fetch(url: url, withCompletion: { (cachable: Cachable) in
				if let completion = completion {
					completion(cachable)
				}
				if let cachable = cachable as? Cachable {
					self.didFetch(cachable:cachable, forURL:url)
				}
			} as! ((PleaseCachable) -> Void))
		}
	}
	
	let objectCache = Cache<Cachable>()
	let fileStorage = FileStorage<Cachable>()
	let downloader = NetworkFetcher<Cachable>()
	
	var fetchables: [Fetchable]
	var storables: [Storable]
	
	override init() {
		self.fetchables = [objectCache, fileStorage, downloader]
		self.storables = [objectCache, fileStorage]
	}
	
	func fetchablesThatCanFetch(url:URL) -> [Fetchable]? {
		return fetchables.filter({ (fetchable: Fetchable) -> Bool in
			return fetchable.canFetch(url: url)
		})
	}
	
	func didFetch(cachable: Cachable, forURL: URL) {
		storables.forEach { (storable : Storable) in
			storable.store(object: cachable, forURL: forURL)
		}
	}
}

protocol Fetchable {
	func canFetch(url: URL) -> Bool
	func fetch(url: URL, withCompletion: @escaping ((PleaseCachable) -> Void))
}

protocol Storable {
	func store(object: PleaseCachable, forURL:URL) -> Bool
}
