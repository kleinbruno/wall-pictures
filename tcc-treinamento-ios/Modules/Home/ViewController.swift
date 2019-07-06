//
//  ViewController.swift
//  tcc-treinamento-ios
//
//  Created by Luan Winck on 22/06/19.
//  Copyright © 2019 CWI software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var creationsTab: TabItemView!
    @IBOutlet weak var configTab: TabItemView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addModal: UIView!
    @IBOutlet weak var addModalTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonsBottomConstraint: NSLayoutConstraint!
    
    var currentTab: TabItemView? = nil
    
    var currentViewController: UIViewController? = nil
    var addModalVisible = false
    
    @IBAction func handleAdd(_ sender: UIButton) {
        var rotation: CGAffineTransform = .identity
        
        self.addModal.isHidden = false
        
        if !addModalVisible {
            let quarter = CGFloat(Double.pi/4)
            rotation = CGAffineTransform(rotationAngle: quarter)
        }
        
        let tabbarPadding: CGFloat = 80
        var topConstraintValue: CGFloat = 0
        var buttonsBottomConstraintValue: CGFloat = 60
        
        if self.addModalVisible {
            topConstraintValue = UIScreen.main.bounds.height - tabbarPadding
            buttonsBottomConstraintValue = -250
        }
        
        self.addModalTopConstraint.constant = topConstraintValue
        self.buttonsBottomConstraint.constant = buttonsBottomConstraintValue
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            self.addButton.transform = rotation
            self.addModal.alpha = self.addModalVisible ? 0 : 1
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.addModalVisible = !self.addModalVisible
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.creationsTab.selected = true
        self.configAddButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let creations = TabItemEnum.creations
        let config = TabItemEnum.config
        
        self.creationsTab.config(label: creations.label, image: UIImage(named: creations.image))
        self.addTapGesture(to: creations)

        self.configTab.config(label: config.label, image: UIImage(named: config.image))
        self.addTapGesture(to: config)
        
        setViewController(ofType: .creations)
    }
    
    func setViewController(ofType type: TabItemEnum) {
        let selectedView = getView(ofType: type)
        
        if selectedView != self.currentTab {
            if let currentController = self.currentViewController {
                currentController.willMove(toParent: nil)
                currentController.view.removeFromSuperview()
                currentController.removeFromParent()
            }
            
            let viewController = type.viewController
            addChild(viewController)
            
            viewController.view.frame = self.contentView.bounds
            contentView.addSubview(viewController.view)
            
            viewController.didMove(toParent: self)
            self.currentViewController = viewController
        }
        
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        self.creationsTab.selected = false
        self.configTab.selected = false
        
        if let view = recognizer.view as? TabItemView {
            view.selected = true
            
            if let viewType = getViewType(view) {
                self.setViewController(ofType: viewType)
            }
            
            self.currentTab = view
        }
    }
    
    func addTapGesture(to viewType: TabItemEnum) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        tapGesture.delegate = self
        
        let tapView = self.getView(ofType: viewType)
        tapView.addGestureRecognizer(tapGesture)
    }
    
    func configAddButton() {
        self.addButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.addButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.addButton.layer.shadowOpacity = 1.0
        self.addButton.layer.shadowRadius = 5
        self.addButton.layer.masksToBounds = false
    }
    
    func getView(ofType item: TabItemEnum) -> TabItemView {
        switch item {
            case .creations:
                return self.creationsTab
            case .config:
                return self.configTab
        }
    }
    
    func getViewType(_ view: TabItemView) -> TabItemEnum? {
        switch view {
            case self.creationsTab:
                return .creations
            case self.configTab:
                return .config
            default:
                return nil
        }
    }
    
    enum TabItemEnum {
        case creations
        case config
        
        var label: String {
            switch self {
            case .creations:
                return "criações"
            case .config:
                return "configurações"
            }
        }
        
        var image: String {
            switch self {
            case .creations:
                return "ic_albums"
            case .config:
                return "ic_settings"
            }
        }
        
        var viewController: UIViewController {
            switch self {
                case .creations:
                    return MyCreationsNavigationController.instantiate(fromAppStoryboard: .MyCreations)
                case .config:
                    return ConfigurationViewController.instantiate(fromAppStoryboard: .Configurations)
            }
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {}
