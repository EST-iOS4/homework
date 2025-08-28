//
//  ViewController.swift
//  ModalPresentation
//
//  Created by 송영민 on 8/28/25.
//

import UIKit

class ViewController: UIViewController {

    var recieveData: String = "새 항목 추가"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Modal Presentation"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
      var config = UIButton.Configuration.filled()
      config.title = recieveData
      
      let button = UIButton(configuration: config)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
      view.addSubview(button)
      
      NSLayoutConstraint.activate([
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        button.widthAnchor.constraint(equalToConstant: 150),
        button.heightAnchor.constraint(equalToConstant: 50)
      ])
  }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let modalVC = ModalViewController()
//        modalVC.modalPresentationStyle = .pageSheet
        modalVC.data = "TEST"
//        modalVC.parentVC = self
        modalVC.delegate = self
        modalVC.modalPresentationStyle = .popover
        
//       if let sheet = modalVC.sheetPresentationController {
//            sheet.detents = [.medium(), .large()]
//            sheet.prefersGrabberVisible = true
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
         
        if let popover = modalVC.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
            popover.permittedArrowDirections = .left
         
        }
        present(modalVC, animated: true)
    }
}

extension ViewController: SendDataDelegate {
    func sendData(_ data: String) {
        recieveData = data
        setupUI()
    }
}

