//
//  LocalStorageCoordinator.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

fileprivate func localStoragePath() -> String {
	return NSTemporaryDirectory()
}

fileprivate func storagePath(forIdentifier: String) -> String {
	return localStoragePath() + "/" + forIdentifier
}

class LocalStorageCoordinator: FileSystemStorable, FileSystemFetchable {
	let fileManager = FileManager.default
	
	// MARK: FileSystemStorable
	func store(data: Data, withIdentifier: String) -> Bool {
		return fileManager.createFile(atPath: storagePath(forIdentifier: withIdentifier), contents: data)
	}
	func copy(localFile: URL, withIdentifier: String) -> Bool {
		let identifierURL = URL(fileURLWithPath: storagePath(forIdentifier: withIdentifier))
		do {
			try fileManager.moveItem(at: localFile, to: identifierURL)
		}
		catch _ {
			return false
		}
		return true
	}
	
	// MARK: FileSystemFetchable
	func has(fileWithIdentifier: String) -> Bool {
		return fileManager.fileExists(atPath: storagePath(forIdentifier: fileWithIdentifier))
	}
	
	func load(fromFileWithIdentifier: String) -> Data? {
		return fileManager.contents(atPath: storagePath(forIdentifier: fromFileWithIdentifier))
	}
}
