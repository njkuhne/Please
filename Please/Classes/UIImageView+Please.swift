//
//  UIImageView+Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

extension UIImageView: Pleasing {
	public func set(object: PleaseCachable) {
		if let image = object as? UIImage {
			self.image = image
		}
	}
}
