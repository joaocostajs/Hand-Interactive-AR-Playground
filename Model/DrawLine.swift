//
//  DrawLine.swift
//  Hand Interactive AR Playground
//
//  Created by João Costa on 18/06/2020.
//  Copyright © 2020 João Costa. All rights reserved.
//

import Foundation
import SceneKit


struct DrawLine{
    
    
    
    
    
    
    func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
           
           let indices: [Int32] = [0, 1]
           
           let source = SCNGeometrySource(vertices: [vector1, vector2])
           let element = SCNGeometryElement(indices: indices, primitiveType: .line)
           
           return SCNGeometry(sources: [source], elements: [element])
       }
    
}
