//
//  ViewController.swift
//  TodoList
//
//  Created by 송영민 on 8/22/25.
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

class ViewController: UIViewController {
  let tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()

  var todos: [TodoItem] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Todo App"

    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    tableView.delegate = self
    tableView.dataSource = self

    // ✅ 커스텀 셀(코드 기반) 등록
    tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoCell")

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
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell
    let item = todos[indexPath.row]
    cell.configure(with: item)

    // 체크 버튼 토글 콜백
    cell.onToggleComplete = { [weak self, weak tableView] in
      guard let self = self else { return }
      self.todos[indexPath.row].isCompleted.toggle()
      tableView?.reloadRows(at: [indexPath], with: .automatic)
    }
    return cell
  }

  // 셀 탭으로도 완료 토글하고 싶다면 주석 해제
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    todos[indexPath.row].isCompleted.toggle()
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }

  // 스와이프 삭제
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      todos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}
