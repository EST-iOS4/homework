//
//  MessageTableViewCell.swift
//  messageApp
//
//  Created by SJS on 8/28/25.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    static let reuseID = "MessageTableViewCell"

    private let boxView = UIView() // 말풍선 박스
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()

    private var leadingC: NSLayoutConstraint!
    private var trailingC: NSLayoutConstraint!

    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = .current
        f.dateStyle = .none
        f.timeStyle = .short
        return f
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }

    private func setup() {
        selectionStyle = .none
        backgroundColor = .systemBackground

        boxView.layer.cornerRadius = 16
        boxView.layer.masksToBounds = true

        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 16)

        timeLabel.font = .systemFont(ofSize: 11)

        contentView.addSubview(boxView)
        boxView.translatesAutoresizingMaskIntoConstraints = false

        boxView.addSubview(messageLabel)
        boxView.addSubview(timeLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // messageLabel 위쪽
            messageLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -12),

            // timeLabel 아래쪽
            timeLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 6),
            timeLabel.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: -12),
            timeLabel.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -8),

            // boxView 자체
            boxView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            boxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            boxView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.75),
            
            boxView.widthAnchor.constraint(greaterThanOrEqualToConstant: 70) // 최소 크기
        ])

        // 좌우 정렬 (둘 중 하나만)
        leadingC  = boxView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        trailingC = boxView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        leadingC.isActive = true
    }

    func configure(_ message: Message) {
        messageLabel.text = message.text
        timeLabel.text = Self.timeFormatter.string(from: message.timestamp)

        trailingC.isActive =  message.isMyMessage // 오른쪽(내꺼)
        leadingC.isActive  = !message.isMyMessage // 왼쪽(상대꺼)
        
        // imassege처럼 느낌 내기 (색깔)
        if message.isMyMessage {
            boxView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            timeLabel.textColor = UIColor.white
        } else {
            boxView.backgroundColor = .secondarySystemBackground
            messageLabel.textColor = .label
            timeLabel.textColor = .secondaryLabel
        }
    }
}
