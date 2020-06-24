//
//  Helpers.swift
//  PinchDrawing
//
//  Created by João Costa on 06/04/2020.
//  Copyright © 2020 João Costa. All rights reserved.
//

import Foundation

import UIKit
import SceneKit

struct Helpers {
    
    
    
    var rotationAngle:Double = 0
    var xxx:Double = 0
    var yyy:Double = 0
    var zzz:Double = 0
    var fov:Double = 0
    var nodes = Nodes()

    func calculateDistance(finger node1:SCNNode, closestNode node2:SCNNode) -> Double{
        let finger = node1
        let node2 = node2
        
        let distance = Double(abs(sqrt(
            pow(node2.position.x - finger.position.x, 2) +
                pow(node2.position.y - finger.position.y, 2) +
                pow(node2.position.z - finger.position.z, 2)
        )))
        
        return distance
    }
    
   
    
//    func smallestDistance(allNodes:[SCNNode], smallestDistance:Double){
//        for node in allNodes {
//            if (calculateDistance(finger: nodes.caixa, closestNode: node) < smallestDistance && calculateDistance(finger: nodes.caixa, closestNode: node) != 0 ){
//                smallestDistance = helpers.calculateDistance(finger: nodes.caixa, closestNode: node)
//            }
//        }
//        
//        print("acabou", smallestDistance)
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func DebugBoxPosition(rect:CGRect, VC:ViewController) -> CGRect {
        var x = VC.sceneView.frame.size.width * 1.62318 * rect.minX
        x = x - VC.sceneView.frame.size.width * 1.62318 * 0.1919
        let width = (rect.width * 1.6) * VC.sceneView.frame.size.width
        let height = rect.height * VC.sceneView.frame.size.height
        let y = VC.sceneView.frame.size.height * (1-rect.origin.y) - height
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    mutating func findX(x:CGFloat, width:CGFloat, depth:Double, VC:ViewController) -> CGFloat{
        var XfromCenter = VC.view.frame.size.width - (VC.view.frame.size.width - x - width/2)
        XfromCenter = XfromCenter -  VC.view.frame.size.width / 2
        fov = Double((VC.sceneView.pointOfView?.camera!.fieldOfView)!)
        // regra de 3 simples basicamente o bocado de ecra a partir do centro vezes o angulo total a dividir por metade da largura do ecra para saber o angulo que preciso usar
        var angleNeeded = XfromCenter * CGFloat(fov) / VC.view.frame.size.width/2
        //to radians
        angleNeeded = angleNeeded * .pi / 180
        //find missing side of triangle
        let newX =  CGFloat(depth) * tan(angleNeeded * -1)
        return newX
    }
    mutating func findY(y:CGFloat, height:CGFloat, depth:Double,VC:ViewController) -> CGFloat{
        var YfromCenter = VC.view.frame.size.height - (VC.view.frame.size.height - y - height/2)
        YfromCenter = YfromCenter -  VC.view.frame.size.height / 2
        
        fov = Double((VC.sceneView.pointOfView?.camera!.fieldOfView)!)
        // regra de 3 simples basicamente o bocado de ecra a partir do centro vezes o angulo total a dividir por metade da largura do ecra para saber o angulo que preciso usar
        var angleNeeded = YfromCenter * CGFloat(fov) / VC.view.frame.size.width/2
        //to radians
        angleNeeded = angleNeeded * .pi / 180
        //find missing side of triangle
        let newY =  CGFloat(depth) * tan(angleNeeded)
        return newY
    }
    
    func rotatePoint(X:CGFloat,Y:CGFloat,depth:Double, eulerX:Float, eulerY:Float) -> SCNVector3{
        
        //        // 1. primeiro digamos que roda sobre o eixo Y e temos novos X e Z
        //        let Xprime = X * cos(CGFloat(eulerY)) - CGFloat(depth) * sin(CGFloat(eulerY))
        //        var Zprime = CGFloat(depth) * cos(CGFloat(eulerY)) + X * sin(CGFloat(eulerY))
        //        // 2. vamos rodar sobre o eixo X e obter o Y e um novo Z
        //        let Yprime = Y * cos(CGFloat(eulerX)) - Zprime * sin(CGFloat(eulerX))
        //        Zprime = Zprime * cos(CGFloat(eulerX)) + Y * sin(CGFloat(eulerX))
        
        
        
        // 2. vamos rodar sobre o eixo X e obter o Y e um novo Z
        let Yprime = Y * cos(CGFloat(eulerX)) - CGFloat(depth) * sin(CGFloat(eulerX))
        var Zprime = CGFloat(depth) * cos(CGFloat(eulerX)) + Y * sin(CGFloat(eulerX))
        // 1. primeiro digamos que roda sobre o eixo Y e temos novos X e Z
        let Xprime = X * cos(CGFloat(eulerY)) - CGFloat(Zprime) * sin(CGFloat(eulerY))
        Zprime = CGFloat(Zprime) * cos(CGFloat(eulerY)) + X * sin(CGFloat(eulerY))
        
        
        
        
        return SCNVector3(Xprime, Yprime, Zprime)
    }
    
    
    
    //       https://www.techjini.com/blog/calculate-the-distance-to-object-from-camera/
    func getDepth(heightOfObject heightofObject:Double, focal f:Double, h height:CGFloat,resY Y:CGFloat, sensorSizeX sx:Double) -> Double{
        let primeiraParte = f * heightofObject * Double(Y)
        let segundaParte = Double(height*2) * sx
        var depth = primeiraParte / segundaParte  // ISTO É O MEU VALOR DO Z
        depth = Double(String(format: "%.2f", (depth / 1000) * -1))!
        return depth
    }
    
    func getTranslation(x:Float, y:Float,z:Float) -> SCNVector3 {
        let vector = SCNVector3(x,y,z)
        return vector
    }
    
    var colorIndex = 0
    
    let colors:[UIColor] = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.2210019827, green: 0.8249221444, blue: 0.8336370587, alpha: 1), #colorLiteral(red: 0, green: 0.7478390336, blue: 0.839841187, alpha: 1), #colorLiteral(red: 0, green: 0.7205649018, blue: 0.841629684, alpha: 1), #colorLiteral(red: 0, green: 0.6877613068, blue: 0.843809545, alpha: 1), #colorLiteral(red: 0, green: 0.6172472835, blue: 0.8478227258, alpha: 1), #colorLiteral(red: 0, green: 0.5689540505, blue: 0.8502634764, alpha: 1), #colorLiteral(red: 0, green: 0.4773241282, blue: 0.8541633487, alpha: 1), #colorLiteral(red: 0, green: 0.4162070155, blue: 0.8562235236, alpha: 1), #colorLiteral(red: 0, green: 0.3495996594, blue: 0.8580734134, alpha: 1) , #colorLiteral(red: 0, green: 0.2571569085, blue: 0.8599876761, alpha: 1) , #colorLiteral(red: 0, green: 0.06715125591, blue: 0.7841757536, alpha: 1) , #colorLiteral(red: 0.1866572201, green: 0, blue: 0.7734597921, alpha: 1) , #colorLiteral(red: 0.2629067898, green: 0, blue: 0.7731919885, alpha: 1) , #colorLiteral(red: 0.3138483167, green: 0, blue: 0.7729538083, alpha: 1) , #colorLiteral(red: 0.3630743027, green: 0, blue: 0.7726752162, alpha: 1) , #colorLiteral(red: 0.4003331065, green: 0, blue: 0.7724311948, alpha: 1) , #colorLiteral(red: 0.4957829714, green: 0, blue: 0.7716678977, alpha: 1) , #colorLiteral(red: 0.6226569414, green: 0, blue: 0.7703234553, alpha: 1) , #colorLiteral(red: 0.7328072786, green: 0, blue: 0.7688263059, alpha: 1) , #colorLiteral(red: 0.8123815656, green: 0, blue: 0.6861568689, alpha: 1) , #colorLiteral(red: 0.8123803735, green: 0, blue: 0.5575238466, alpha: 1) , #colorLiteral(red: 0.8123796582, green: 0, blue: 0.4564480186, alpha: 1) , #colorLiteral(red: 0.8123790622, green: 0, blue: 0.3335770667, alpha: 1) , #colorLiteral(red: 0.8123785257, green: 0, blue: 0.2310701907, alpha: 1) , #colorLiteral(red: 0.8123784661, green: 0, blue: 0.1085883155, alpha: 1) , #colorLiteral(red: 0.8123783469, green: 0, blue: 0, alpha: 1) , #colorLiteral(red: 0.8110035062, green: 0, blue: 0, alpha: 1) , #colorLiteral(red: 0.8064129949, green: 0.1758979261, blue: 0, alpha: 1) , #colorLiteral(red: 0.8002884388, green: 0.3023579717, blue: 0, alpha: 1) , #colorLiteral(red: 0.7933327556, green: 0.3940131664, blue: 0, alpha: 1) , #colorLiteral(red: 0.785833776, green: 0.4691120982, blue: 0, alpha: 1) , #colorLiteral(red: 0.7708009481, green: 0.5841504335, blue: 0, alpha: 1) , #colorLiteral(red: 0.8122467995, green: 0.6839380264, blue: 0, alpha: 1) , #colorLiteral(red: 0.8099620938, green: 0.696987927, blue: 0, alpha: 1) ,
                            #colorLiteral(red: 0.7688903213, green: 0.7681562901, blue: 0, alpha: 1) , #colorLiteral(red: 0.6959827542, green: 0.7712007165, blue: 0, alpha: 1) , #colorLiteral(red: 0.5798711181, green: 0.7743089199, blue: 0, alpha: 1) , #colorLiteral(red: 0.3731137514, green: 0.7781158686, blue: 0, alpha: 1) , #colorLiteral(red: 0, green: 0.7458351254, blue: 0, alpha: 1) , #colorLiteral(red: 0, green: 0.6255753636, blue: 0, alpha: 1) , #colorLiteral(red: 0, green: 0.626131475, blue: 0, alpha: 1) , #colorLiteral(red: 0, green: 0.7301662564, blue: 0.1975003183, alpha: 1) ,#colorLiteral(red: 0, green: 0.7301220298, blue: 0.3599385619, alpha: 1) , #colorLiteral(red: 0, green: 0.7300750613, blue: 0.463152051, alpha: 1) , #colorLiteral(red: 0, green: 0.7298617959, blue: 0.6170635223, alpha: 1) , #colorLiteral(red: 0, green: 0.7289603949, blue: 0.6999896169, alpha: 1)  ]
    
    var state = 0
    var r = 255.0
    var g = 0.0
    var b = 0.0
    var a = 255.0
    mutating func getColor() -> UIColor{
        
        
        if(state == 0){
            g += 1
            if(g == 255){
                state = 1
            }
        }
        if(state == 1){
            r -= 1
            if(r == 0){
                state = 2
            }
        }
        if(state == 2){
            b += 1
            if(b == 255){
                state = 3
            }
        }
        if(state == 3){
            g -= 1
            if(g == 0){
                state = 4
            }
        }
        if(state == 4){
            r += 1
            if(r == 255){
                state = 5
            }
            
        }
        if(state == 5){
            b -= 1;
            if(b == 0){
                state = 0
            }
        }
        
        return UIColor(red: CGFloat(r / 255), green: CGFloat(g / 255), blue: CGFloat(b / 255), alpha: 1)
        
        //        if(colorIndex == colors.count - 1){
        //           colorIndex = 0
        //        }else {
        //           colorIndex = colorIndex + 1
        //        }
        //        return colors[colorIndex]
        
    }
    
    
    
    
}


