//
//  ARViewController.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 06/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var grids = [Grid]()
    var pictures = [Picture]()
    var image: UIImage? = nil
    let requestMaker = RequestMaker()
    
    @IBAction func takeScreenshot(_ sender: Any) {
        let screenshot = self.sceneView.takeScreenshot()
        
        let printView = UIView(frame: UIScreen.main.bounds)
        printView.backgroundColor = .white
        
        self.requestMaker.uploadImage(with: screenshot, into: .walls)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let scene = SCNScene()
        
        sceneView.scene = scene
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @objc func tapped(gesture: UITapGestureRecognizer) {
        // Get 2D position of touch event on screen
        let touchPosition = gesture.location(in: sceneView)
        
        // Translate those 2D points to 3D points using hitTest (existing plane)
        let hitTestResults = sceneView.hitTest(touchPosition, types: .existingPlaneUsingExtent)
        
        // Get hitTest results and ensure that the hitTest corresponds to a grid that has been placed on a wall
        guard let hitTest = hitTestResults.first, let anchor = hitTest.anchor as? ARPlaneAnchor, let gridIndex = grids.index(where: { $0.anchor == anchor }) else {
            return
        }
        addPainting(hitTest, grids[gridIndex])
    }
    
    func addPainting(_ hitResult: ARHitTestResult, _ grid: Grid) {
        if let image = self.image {
            let imageSize = 0.5 as CGFloat
            
            let imageWidth = image.size.width
            let imageProportion = image.size.height/imageWidth
            let imageHeight = imageSize * imageProportion
            // 1.
            let planeGeometry = SCNPlane(width: imageSize, height: imageHeight)
            let material = SCNMaterial()
            material.diffuse.contents = self.image
            planeGeometry.materials = [material]
            
            // 2.
            let paintingNode = SCNNode(geometry: planeGeometry)
            paintingNode.transform = SCNMatrix4(hitResult.anchor!.transform)
            paintingNode.eulerAngles = SCNVector3(paintingNode.eulerAngles.x + (-Float.pi / 2), paintingNode.eulerAngles.y, paintingNode.eulerAngles.z)
            paintingNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
            
            sceneView.scene.rootNode.addChildNode(paintingNode)
            grid.removeFromParentNode()
        }
    }
}


extension ARViewController: UICollectionViewDelegate {}

extension ARViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ARSelectedImages", for: indexPath)
        let picture = self.pictures[indexPath.row]
        
        if let pictureCell = cell as? PicturesCollectionViewCell {
            pictureCell.configCell(with: picture)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: indexPath) as? PicturesCollectionViewCell {
            self.image = cell.imageView.image
        }
    }
}

extension ARViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.height
        return CGSize(width:collectionViewSize, height: collectionViewSize)
    }
}

extension ARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = Grid(anchor: planeAnchor)
        self.grids.append(grid)
        node.addChildNode(grid)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }
        let grid = self.grids.filter { grid in
            return grid.anchor.identifier == planeAnchor.identifier
            }.first
        
        guard let foundGrid = grid else {
            return
        }
        
        foundGrid.update(anchor: planeAnchor)
    }
}
