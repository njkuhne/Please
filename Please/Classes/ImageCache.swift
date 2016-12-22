//
//  ImageCache.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

class ImageCache: ImageFetchable, ImageStorable {
	private let cache = NSCache<NSString, UIImage>()
	
	// MARK: ImageFetchable
	func canFetchImage(forUniversalLocation location: String) -> Bool {
		return (cache.object(forKey: location as NSString) != nil)
	}
	
	func fetchImage(forUniversalLocation location: String, andCompletion: @escaping ((UIImage) -> Void)) {
		guard canFetchImage(forUniversalLocation: location) else {
			return
		}
		if let image = cache.object(forKey: location as NSString) {
			andCompletion(image)
		}
	}
	
	// MARK ImageStorable
	func store(image: UIImage, forUniversalLocation location: String) -> Bool {
		cache.setObject(image, forKey: location as NSString)
		return true
	}
}
