//
//  Helper.swift
//  HomeWork-Assignment
//
//  Created by Mitali Kulkarni on 19/01/18.
//  Copyright © 2018 Mitali Kulkarni. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String) {
        // To load the imagaes from the URL
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
