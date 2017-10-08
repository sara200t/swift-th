//
//  main.swift
//  KeyboardInput
//
//  Created by Thanich Juthapisuth on 2017-09-23.
//  Copyright © 2017 Best in Bussiness Software Solution. All rights reserved.
//

import Foundation

print("Please enter text")

var number = 0
if let input = readLine(), let number = Int(input) {
    print ("Your input: \(number)")
} else {
    print("Please enter")
}



