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
    var buttonState = false
    mutating func touchBegan(nodeA:SCNNode, nodeB:SCNNode, physicsWorld:SCNPhysicsWorld){
            
             let physics = physicsWorld
             let checked =  physics.contactTestBetween(nodeA.physicsBody!, nodeB.physicsBody!,
             options: nil)
             if checked == [] {
               first = true
             }else{
                
                if (nodeB.name == "startButton"){
                    buttonOnOff(A:nodeA, B:nodeB)
                }
                
             
    }
}
    
    mutating func buttonOnOff(A:SCNNode, B:SCNNode){
        if(first == true){
                        if B.isPaused == false {
                          B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                          if let text = B.childNode(withName: "text", recursively: true) {
                              text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                          }
                          B.isPaused = true
                      }else{
                          if let text = B.childNode(withName: "text", recursively: true) {
                              text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                          }
                          B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                          B.isPaused = false
                      }
                          
                          AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                          self.first = false
                     }
    }
    
}
