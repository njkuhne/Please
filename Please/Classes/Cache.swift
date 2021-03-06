//
//  Cache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

public class Cache<T: Cachable> {
	public func cache(url: URL) {
		retrieve(url: url)
	}
	public func retrieve(url: URL, completion: @escaping ((T) -> Void)) {
		retrieve(url: url, completionOrNil: completion)
	}
	
	let storageCoordinator = LocalStorageCoordinator()
	let fileCache: FileStorage<T>
	let network: NetworkFetcher<T>
	let fetchables: [Fetchable]
	
	init() {
		self.fileCache = FileStorage<T>(fileSystemFetchable: storageCoordinator)
		self.network = NetworkFetcher<T>(fileSystem: storageCoordinator)
		self.fetchables = [self.fileCache, self.network]
	}
	
	private func retrieve(url: URL, completionOrNil:((T) -> Void)? = nil) {
		if let fetchable = firstFetchable(url: url) {
			fetchable.fetch(for: url, completion: { (object) in
				if let completion = completionOrNil, let object = object as? T {
					completion(object)
				}
			})
		}
	}
	
	private func firstFetchable(url: URL) -> Fetchable? {
		for fetchable in fetchables {
			if fetchable.canFetch(for: url) {
				return fetchable
			}
		}
		return nil
	}
}

public extension Cache {
	public func cache(url: String) {
		if let url = URL(string: url) {
			cache(url: url)
		}
	}
	public func retrieve(url: String, completion: @escaping ((T) -> Void)) {
		if let url = URL(string: url) {
			retrieve(url: url, completion: completion)
		}
	}
}
