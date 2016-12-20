//
//  ImageCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

protocol ImageCacheable {
	func containsImage(forIdentifier identifier: String) -> Bool
	func store(image: UIImage, forIdentifier identifier: String) -> Bool
	func retrieveImage(forIdentifier identifier: String) -> UIImage?
}

class ImageAndFileCache : ImageCacheable {
	let imageCache = ImageCache()
	let fileCache = FileCache()
	
	internal func containsImage(forIdentifier identifier: String) -> Bool {
		if imageCache.containsImage(forIdentifier: identifier) {
			return true
		}
		if fileCache.containsImage(forIdentifier: identifier) {
			return true
		}
		return false
	}
	
	internal func store(image: UIImage, forIdentifier identifier: String) -> Bool {
		if self.imageCache.store(image: image, forIdentifier: identifier) &&
			self.fileCache.store(image: image, forIdentifier: identifier) {
			return true
		}
		return false
	}
	
	internal func retrieveImage(forIdentifier identifier: String) -> UIImage? {
		if imageCache.containsImage(forIdentifier: identifier) {
			return imageCache.retrieveImage(forIdentifier: identifier)
		}
		else if fileCache.containsImage(forIdentifier: identifier) {
			if let image = fileCache.retrieveImage(forIdentifier: identifier) {
				imageCache.store(image: image, forIdentifier: identifier)
				return image
			}
		}
		return nil
	}
}

class ImageCache: ImageCacheable {
	private let cache = NSCache<NSString, UIImage>()
	
	func containsImage(forIdentifier identifier: String) -> Bool {
		return (cache.object(forKey: identifier as NSString) != nil)
	}
	
	func store(image: UIImage, forIdentifier identifier: String) -> Bool {
		cache.setObject(image, forKey: identifier as NSString)
		return true
	}
	
	func retrieveImage(forIdentifier identifier: String) -> UIImage? {
		guard containsImage(forIdentifier: identifier) else {
			return nil
		}
		return cache.object(forKey: identifier as NSString)
	}
}

class FileCache: ImageCacheable {
	private let storageDirectory = NSTemporaryDirectory()
	private let fileManager = FileManager.default
	
	func containsImage(forIdentifier identifier: String) -> Bool {
		let path = self.path(forIdentifier: identifier)
		return fileManager.fileExists(atPath: path)
	}
	
	func store(image: UIImage, forIdentifier identifier: String) -> Bool {
		guard containsImage(forIdentifier: identifier) == false else {
			return false
		}
		let path = self.path(forIdentifier: identifier)
		if let data = self.data(forImage: image) {
			return fileManager.createFile(atPath: path, contents: data as Data, attributes: nil)
		}
		return false
	}
	
	func retrieveImage(forIdentifier identifier: String) -> UIImage? {
		guard containsImage(forIdentifier: identifier) else {
			return nil
		}
		let path = self.path(forIdentifier: identifier)
		if let data = fileManager.contents(atPath: path) {
			return self.image(forData: data)
		}
		return nil
	}
	
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
