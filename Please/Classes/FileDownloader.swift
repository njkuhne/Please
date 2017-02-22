//
//  FileDownloader.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

class FileDownloader: Fetchable {
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
