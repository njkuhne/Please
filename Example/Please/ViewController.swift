//
//  ViewController.swift
//  Please
//
//  Created by Nicholas Kuhne on 12/20/2016.
//  Copyright (c) 2016 Nicholas Kuhne. All rights reserved.
//

import UIKit
import Please

class ViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.imageView.url = url
    }

}

