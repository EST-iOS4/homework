//
//  TodoTableViewCell.swift
//  TodoGo
//
//  Created by 송영민 on 8/24/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
  static let reuseID = "TodoTableViewCell"
  
  var checkButton: UIButton!
  var titleLabel: UILabel!
  var priorityView: UIView!
  
  var onToggleComplete: (() -> Void)?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // 서브뷰 추가
    contentView.addSubview(checkButton)
    contentView.addSubview(titleLabel)
    contentView.addSubview(priorityView)
    
    // 기본 설정
    titleLabel.numberOfLines = 1
    priorityView.layer.cornerRadius = 6
    priorityView.clipsToBounds = true
  }
  
  required init?(coder: NSCoder) { super.init(coder: coder) }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let h = contentView.bounds.height
    checkButton.frame = CGRect(x: 16, y: (h-28)/2, width: 28, height: 28)
    priorityView.frame = CGRect(x: contentView.bounds.width - 16 - 12, y: (h-12)/2, width: 12, height: 12)
    titleLabel.frame = CGRect(x: checkButton.frame.maxX + 12,
                              y: 0,
                              width: priorityView.frame.minX - (checkButton.frame.maxX + 12) - 12,
                              height: h)
  }
  
  
  func configure(with todo: TodoItem) {
      if todo.isCompleted {
        titleLabel.textColor = .systemGray
        titleLabel.attributedText = strikethrough(text: todo.title)
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        checkButton.tintColor = .systemBlue
      } else {
        titleLabel.textColor = .label
        titleLabel.attributedText = NSAttributedString(string: todo.title)
        checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        checkButton.tintColor = .systemGray
      }

      priorityView.backgroundColor = todo.priority.color
    }

  
  func strikethrough(text: String) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
    return attributedString
  }
  
  @objc func toggleComplete() {
    onToggleComplete?()
  }
  
  //    override func setSelected(_ selected: Bool, animated: Bool) {
  //        super.setSelected(selected, animated: animated)
  //
  //        // Configure the view for the selected state
  //    }
  
}
