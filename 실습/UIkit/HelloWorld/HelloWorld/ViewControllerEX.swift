//
//  ViewControllerEX.swift
//  HelloWorld
//
//  Created by 송영민 on 8/21/25.
//

import UIKit

class ViewControllerEX: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      titleLabel.text = "UILabel 마스터하기"
      descriptionLabel.text = """
            Hello, UIKit! UILabel은 iOS 앱에서 텍스트를 표시하는 기본적인 방법입니다.
            Discriminating between different text styles, colors, and alignments is essential for creating a visually appealing interface.
            """
      
      
      titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
      descriptionLabel.font = UIFont(name: "Helvetica", size: 16)
      
      titleLabel.textColor = .systemBlue
      descriptionLabel.textColor = .darkGray
      
      titleLabel.textAlignment = .center
      descriptionLabel.textAlignment = .left
      
      descriptionLabel.numberOfLines = 0
      descriptionLabel.lineBreakMode = .byWordWrapping

    
      }

}
