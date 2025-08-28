//
//  ViewController.swift
//  SignUpForm-test
//
//  Created by 송영민 on 8/21/25.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
  
  @IBOutlet weak var contentLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    filterSegmentedControl.removeAllSegments()
    filterSegmentedControl.insertSegment(withTitle: "전체", at: 0, animated: false)
    filterSegmentedControl.insertSegment(withTitle: "즐겨찾기", at: 1, animated: false)
    filterSegmentedControl.insertSegment(withTitle: "최근", at: 2, animated: false)
    
    filterSegmentedControl.selectedSegmentIndex = 0
    filterSegmentedControl.addTarget(self, action: #selector(segmentChagned), for: .valueChanged)
    updateContent()
  }
  
  @objc func segmentChagned(_ sender: UISegmentedControl) {
    updateContent()
  }

  func updateContent() {
    switch filterSegmentedControl.selectedSegmentIndex {
    case 0:
      contentLabel.text = "전체 항목을 표시합니다."
    case 1:
      contentLabel.text = "즐겨찾기 창목만 표시합니다."
    case 2:
      contentLabel.text = "최근 항목만 표시합니다."
    default :
      break
    }
  }
  
}

