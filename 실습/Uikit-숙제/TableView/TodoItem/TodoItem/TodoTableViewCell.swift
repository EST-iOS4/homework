//
//  TodoTableViewCell.swift
//  TodoItem
//
//  Created by 송영민 on 8/25/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

  var checkButton: UIButton!
  var titleLabel: UILabel!
  var priorityView: UIView!

  var onToggleComplete: (() -> Void)?

  static let reuseID = "TodoTableViewCell"

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    priorityView?.layer.cornerRadius = 4
    checkButton?.addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
  }

  private func setupUI() {
    selectionStyle = .none
    contentView.backgroundColor = .systemBackground
    priorityView = UIView(frame: CGRect(x: 16, y: 18, width: 12, height: 12))
    priorityView.layer.cornerRadius = 4
    priorityView.layer.masksToBounds = true
    contentView.addSubview(priorityView)
    titleLabel = UILabel(frame: CGRect(x: 16 + 12 + 10, y: 12, width: UIScreen.main.bounds.width - 16 - 12 - 10 - 44 - 16, height: 24))
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    titleLabel.textColor = .label
    contentView.addSubview(titleLabel)
    let buttonSize: CGFloat = 28
    checkButton = UIButton(type: .system)
    checkButton.frame = CGRect(x: UIScreen.main.bounds.width - 16 - buttonSize, y: 10, width: buttonSize, height: buttonSize)
    checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
    checkButton.tintColor = .systemGray
    checkButton.addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
    contentView.addSubview(checkButton)
  }

  func configure(with todo: TodoItem) {
    titleLabel.textColor = todo.isCompleted ? .systemGray : .label
    titleLabel.attributedText = todo.isCompleted ? strikethrough(text: todo.title) : NSAttributedString(string: todo.title)
    checkButton.setImage(UIImage(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
    checkButton.tintColor = todo.isCompleted ? .systemBlue : .systemGray
    priorityView.backgroundColor = todo.priority.color
  }

  
  func strikethrough(text: String) -> NSAttributedString {
    let attr = NSMutableAttributedString(string: text)
    attr.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
    return attr
  }

  @objc func toggleComplete() {
    onToggleComplete?()
  }
}
