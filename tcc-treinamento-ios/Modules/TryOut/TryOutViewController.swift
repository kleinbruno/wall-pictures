//
//  TryOutViewController.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 04/07/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit
import CULColorPicker

class TryOutViewController: UIViewController, ColorPickerViewDelegate {
    func colorPickerWillBeginDragging(_ colorPicker: ColorPickerView) {
        
    }
    
    func colorPickerDidEndDagging(_ colorPicker: ColorPickerView) {
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wallView: UIView!
    @IBOutlet weak var collectionBackgroundView: UIView!
    @IBOutlet weak var colorPicker: ColorPickerView!
    let requestMaker = RequestMaker()
    
    let draggedViewIncreasedScale: CGFloat = 0.1
    let minSize: CGFloat = 40
    let perfectHorizontalPinch: CGFloat = 1000
    let perfectVerticalPinch: CGFloat = 0
    
    var panGestureEnabled = false
    
    var pictures: [Picture] = []
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func takeScreenshot(_ sender: Any) {
        let screenshot = self.wallView.takeScreenshot()
        
        let printView = UIView(frame: UIScreen.main.bounds)
        printView.backgroundColor = .white
        self.view.addSubview(printView)
        
        self.requestMaker.uploadImage(with: screenshot, into: .walls, onSuccess: {
            UIView.animate(withDuration: 0.2, animations: {
                printView.alpha = 0
            }, completion: {
                (Bool) in
                printView.removeFromSuperview()
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colorPicker?.delegate = self

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.dragDelegate = self
        self.collectionView.dragInteractionEnabled = true
        
        let dropInteraction = UIDropInteraction(delegate: self)
        self.wallView.addInteraction(dropInteraction)
    }
    
    func colorPickerDidSelectColor(_ colorPicker: ColorPickerView) {
        // Can get the selected color from the color picker
        wallView.backgroundColor = colorPicker.selectedColor
    }
    
    func addGestures(to view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        longPressGesture.minimumPressDuration = 0
        longPressGesture.delegate = self
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
        view.addGestureRecognizer(longPressGesture)
        view.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePan(recognizer:  UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
        if panGestureEnabled {
            let translation = recognizer.translation(in: self.wallView)
            recognizerView.center.x += translation.x
            recognizerView.center.y += translation.y
            recognizer.setTranslation(.zero, in: self.wallView)
        }
    }
    
    @objc func handleLongPress(recognizer:  UILongPressGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
        switch recognizer.state {
        case .began:
            panGestureEnabled = true
        case .ended:
            panGestureEnabled = false
        default:
            break
        }
    }
    
    @objc func handlePinch(recognizer:  UIPinchGestureRecognizer) {
        guard let recognizerView = recognizer.view, recognizer.state == .began || recognizer.state == .changed else {
            return
        }
        
        var directionValue: CGFloat = 0
        
        let firstTouch = recognizer.location(ofTouch: 0, in: recognizerView)
        let secondTouch = recognizer.location(ofTouch: 1, in: recognizerView)
        
        if firstTouch.x == secondTouch.x {
            directionValue = perfectHorizontalPinch
        } else if firstTouch.y == secondTouch.y {
            directionValue = perfectVerticalPinch
        } else {
            directionValue = calcDirectionBetween(locationOne: firstTouch, locationTwo: secondTouch)
        }
        
        if directionValue < 0 {
            directionValue *= -1
        }
        
        let viewFrame = recognizerView.frame
        
        var nextWidth = viewFrame.width
        var nextHeight = viewFrame.height
        
        let direction = getDirection(directionValue)
        
        switch direction {
        case .horizontal:
            nextWidth = nextWidth * recognizer.scale
        case .vertical:
            nextHeight = nextHeight * recognizer.scale
        case .diagonal:
            nextWidth = nextWidth * recognizer.scale
            nextHeight = nextHeight * recognizer.scale
        }
        
        let viewOrigin = viewFrame.origin
        
        if nextWidth < minSize {
            nextWidth = minSize
        }
        
        if nextHeight < minSize {
            nextHeight = minSize
        }
        
        let widthDiff = (nextWidth - viewFrame.width)/2
        let heightDiff = (nextHeight - viewFrame.height)/2
        
        recognizerView.frame = CGRect(x: viewOrigin.x - widthDiff, y: viewOrigin.y - heightDiff, width: nextWidth, height: nextHeight)
        self.applyShadow(to: recognizerView)
        recognizer.scale = 1.0
    }
    
    private func getDirection(_ value: CGFloat) -> Direction {
        if value < 0.5 {
            return .horizontal
        } else if value > 1.7 {
            return .vertical
        } else {
            return .diagonal
        }
    }
    
    private func calcDirectionBetween(locationOne firstTouch: CGPoint, locationTwo secondTouch: CGPoint) -> CGFloat {
        return (secondTouch.y - firstTouch.y)/(secondTouch.x - firstTouch.x)
    }
    
    private func applyShadow(to view: UIView) {
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowOpacity = 1
    }
}

extension TryOutViewController: UICollectionViewDelegate {}

extension TryOutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedImages", for: indexPath)
        let picture = self.pictures[indexPath.row]
        
        if let pictureCell = cell as? PicturesCollectionViewCell {
            pictureCell.configCell(with: picture)
        }
        
        return cell
    }
}

extension TryOutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.height
        return CGSize(width:collectionViewSize, height: collectionViewSize)
    }
}

extension TryOutViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedImages", for: indexPath) as? PicturesCollectionViewCell
        
        if let pictureCell = cell {
            let itemProvider = NSItemProvider(object: pictureCell.imageView!.image! as NSItemProviderWriting)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = indexPath
            return [dragItem]
        }
        
        return []
    }
}

extension TryOutViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: self.wallView)
    
        var operation = UIDropOperation.cancel
        
        if wallView.frame.contains(dropLocation) {
            operation = .move
        }
        
        return UIDropProposal(operation: operation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        let dropLocation = session.location(in: self.wallView)
        if let cellIndex = session.items[0].localObject as? IndexPath {
            if let cell = self.collectionView.cellForItem(at: cellIndex) as? PicturesCollectionViewCell {
                
                let imageSize = 200 as CGFloat
                let image = cell.imageView!.image!
                let imageWidth = image.size.width
                let imageProportion = image.size.height/imageWidth
                
                let imageHeight = imageSize * imageProportion
                
                let pictureView = PictureView(frame: .init(origin: .init(x: dropLocation.x - imageSize/2, y: dropLocation.y - imageHeight/2), size: .init(width: imageSize, height: imageHeight)))
                
                let picture = pictureView.getPicture(with: cell.imageView!.image!)
                self.addGestures(to: picture)
                
                self.wallView.addSubview(picture)
                
                self.pictures.remove(at: cellIndex.row)
                self.collectionView.deleteItems(at: [cellIndex])
                self.collectionView.reloadData()
                
                if self.pictures.count == 0 {
                    self.collectionView.isHidden = true
                    self.collectionBackgroundView.isHidden = true
                }
            }
        }
    }
}

extension TryOutViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if !self.wallView.subviews.contains(gestureRecognizer.view ?? UIView()) {
            return false
        }
        
        if gestureRecognizer.view != otherGestureRecognizer.view {
            return false
        }
        
        if gestureRecognizer is UILongPressGestureRecognizer &&
            otherGestureRecognizer is UIPanGestureRecognizer {
            return true
        }
        
        return false
    }
}

enum Direction {
    case horizontal
    case vertical
    case diagonal
}
