//
//  DogeSayings.swift
//  Doge Tips
//
//  Created by Daniel Noskin on 6/2/15.
//  Copyright (c) 2015 Daniel Noskin. All rights reserved.
//

import Foundation
import UIKit

struct DogeSayings {
    let dogeArray = [
        "wow", "wow", "wow", "such tip", "very generous", "plz tip"
    ]
    
    func randomDoge() -> String {
        let unsignedArrayCount = UInt32(dogeArray.count)
        let unsignedRandomValue = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomValue)
        
        return dogeArray[randomNumber]
    }
}