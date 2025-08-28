//
//  ViewController.swift
//  TodoGo
//
//  Created by 송영민 on 8/24/25.
//

import UIKit

struct TodoItem {
  var title: String
  var isCompleted: Bool
  var priority: Priority

  enum Priority: Int, CaseIterable {
    case low = 0, medium = 1, high = 2

    var color: UIColor {
      switch self {
      case .low:    return .systemGreen
      case .medium: return .systemYellow
      case .high:   return .systemRed
      }
    }

    var title: String {
      switch self {
      case .low:    return "낮음"
      case .medium: return "보통"
      case .high:   return "높음"
      }
    }
  }
}

class ViewController: UIViewController, UITableViewDataSource {
  let tableView: UITableView = {
      let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
      return tableView
    }()
  
  var todos: [TodoItem] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    
    tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.reuseID)
    
    tableView.dataSource = self
//    tableView.delegate = self
    
    setupNavigationBar()
    loadSampleData()
    
    tableView.reloadData()
  }
 
  func setupNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTodo)
    )
  }
  
  @objc func addTodo() {
    let alert = UIAlertController(title: "새 할 일", message: nil, preferredStyle: .alert)
    alert.addTextField { tf in
      tf.placeholder = "할 일을 입력하세요."
    }

    let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
      guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
      let newTodo = TodoItem(title: text, isCompleted: false, priority: .medium)
      self.todos.append(newTodo)
      let indexPath = IndexPath(row: self.todos.count - 1, section: 0)
      self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    alert.addAction(saveAction)
    alert.addAction(UIAlertAction(title: "취소", style: .cancel))
    present(alert, animated: true)
  }
  
  func loadSampleData() {
    todos = [
      TodoItem(title: "UITableView 학습하기", isCompleted: true,  priority: .high),
      TodoItem(title: "커스텀 셀 만들기",    isCompleted: false, priority: .medium),
      TodoItem(title: "스와이프 액션 구하기", isCompleted: false, priority: .low)
    ]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.reuseID, for: indexPath) as! TodoTableViewCell
      let item = todos[indexPath.row]
      cell.configure(with: item)

      cell.checkButton.tag = indexPath.row
      cell.checkButton.removeTarget(nil, action: nil, for: .allEvents)
      cell.checkButton.addTarget(self, action: #selector(toggleComplete(_:)), for: .touchUpInside)

      return cell
    }

    
    @objc private func toggleComplete(_ sender: UIButton) {
      let row = sender.tag
      guard row < todos.count else { return }
      todos[row].isCompleted.toggle()
      tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
}
