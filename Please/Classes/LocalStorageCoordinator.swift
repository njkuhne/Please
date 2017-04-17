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
	return localStoragePath() + forIdentifier + ".temp"
}

class LocalStorageCoordinator: FileSystemStorable, FileSystemFetchable {
	private let fileManager = FileManager.default
	
	// MARK: FileSystemStorable
	func store(data: Data, withIdentifier: Identifiable) -> Bool {
		return fileManager.createFile(atPath: storagePath(forIdentifier: withIdentifier.identifierString), contents: data)
	}
	func move(localFile: URL, withIdentifier: Identifiable) -> Bool {
		let identifierURL = URL(fileURLWithPath: storagePath(forIdentifier: withIdentifier.identifierString))
		do {
			try fileManager.moveItem(at: localFile, to: identifierURL)
		}
		catch {
			return false
		}
		return true
	}
	
	// MARK: FileSystemFetchable
	func has(fileWithIdentifier: Identifiable) -> Bool {
		return fileManager.fileExists(atPath: storagePath(forIdentifier: fileWithIdentifier.identifierString))
	}
	
	func load(fromFileWithIdentifier: Identifiable) -> Data? {
		return fileManager.contents(atPath: storagePath(forIdentifier: fromFileWithIdentifier.identifierString))
	}
}
