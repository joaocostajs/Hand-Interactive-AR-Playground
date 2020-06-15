//
//  ViewController.swift
//  Hand Interactive AR Playground
//
//  Created by João Costa on 08/06/2020.
//  Copyright © 2020 João Costa. All rights reserved.
//


import UIKit
import SceneKit
import ARKit
import Vision
import CoreML
import Foundation
import AVFoundation
import AudioToolbox


enum BitMaskCategory: Int {
    case finger = 4
    case button = 8
    case box1 = 10
    case pyra = 2
    case C = 3
    case d3 = 5
    case e3 = 6
    case f3 = 7
    case g3 = 9
}

class ViewController: UIViewController, ARSCNViewDelegate,SCNSceneRendererDelegate, ARSessionDelegate,AVCaptureVideoDataOutputSampleBufferDelegate, SCNPhysicsContactDelegate{
    
    @IBOutlet var movementLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    var index = 0
    var helpers = Helpers()
    var boxDebug = Box()
    let nodes = Nodes()
    var touchmanager = TouchManager()
    let playground = SCNScene(named: "art.scnassets/playground.scn")!
    
    var startButton:SCNNode = SCNNode()
    var box1 = SCNNode()
    var geosphere = SCNNode()
    var bNode = SCNNode()
    var pyra = SCNNode()
    var C = SCNNode()
    var d3 = SCNNode()
    var e3 = SCNNode()
    var f3 = SCNNode()
    var g3 = SCNNode()
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
//        sceneView.debugOptions = .showPhysicsShapes
        sceneView.scene.physicsWorld.contactDelegate = self
        sceneView.scene.physicsWorld.timeStep = 1/60
//        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
       
        
         var detectionTimer = Timer.scheduledTimer(timeInterval: 0.0166, target: self, selector: #selector(ViewController.startDetection), userInfo: nil, repeats: true)
        
        
        startButton = playground.rootNode.childNode(withName: "startButton", recursively: true)!
        startButton.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.4 , height: 0.4, length: 0.2, chamferRadius: 0)))
        startButton.physicsBody?.categoryBitMask = BitMaskCategory.button.rawValue
        startButton.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
        sceneView.scene.rootNode.addChildNode( startButton)
        
     
        box1 = playground.rootNode.childNode(withName: "box1", recursively: true)!
        box1.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.25 , height: 0.25, length: 0.25, chamferRadius: 0)))
        box1.geometry?.firstMaterial?.specular.contents = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        box1.physicsBody?.categoryBitMask = BitMaskCategory.box1.rawValue
              box1.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
        sceneView.scene.rootNode.addChildNode(box1)
        
        pyra = playground.rootNode.childNode(withName: "pyramid", recursively: true)!
        pyra.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNPyramid(width: 0.5, height: 0.5, length: 0.5) ))
        pyra.physicsBody?.categoryBitMask = BitMaskCategory.pyra.rawValue
        pyra.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
        sceneView.scene.rootNode.addChildNode(pyra)
        
        C = playground.rootNode.childNode(withName: "c3", recursively: true)!
             C.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.2, chamferRadius: 0) ))
             C.physicsBody?.categoryBitMask = BitMaskCategory.C.rawValue
             C.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
             sceneView.scene.rootNode.addChildNode(C)
        
        d3 = playground.rootNode.childNode(withName: "d3", recursively: true)!
        d3.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.2, chamferRadius: 0) ))
        d3.physicsBody?.categoryBitMask = BitMaskCategory.d3.rawValue
        d3.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
        sceneView.scene.rootNode.addChildNode(d3)
        
        e3 = playground.rootNode.childNode(withName: "e3", recursively: true)!
               e3.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.2, chamferRadius: 0) ))
               e3.physicsBody?.categoryBitMask = BitMaskCategory.e3.rawValue
               e3.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
               sceneView.scene.rootNode.addChildNode(e3)
        
        f3 = playground.rootNode.childNode(withName: "f3", recursively: true)!
               f3.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.2, chamferRadius: 0) ))
               f3.physicsBody?.categoryBitMask = BitMaskCategory.f3.rawValue
               f3.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
               sceneView.scene.rootNode.addChildNode(f3)
        
        g3 = playground.rootNode.childNode(withName: "g3", recursively: true)!
               g3.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.2, chamferRadius: 0) ))
               g3.physicsBody?.categoryBitMask = BitMaskCategory.g3.rawValue
               g3.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
               sceneView.scene.rootNode.addChildNode(g3)
        
        geosphere = playground.rootNode.childNode(withName: "geosphere", recursively: true)!
            geosphere.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNSphere(radius: 0.15)))
            geosphere.physicsBody?.categoryBitMask = BitMaskCategory.box1.rawValue
                  geosphere.physicsBody?.contactTestBitMask = BitMaskCategory.finger.rawValue
            sceneView.scene.rootNode.addChildNode(geosphere)
        
        
        bNode = startButton
        sceneView.scene.rootNode.addChildNode(bNode)
        
        nodes.caixa.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.02, height: 0.02, length: 0.02, chamferRadius: 0.01)))
        nodes.caixa.physicsBody?.categoryBitMask = BitMaskCategory.finger.rawValue
        nodes.caixa.physicsBody?.contactTestBitMask = BitMaskCategory.button.rawValue
        
        self.sceneView.scene.rootNode.addChildNode(nodes.caixa)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // We want to receive the frames from the video
        sceneView.session.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        // Run the view's session
        sceneView.session.run(configuration)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.togglePeopleOcclusion()
        })
       
    }
    fileprivate func togglePeopleOcclusion() {
          guard let config = sceneView.session.configuration as? ARWorldTrackingConfiguration else {
              fatalError("Unexpectedly failed to get the configuration.")
          }
          guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
              fatalError("People occlusion is not supported on this device.")
          }
          switch config.frameSemantics {
          case [.personSegmentationWithDepth]:
              config.frameSemantics.remove(.personSegmentationWithDepth)
              
          default:
              config.frameSemantics.insert(.personSegmentationWithDepth)
              
          }
          sceneView.session.run(config)
      }
    
//    var bNodeBool = false
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.nodeA.physicsBody?.categoryBitMask == 4 {
            bNode = contact.nodeB
        }else {
            bNode = contact.nodeA
        }
     
      
    }

      var eulerX:Float = 0
    var eulerY:Float = 0
    var currentBuffer: CVPixelBuffer?
    
//    https://stackoverflow.com/questions/45084187/arkit-get-current-position-of-arcamera-in-a-scene
    
    
    func session(_: ARSession, didUpdate frame: ARFrame) {
        eulerY = frame.camera.eulerAngles.y * -1
        eulerX = frame.camera.eulerAngles.x
        currentBuffer = frame.capturedImage
       
//        startDetection()
    }
    
 
    let visionQueue = DispatchQueue(label: "joao.visionQueue")
    
    private lazy var predictionRequest: VNCoreMLRequest = {
        // Load the ML model through its generated class and create a Vision request for it.
        do {
            let model = try VNCoreMLModel(for: Hand().model)
            let request = VNCoreMLRequest(model: model)
            
            // This setting determines if images are scaled or cropped to fit our 224x224 input size. Here we try scaleFill so we don't cut part of the image.
            request.imageCropAndScaleOption = .scaleFill
            
            return request
        } catch {
            fatalError("can't load Vision ML model: \(error)")
        }
    }()
    
    var obs:AnyObject?

    @objc private func startDetection() {
            // Here we will do our CoreML request on currentBuffer
            
            guard let buffer = currentBuffer else { return }
         
            // Right orientation because the pixel data for image captured by an iOS device is encoded in the camera sensor's native landscape orientation
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: buffer, orientation: .right)
           
            // We perform our CoreML Requests asynchronously.
            visionQueue.async {
                // Run our CoreML Request
                try? requestHandler.perform([self.predictionRequest])
                
                guard let results = self.predictionRequest.results else {
                    fatalError("Unexpected result type from VNCoreMLRequest")
                }
               
                DispatchQueue.main.async {
                    for observation in results where observation is VNRecognizedObjectObservation {
                        guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                            continue
                        }
                        let topLabelObservation = objectObservation.labels[0].identifier
                        let confidence = objectObservation.confidence
                        if confidence > 0.65 {
                             if topLabelObservation == "Index" {
                    //                            este f value nao esta correto mas assim a app funciona bem
                                                let f = 8.25
                                                let resY = self.view.frame.height
                                                let sensorSizeX = 5.76
                                                
                                                self.obs = objectObservation
                                                let rect = objectObservation.boundingBox
                                                
                                                self.boxDebug.MakeBox()
                                                let debugBoxPosition = self.helpers.DebugBoxPosition(rect: rect, VC:self)
                                                self.boxDebug.redView.frame = CGRect(x:debugBoxPosition.minX, y: debugBoxPosition.minY, width: debugBoxPosition.width, height: debugBoxPosition.height)
                                                self.view.addSubview(self.boxDebug.redView)
                                                
                                                let depth = self.helpers.getDepth(heightOfObject: 35.0, focal: f, h: debugBoxPosition.height, resY: resY, sensorSizeX: sensorSizeX)
                                                let translate = self.helpers.getTranslation(x: self.sceneView.pointOfView!.position.x, y: self.sceneView.pointOfView!.position.y, z: self.sceneView.pointOfView!.position.z)
                                                
                                                let X = self.helpers.findX(x:debugBoxPosition.minX, width:debugBoxPosition.width, depth:depth,VC:self)
                                                let Y = self.helpers.findY(y:debugBoxPosition.minY, height:debugBoxPosition.height, depth:depth,VC:self)
                                                
                                                let rotatedPoint = self.helpers.rotatePoint(X: X,Y: Y,depth: depth,eulerX: self.eulerX,eulerY: self.eulerY)
                                                let join = SCNVector3(rotatedPoint.x + translate.x,rotatedPoint.y + translate.y,rotatedPoint.z + translate.z)

                                                self.nodes.caixa.geometry?.firstMaterial?.diffuse.contents = self.helpers.getColor()
                                                self.nodes.caixa.position = SCNVector3(join.x, join.y, join.z)
                                             
                                                self.sceneView.scene.rootNode.addChildNode(self.nodes.caixa)
                                                
                                                   self.touchmanager.touchBegan(nodeA: self.nodes.caixa, nodeB: self.bNode, physicsWorld: self.sceneView.scene.physicsWorld)
                                

                                               
                                            }
                        }
                    }
                }
                // Release currentBuffer to allow processing next frame
                self.currentBuffer = nil
                
            }
      
        }
    
  
}


