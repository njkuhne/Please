//
//  Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2016-12-20.
//
//

import UIKit

public class Please: NSObject {
	public static func cache(image:String) {
		let please = self.sharedPlease
	}
	public static func retrieve(image:String, completion : ((UIImage) -> Void)) {
		let please = self.sharedPlease
	}
	
	private static let sharedPlease = Please()
	
	private let cache = ImageAndFileCache()
}
