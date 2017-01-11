//
//  FileCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-22.
//
//

import UIKit

class FileStorage<Cachable: PleaseCachable>: Fetchable, Storable {
	private let storageDirectory = NSTemporaryDirectory()
	private let fileManager = FileManager.default
	
	// MARK: Fetchable
	func canFetch(url: URL) -> Bool {
		let path = self.path(forUniversalLocation: url)
		return fileManager.fileExists(atPath: path)
	}
	
	func fetch(url: URL, withCompletion: @escaping ((PleaseCachable) -> Void)) {
		guard canFetch(url: url) else {
			return
		}
		let path = self.path(forUniversalLocation: url)
		if let data = fileManager.contents(atPath: path) {
			let cachable = Cachable.convertToObject(data: data)
			withCompletion(cachable)
		}
	}
	
	// MARK: Storable
	func store(object: PleaseCachable, forURL: URL) -> Bool {
		guard canFetch(url: forURL) == false else {
			return false
		}
		let data = Cachable.convertToData(cachable: object)
		let path = self.path(forUniversalLocation: forURL)
		return fileManager.createFile(atPath: path, contents: data as Data, attributes: nil)
	}
	
	// MARK: Helpers
	private func path(forUniversalLocation url: URL) -> String {
		return storageDirectory + "/" + self.storableFileName(forUniversalLocation: url)
	}
	
	private func storableFileName(forUniversalLocation url: URL) -> String {
		return "\(url.absoluteString.hash)"
	}
}
