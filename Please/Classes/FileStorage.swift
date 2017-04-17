//
//  FileCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

class FileStorage<T:Cachable>: Fetchable {
	private let fileSystemFetchable: FileSystemFetchable
	
	init(fileSystemFetchable: FileSystemFetchable) {
		self.fileSystemFetchable = fileSystemFetchable
	}
	
	// MARK: Fetchable
	func canFetch(for url: URL) -> Bool {
		return fileSystemFetchable.has(fileWithIdentifier: url)
	}
	
	func fetch(for url: URL, completion: @escaping ((Cachable) -> Void)) {
		if let data = fileSystemFetchable.load(fromFileWithIdentifier: url), let cachable = T(data: data) {
			completion(cachable)
		}
	}
}
