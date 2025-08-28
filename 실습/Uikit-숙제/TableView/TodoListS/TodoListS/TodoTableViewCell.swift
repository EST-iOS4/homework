//
//  TodoTableViewCell.swift
//  TodoListS
//
//  Created by 송영민 on 8/25/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
  @IBOutlet weak var checkButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var priorityView: UIView!
  
  var onToggleComplete: (() -> Void)?
  //스토리 보드에서 불렸을 때, Identifier을 불렀을 때
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    priorityView.layer.cornerRadius = 4
    //self 는 cell 하나하나
    checkButton
      .addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.attributedText = nil
    priorityView.backgroundColor = .clear
    checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
  }
  
  func configure(with todo: TodoItem) {
    titleLabel.textColor = todo.isCompleted ? .systemGray : .label
    titleLabel.attributedText = todo.isCompleted ? strikeThrough(
      text: todo.title
    ) : NSAttributedString(string: todo.title)
    //titleLabel.text = todo.title
    
    checkButton
      .setImage(
        UIImage(
          systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle"
        ),
        for: .normal
      )
    checkButton.tintColor = todo.isCompleted ? .systemBlue : .systemGray
    
    priorityView.backgroundColor = todo.priority.color
  }
  
  func strikeThrough(text: String) -> NSAttributedString {
    let attributeString = NSMutableAttributedString(string: text)
    attributeString
      .addAttribute(
        .strikethroughStyle,
        value: NSUnderlineStyle.single.rawValue,
        range: NSRange(location: 0, length: text.count)
      )
    return attributeString
  }
  
  @objc func toggleComplete() {
    onToggleComplete?()
  }
  
}
