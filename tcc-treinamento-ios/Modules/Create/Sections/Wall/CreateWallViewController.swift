//
//  CreateWallViewController.swift
//  tcc-treinamento-ios
//
//  Created by Francisco Mossi on 29/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit
import ELCImagePickerController

let draggedViewIncreasedScale: CGFloat = 0.1
let minSize: CGFloat = 40
let perfectHorizontalPinch: CGFloat = 1000
let perfectVerticalPinch: CGFloat = 0

class CreateWallViewController: UIViewController, ELCImagePickerControllerDelegate {
    func elcImagePickerController(_ picker: ELCImagePickerController!, didFinishPickingMediaWithInfo info: [Any]!) {
        
    }
    
    func elcImagePickerControllerDidCancel(_ picker: ELCImagePickerController!) {
        
    }
    
    var panGestureEnabled = false
    
    var imagePicker: ImagePicker!
    var picker = ELCImagePickerController()
    
    @IBAction func addView(_ sender: UIButton) {
//        self.imagePicker.present(from: sender)
        self.present(self.picker, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        
//        picker.maximumImagesCount = 5
//        picker.imagePickerDelegate = self
//        self.present(self.picker, animated: true, completion: nil)
//
//    }
    
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
        recognizer.scale = 1.0
    }
    
    @objc func handlePan(recognizer:  UIPanGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
        if panGestureEnabled {
            let translation = recognizer.translation(in: view)
            recognizerView.center.x += translation.x
            recognizerView.center.y += translation.y
            recognizer.setTranslation(.zero, in: view)
        }
    }
    
    @objc func handleLongPress(recognizer:  UILongPressGestureRecognizer) {
        guard let recognizerView = recognizer.view else {
            return
        }
        
        switch recognizer.state {
        case .began:
            setProportion(of: recognizerView, by: 1 + draggedViewIncreasedScale)
            applyShadow(to: recognizerView)
            panGestureEnabled = true
        case .ended:
            setProportion(of: recognizerView, by: 1 - draggedViewIncreasedScale)
            removeShadow(from: recognizerView)
            panGestureEnabled = false
        default:
            break
        }
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
    
    private func removeShadow(from view: UIView) {
        view.layer.shadowOpacity = 0
    }
    
    private func setProportion(of view: UIView, by increaseValue: CGFloat) {
        view.transform = view.transform.scaledBy(x: increaseValue, y: increaseValue)
    }
    
    private func createView(_ image: UIImage?) -> UIView {
        if let pickedImage = image {
            let imageSize = pickedImage.size
            let widthProportion = imageSize.height/imageSize.width
            
            let wrapperView = UIView(frame: .init(origin: .init(x: 50, y: 380), size: .init(width: 300, height: 300 * widthProportion)))

            let imageView = UIImageView(image: pickedImage)
            imageView.fixInView(wrapperView)
            
            wrapperView.layer.shadowColor = UIColor.black.cgColor
            wrapperView.layer.shadowOffset = .zero
            wrapperView.layer.shadowRadius = 5
            wrapperView.layer.shouldRasterize = true
            wrapperView.layer.rasterizationScale = UIScreen.main.scale

            view.addSubview(wrapperView)
            
            return wrapperView
        }
        
        return UIView()
    }
}

extension CreateWallViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        let view = createView(image)
        self.addGestures(to: view)
    }
}

extension CreateWallViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if !view.subviews.contains(gestureRecognizer.view ?? UIView()) {
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
