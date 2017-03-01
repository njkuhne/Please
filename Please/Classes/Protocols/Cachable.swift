//
//  Cachable.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-02-22.
//
//

import Foundation

public protocol Cachable: AnyObject {
	init?(data:Data)
}
