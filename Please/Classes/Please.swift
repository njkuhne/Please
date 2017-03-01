//
//  Please.swift
//  Pods
//
//  Created by Nicholas Kuhne on 2017-03-01.
//
//

import UIKit

extension UIImage: Cachable {} // UIImage already has init?(data: Data)

public let Please = Cache<UIImage>()
