//
//  Box.swift
//  PinchDrawing
//
//  Created by João Costa on 09/04/2020.
//  Copyright © 2020 João Costa. All rights reserved.
//

import Foundation
import UIKit

struct Box {
    let redView = UIView()
    func MakeBox(){
        redView.layer.borderWidth = 2;
        redView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor;
        redView.alpha = 0.4;
    }
  
    
  
}
