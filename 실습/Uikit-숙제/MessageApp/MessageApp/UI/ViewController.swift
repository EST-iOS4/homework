//
//  ViewController.swift
//  MessageApp
//
//  Created by 송영민 on 8/28/25.
//

import UIKit

class ViewController: UIViewController {
    var tableView = UITableView()
    var textField = UITextField()
    var sendbutton = UIButton()
    var FortuneFbutton = UIButton()
    
    var messages: [String] = ["안녕! 첫 메세지야"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
    
        tableView.register(MessageCell.self, forCellReuseIdentifier:
        "MessageCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        
        setupUI()
        setupConstraints()
//        sendMessage()
//        getFortune()
//        scrollToBottom()
    }
    func addMessage(_ text: String) {
        messages.append(text)
        let newIndexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }

    func setupUI() {
        view.backgroundColor = .systemBackground
        title = "운세 메신저"
        
        FortuneFbutton.setTitle("운세", for: .normal)
        sendbutton.setTitle("보내기", for: .normal)
        
        
        view.addSubview(tableView)
        view.addSubview(FortuneFbutton)
        view.addSubview(textField)
        view.addSubview(sendbutton)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        FortuneFbutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            FortuneFbutton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            FortuneFbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        sendbutton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendbutton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sendbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    func sendMessage() {
        
    }
    
    func getFortune() {
        
    }
    
    func scrollToBottom() {
        
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {}
