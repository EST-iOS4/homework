//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by 송영민 on 8/22/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

  let checkButton = UIButton(type: .system)
  let titleLabel = UILabel()
  let priorityView = UIView()

  var onToggleComplete: (() -> Void)?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    // 우선순위 표시 뷰 (작은 색 바)
    priorityView.translatesAutoresizingMaskIntoConstraints = false
    priorityView.layer.cornerRadius = 3
    contentView.addSubview(priorityView)

    // 체크 버튼
    checkButton.translatesAutoresizingMaskIntoConstraints = false
    checkButton.addTarget(self, action: #selector(toggleComplete), for: .touchUpInside)
    contentView.addSubview(checkButton)

    // 제목 라벨
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 1
    contentView.addSubview(titleLabel)

    // 제약
    NSLayoutConstraint.activate([
      priorityView.widthAnchor.constraint(equalToConstant: 6),
      priorityView.heightAnchor.constraint(equalToConstant: 24),
      priorityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      priorityView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

      checkButton.leadingAnchor.constraint(equalTo: priorityView.trailingAnchor, constant: 12),
      checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      checkButton.widthAnchor.constraint(equalToConstant: 28),
      checkButton.heightAnchor.constraint(equalToConstant: 28),

      titleLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
  }

  func configure(with todo: TodoItem) {
    // 제목 + 취소선
    if todo.isCompleted {
      titleLabel.attributedText = strikethrough(text: todo.title)
      titleLabel.textColor = .secondaryLabel
    } else {
      titleLabel.attributedText = NSAttributedString(string: todo.title)
      titleLabel.textColor = .label
    }

    // 체크 버튼
    let symbolName = todo.isCompleted ? "checkmark.circle.fill" : "circle"
    checkButton.setImage(UIImage(systemName: symbolName), for: .normal)
    checkButton.tintColor = todo.isCompleted ? .systemBlue : .systemGray2

    // 우선순위 색
    priorityView.backgroundColor = todo.priority.color
  }

  private func strikethrough(text: String) -> NSAttributedString {
    let attr = NSMutableAttributedString(string: text)
    attr.addAttribute(.strikethroughStyle,
                      value: NSUnderlineStyle.single.rawValue,
                      range: NSRange(location: 0, length: text.count))
    return attr
  }

  @objc private func toggleComplete() {
    onToggleComplete?()
  }
}
