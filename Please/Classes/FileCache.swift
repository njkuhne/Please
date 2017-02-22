//
//  FileCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

fileprivate func uniqueIdentifier(forURL: URL) -> String {
	return ""
}

class FileCache<T:Cachable>: Fetchable {
	let fileSystemFetchable: FileSystemFetchable
	
	init(fileSystemFetchable: FileSystemFetchable) {
		self.fileSystemFetchable = fileSystemFetchable
	}
	
	// MARK: Fetchable
	func canFetch(for url: URL) -> Bool {
		return fileSystemFetchable.has(fileWithIdentifier: uniqueIdentifier(forURL: url))
	}
	
	func fetch(for url: URL, completion: ((Cachable) -> Void)) {
		if let data = fileSystemFetchable.load(fromFileWithIdentifier: uniqueIdentifier(forURL: url)), let cachable = T(data: data) {
			completion(cachable)
		}
	}
}
