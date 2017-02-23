//
//  NetworkFetcher.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-23.
//
//

import Foundation

class NetworkFetcher: Fetchable {
	let fileSystemStorable: FileSystemStorable
	
	init(fileSystemStorable: FileSystemStorable) {
		self.fileSystemStorable = fileSystemStorable
	}
	
	// MARK: Fetchable
	func canFetch(for: URL) -> Bool {
		return true
	}
	func fetch(for: URL, completion: ((Cachable) -> Void)) {
		
	}
}
