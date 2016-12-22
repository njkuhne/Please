//
//  FileCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-22.
//
//

import UIKit

class FileStorage: ImageFetchable, ImageStorable {
	private let storageDirectory = NSTemporaryDirectory()
	private let fileManager = FileManager.default
	
	// MARK: ImageFetchable
	func canFetchImage(forUniversalLocation location: String) -> Bool {
		let path = self.path(forIdentifier: location)
		return fileManager.fileExists(atPath: path)
	}
	
	func fetchImage(forUniversalLocation location: String, andCompletion: @escaping ((UIImage) -> Void)) {
		guard canFetchImage(forUniversalLocation: location) else {
			return
		}
		let path = self.path(forIdentifier: location)
		if let data = fileManager.contents(atPath: path) {
			if let image = self.image(forData: data) {
				andCompletion(image)
			}
		}
	}
	
	// MARK: ImageStorable
	
	func store(image: UIImage, forUniversalLocation location: String) -> Bool {
		guard canFetchImage(forUniversalLocation: location) == false else {
			return false
		}
		let path = self.path(forIdentifier: location)
		if let data = self.data(forImage: image) {
			return fileManager.createFile(atPath: path, contents: data as Data, attributes: nil)
		}
		return false
	}
	
	// MARK: Helpers
	private func path(forIdentifier identifier: String) -> String {
		return storageDirectory + "/" + self.storableFileName(forIdentifier: identifier)
	}
	
	private func storableFileName(forIdentifier identifier: String) -> String {
		return "\(identifier.hash)"
	}
	
	private func data(forImage image: UIImage) -> NSData? {
		return UIImagePNGRepresentation(image) as NSData?
	}
	
	private func image(forData data: Data) -> UIImage? {
		return UIImage(data: data)
	}
}
