//
//  Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

public class Please: NSObject {
	public static func cache(imageLocation:String) {
		self.sharedPlease.cache(imageLocation: imageLocation)
	}
	public static func retrieve(imageLocation:String, completion : @escaping ((UIImage) -> Void)) {
		self.sharedPlease.retrieve(imageLocation: imageLocation, completion: completion)
	}
	
	private static let sharedPlease = Please()
	
	let imageCache = ImageCache()
	let fileStorage = FileStorage()
	let imageDownloader = ImageFetcher()
	
	var fetchables: [ImageFetchable]
	var storables: [ImageStorable]
	
	override init() {
		self.fetchables = [imageCache, fileStorage, imageDownloader]
		self.storables = [imageCache, fileStorage]
	}
	
	func cache(imageLocation:String) {
		self.retrieve(imageLocation: imageLocation, completion: nil)
	}
	
	func retrieve(imageLocation:String, completion : ((UIImage) -> Void)? = nil) {
		for fetchable in fetchables {
			if fetchable.canFetchImage(forUniversalLocation: imageLocation) {
				fetchable.fetchImage(forUniversalLocation: imageLocation, andCompletion: { [unowned self] (image: UIImage) in
					self.didFetch(image: image, forLocation: imageLocation)
					if let completion = completion {
						completion(image)
					}
				})
			}
		}
	}
	
	func didFetch(image: UIImage, forLocation: String) {
		storables.forEach { (storable : ImageStorable) in
			storable.store(image: image, forUniversalLocation: forLocation)
		}
	}
}

protocol ImageFetchable {
	func canFetchImage(forUniversalLocation location: String) -> Bool
	func fetchImage(forUniversalLocation location: String, andCompletion: @escaping ((UIImage) -> Void))
}

protocol ImageStorable {
	func store(image: UIImage, forUniversalLocation location: String) -> Bool
}

