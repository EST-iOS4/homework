//
//  MessageCell.swift
//  Message
//
//  Created by 구현모 on 8/28/25.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var MessageView: UIView!
    @IBOutlet weak var MessageLabel: UILabel!
    
    @IBOutlet weak var LeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var TrailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageView?.layer.cornerRadius = 15
        MessageLabel?.backgroundColor = .clear
        MessageLabel?.numberOfLines = 0
        MessageLabel?.lineBreakMode = .byWordWrapping
    }
    
    func configure(with message: ViewController.Message) {
        MessageLabel?.text = message.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if message.isMyMessage {
            MessageView?.backgroundColor = .systemBlue
            MessageLabel?.textColor = .white
            LeadingConstraint?.constant = 80
            TrailingConstraint?.constant = 20
        } else {
            MessageView?.backgroundColor = .systemGray5
            MessageLabel?.textColor = .label
            LeadingConstraint?.constant = 20
            TrailingConstraint?.constant = 80
        }
    }
}
