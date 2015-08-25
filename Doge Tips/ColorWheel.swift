//
//  ColorWheel.swift
//  parallel
//
//  Created by Daniel Noskin on 6/2/2015.
//  Copyright (c) 2015 Daniel Noskin. All rights reserved.
//

import Foundation
import UIKit

struct ColorWheel {
    let colorsArray = [
        // colors from flatuicolors.com
        UIColor(red: 170/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor(red: 255/255.0, green: 170/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor(red: 255/255.0, green: 0/255.0, blue: 170/255.0, alpha: 1.0),
        UIColor(red: 170/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0),
        UIColor(red: 0/255.0, green: 170/255.0, blue: 255/255.0, alpha: 1.0)
    ]
    
    func randomColor() -> UIColor {
        let unsignedArrayCount = UInt32(colorsArray.count)
        let unsignedRandomValue = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomValue)
        
        return colorsArray[randomNumber]
    }
}