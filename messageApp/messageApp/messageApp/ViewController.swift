//
//  ViewController.swift
//  messageApp
//
//  Created by SJS on 8/28/25.
//
import UIKit

final class ViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let inputBar = UIView()
    private let textField = UITextField()
    private let sendButton = UIButton(type: .system)

    private var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


    func setupUI() {
        title = "운세 메신저"
        view.backgroundColor = .systemBackground

        // 상단 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "오늘의 운세 받기",
            style: .plain,
            target: self,
            action: #selector(didTapFortuneButton)
        )

        // 테이블뷰
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        view.addSubview(tableView)

        // 입력 바
        inputBar.backgroundColor = .systemBackground
        view.addSubview(inputBar)

        // 텍스트필드 & 버튼
        textField.placeholder = "메시지를 입력하세요"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .send
        textField.delegate = self

        // 인스타그램처럼 비행기로 send표시
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let icon = UIImage(systemName: "paperplane.fill", withConfiguration: config)
        sendButton.setImage(icon, for: .normal)
        sendButton.tintColor = .systemBlue
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)

        // 오토레이아웃
        [tableView, inputBar, textField, sendButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        inputBar.addSubview(textField)
        inputBar.addSubview(sendButton)

        NSLayoutConstraint.activate([
            // 테이블뷰
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputBar.topAnchor),

            // 입력 바
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // 입력 바 내부
            textField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 12),
            textField.bottomAnchor.constraint(equalTo: inputBar.bottomAnchor, constant: -8),

            sendButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -12),
            sendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    @objc private func didTapFortuneButton() {
        let text = getFortune()
        let msg = Message(text: text, isMyMessage: false, timestamp: Date())
        appendMessage(msg)
    }

    @objc func sendMessage() {
        let trimmed = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !trimmed.isEmpty else { return }
        let msg = Message(text: trimmed, isMyMessage: true, timestamp: Date())
        appendMessage(msg)
        textField.text = ""
    }

    func getFortune() -> String {
        fortuneMessages.randomElement() ?? "오늘은 평온한 하루가 될 거예요."
    }

    private func appendMessage(_ msg: Message) {
        messages.append(msg)
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        scrollToBottom()
    }

    func scrollToBottom() {
        guard !messages.isEmpty else { return }
        tableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0),
                              at: .bottom, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { messages.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseID, for: indexPath) as! MessageTableViewCell
        cell.configure(messages[indexPath.row])
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}
