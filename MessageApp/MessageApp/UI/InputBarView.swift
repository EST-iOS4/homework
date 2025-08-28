//
//  InputBarView.swift
//  MessageApp
//
//  Created by 송영민 on 8/28/25.
//

import UIKit

class InputBarView: UIView {
    let textField = UITextField()
    let sendButton = UIButton(type: .system)
    let fortuneButton = UIButton(type: .system)
    
    let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        makeConstraints()
    }
    
    func configureUI() {
        backgroundColor = .systemBackground
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        
        textField.layer.cornerRadius = 16
//        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        
        fortuneButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        sendButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        addSubview(stack)
        stack.addArrangedSubview(fortuneButton)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(sendButton)

        // 우선순위? 텍스트필드가 먼저 가로 공간 차지
//        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        textField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        fortuneButton.setContentHuggingPriority(.required, for: .horizontal)
//        sendButton.setContentHuggingPriority(.required, for: .horizontal)
        
    }
    
    func makeConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        fortuneButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            fortuneButton.widthAnchor.constraint(equalToConstant: 44),
            fortuneButton.heightAnchor.constraint(equalToConstant: 44),
            
            sendButton.widthAnchor.constraint(equalToConstant: 56),
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            
            textField.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
