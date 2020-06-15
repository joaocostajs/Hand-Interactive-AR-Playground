//
//  TouchManager.swift
//  Hand Interactive AR Playground
//
//  Created by João Costa on 09/06/2020.
//  Copyright © 2020 João Costa. All rights reserved.
//

import Foundation
import ARKit
import AVFoundation

var player: AVAudioPlayer?

struct TouchManager{
    var contact = false
    var buttonState = false
    mutating func touchBegan(nodeA:SCNNode, nodeB:SCNNode, physicsWorld:SCNPhysicsWorld){
        
        let physics = physicsWorld
        let checked =  physics.contactTestBetween(nodeA.physicsBody!, nodeB.physicsBody!,
                                                  options: nil)
        if checked == [] {
            print(checked)
            buttonState = true
        }else{
            print("on")
            contact = true
            if buttonState == true{
                if (nodeB.name == "startButton"){
                    buttonOnOff(A:nodeA, B:nodeB)
                }
                if (nodeB.name == "box1"){
                    red(A:nodeA, B:nodeB)
                }
                if (nodeB.name == "geosphere"){
                    buttonOnOffVersion2(A:nodeA, B:nodeB)
                }
                if (nodeB.name == "pyramid"){
                    blue(A:nodeA, B:nodeB)
                               }
                if (nodeB.name == "c3" || nodeB.name == "d3" || nodeB.name == "e3" || nodeB.name == "f3" || nodeB.name == "g3"){
                    playSound(sound: nodeB.name!)
                }
                buttonState = false
            }
        }
    }
    
    
    func  playSound(sound:String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    mutating func buttonOnOff(A:SCNNode, B:SCNNode){
        
        if  B.geometry?.firstMaterial?.diffuse.contents as! UIColor == #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1){
            
            if let text = B.childNode(withName: "text", recursively: true) {
                text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            if let text = B.childNode(withName: "text", recursively: true) {
                text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
        //                     }
    }
    
    
    mutating func buttonOnOffVersion2(A:SCNNode, B:SCNNode){
         
         if  B.geometry?.firstMaterial?.diffuse.contents as! UIColor == #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1){
             
             if let text = B.childNode(withName: "text", recursively: true) {
                 text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
             }
             B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         }else{
             B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
             if let text = B.childNode(withName: "text", recursively: true) {
                 text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
             }
         }
         
         AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
         //                     }
     }
    
    mutating func blue(A:SCNNode, B:SCNNode){
          
          if  B.geometry?.firstMaterial?.diffuse.contents as! UIColor == #colorLiteral(red: 0, green: 0.9921568627, blue: 1, alpha: 1){
              
              if let text = B.childNode(withName: "text", recursively: true) {
                  text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
              }
              B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          }else{
              B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0.9921568627, blue: 1, alpha: 1)
              if let text = B.childNode(withName: "text", recursively: true) {
                  text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
              }
          }
          
          AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
          //                     }
      }
    
    mutating func red(A:SCNNode, B:SCNNode){
            
            if  B.geometry?.firstMaterial?.diffuse.contents as! UIColor == #colorLiteral(red: 1, green: 0.2156862745, blue: 0.2156862745, alpha: 1){
                
                if let text = B.childNode(withName: "text", recursively: true) {
                    text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
                B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                B.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
                if let text = B.childNode(withName: "text", recursively: true) {
                    text.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
            
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
            //                     }
        }
    
}


//#colorLiteral(red: 0, green: 0.007843137254, blue: 1, alpha: 1)
