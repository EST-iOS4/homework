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
    private let timestampLabel = UILabel()
    
    var bubbleLeading: NSLayoutConstraint!
    var bubbletrailing: NSLayoutConstraint!
    
    var timeLeftOfBubble: NSLayoutConstraint!
    var timeRightOfBubble: NSLayoutConstraint!
    
    static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "a h:mm"
//        f.timeStyle = .short
        return f
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground
        
        bubbleView.layer.cornerRadius = 18
        bubbleView.layer.masksToBounds = true
        
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        
        messageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        messageLabel.setContentHuggingPriority(.required, for: .vertical)
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        contentView.addSubview(timestampLabel)
        
        
        timestampLabel.font = .systemFont(ofSize: 11)
        timestampLabel.textColor = .secondaryLabel
         
        let maxWidth = bubbleView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7)
        maxWidth.priority = .required
        
        bubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        bubbletrailing = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            maxWidth,
          
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 14),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -14),
            
            timestampLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -6)
            
            ])
        
        timeLeftOfBubble  = timestampLabel.trailingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: -6)
        timeRightOfBubble = timestampLabel.leadingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 6)

        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let max = contentView.bounds.width * 0.7 - 28
        if messageLabel.preferredMaxLayoutWidth != max {
            messageLabel.preferredMaxLayoutWidth = max
        }
    }
    
    override func prepareForReuse() {
        super .prepareForReuse()
        bubbleLeading.isActive = false
        bubbletrailing.isActive = false
        timeLeftOfBubble?.isActive = false
        timeRightOfBubble?.isActive = false
    }
    
    func configure(with mesaage: Message) {
        messageLabel.text = mesaage.text
        timestampLabel.text = Self.timeFormatter.string(from: mesaage.timestamp)
        
        if mesaage.isMyMessage {
            bubbleLeading.isActive = false
            bubbletrailing.isActive = true
            
            timeLeftOfBubble.isActive = true
            timeRightOfBubble.isActive = false
            
            bubbleView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
           
        } else {
            bubbleLeading.isActive = true
            bubbletrailing.isActive = false
            
            timeLeftOfBubble.isActive = false
            timeRightOfBubble.isActive = true
            
            bubbleView.backgroundColor = .systemGray
            messageLabel.textColor = .white
          
        }
    }
    
 
}
