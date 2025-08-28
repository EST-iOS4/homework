//
//  MessageCell.swift
//  MessageApp
//
//  Created by 송영민 on 8/28/25.
//

import UIKit

class MessageCell: UITableViewCell {
    let bubbleView = UIView()
    let messageLabel = UILabel()
    
    var bubbleLeading: NSLayoutConstraint!
    var bubbletrailing: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground
        
        bubbleView.layer.cornerRadius = 18
        bubbleView.layer.masksToBounds = true
        
        messageLabel.numberOfLines = 0
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
         
        let maxWidth = bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7)
        maxWidth.priority = .required
        
        bubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        bubbletrailing = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            maxWidth,
          
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: -14),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 14)
            ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with mesaage: Message) {
        messageLabel.text = mesaage.text
        
        if mesaage.isMyMessage {
            bubbleLeading.isActive = false
            bubbletrailing.isActive = true
            
            bubbleView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
        } else {
            bubbleLeading.isActive = true
            bubbletrailing.isActive = false
            
            bubbleView.backgroundColor = .systemGray
            messageLabel.textColor = .white
        }
    }
    
 
}
