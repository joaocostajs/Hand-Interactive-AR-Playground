//
//  TouchManager.swift
//  Hand Interactive AR Playground
//
//  Created by João Costa on 09/06/2020.
//  Copyright © 2020 João Costa. All rights reserved.
//

import Foundation
import ARKit

struct TouchManager{
    var first = false
    
    mutating func touchBegan(nodeA:SCNNode, nodeB:SCNNode, physicsWorld:SCNPhysicsWorld){
            
             let physics = physicsWorld
             let checked =  physics.contactTestBetween(nodeA.physicsBody!, nodeB.physicsBody!,
             options: nil)
             if checked == [] {
                   nodeB.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               first = true
             }else{
               if(first == true){
                   nodeB.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    first = false
               }
    }
}
    
}
