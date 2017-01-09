//
//  Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-01-09.
//
//

import UIKit

extension UIImage: PleaseCachable {
	public static func convertToObject(data: Data) -> PleaseCachable {
		return UIImage(data: data)!
	}
	public static func convertToData(cachable: PleaseCachable) -> Data {
		return UIImagePNGRepresentation(cachable as! UIImage)!
	}
}

public let Please = Pleaser<UIImage>()
