//
//  UIImageView+Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import Foundation

public protocol Pleasing {
	func retrieve(image:String)
	func cancel()
}

extension UIImageView : Pleasing {
	public func retrieve(image:String) {
		ImageViewLoader.retrieve(image: image, forImageView: self)
	}
	public func cancel() {
		ImageViewLoader.cancel(loadingImageView: self)
	}
}

typealias ImageViewLoaderCompletion = (UIImage) -> (Void)
class ImageViewLoader : NSObject {
	
	static let sharedLoader = ImageViewLoader()
	
	static func retrieve(image: String, forImageView imageView: UIImageView) {
		self.sharedLoader.retrieve(image: image, forImageView: imageView)
	}
	
	static func cancel(loadingImageView imageView : UIImageView) {
		self.sharedLoader.cancel(loadingImageView: imageView)
	}
	
	private let imageViewMap = NSMapTable<UIImageView, AnyObject>.strongToStrongObjects()
	
	private func retrieve(image: String, forImageView imageView: UIImageView) {
		let completion = { [unowned imageView] (image: UIImage) in
			imageView.image = image
		}
		self.imageViewMap.setObject(completion as AnyObject, forKey: imageView)
		
		Please.retrieve(image: image) { (image: UIImage) in
			self.fireCompletion(forImageView: imageView, withImage: image)
		}
	}
	
	private func cancel(loadingImageView imageView : UIImageView) {
		self.imageViewMap.removeObject(forKey: imageView)
 	}
	
	private func fireCompletion(forImageView imageView: UIImageView, withImage image: UIImage) {
		if let completionBlock = self.imageViewMap.object(forKey: imageView) as? ImageViewLoaderCompletion {
			self.imageViewMap.removeObject(forKey: imageView)
			DispatchQueue.main.sync {
				completionBlock(image)
			}
		}
	}
}
