//
//  ContentView.swift
//  ToDoList
//
//  Created by 송영민 on 8/7/25.
//

import SwiftUI

struct TodoItem: Identifiable {
  var id = UUID()
  var title: String
  var isCompleted: Bool = false
}

struct TodoListApp: View {
  @State private var todos: [TodoItem] = [
    TodoItem(title: "SwiftUI 공부하기"),
    TodoItem(title: "운동하기"),
    TodoItem(title: "책 읽기"),
  ]

  @State private var newTodoTitle = ""
  @State private var showingAddSheet = false

  var body: some View {
    NavigationStack {
      List {
        Section(header: Text("할 일 목록")) {
          ForEach($todos) { $todo in
            TodoRow(todo: $todo)
          }
          .onDelete(perform: deleteTodos)
        }

        if completedTodos.count > 0 {
          Section(header: Text("완료됨")) {
            ForEach(completedTodos) { todo in
              HStack {
                Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(.green)
                Text(todo.title)
                  .strikethrough()
                  .foregroundColor(.secondary)
              }
            }
          }
        }
      }
      .navigationTitle("할 일")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingAddSheet = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .sheet(isPresented: $showingAddSheet) {
        AddTodoView(todos: $todos, isPresented: $showingAddSheet)
      }
    }
  }

  var completedTodos: [TodoItem] {
    todos.filter { $0.isCompleted }
  }

  func deleteTodos(at offsets: IndexSet) {
    todos.remove(atOffsets: offsets)
  }

}

struct TodoRow: View {
  @Binding var todo: TodoItem

  var body: some View {
    HStack {
      Button {
        withAnimation {
          todo.isCompleted.toggle()
        }
      } label: {
        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
          .foregroundColor(todo.isCompleted ? .green : .gray)
      }
      .buttonStyle(PlainButtonStyle())

      Text(todo.title)
        .strikethrough(todo.isCompleted)

      Spacer()
    }
    .contentShape(Rectangle())
  }
}

struct AddTodoView: View {
  @Binding var todos: [TodoItem]
  @Binding var isPresented: Bool
  @State private var title = ""

  var body: some View {
    NavigationStack {
      Form {
        TextField("할 일 입력", text: $title)
      }
      .navigationTitle("새 할 일")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("취소") {
            isPresented = false
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("추가") {
            let newTodo = TodoItem(title: title)
            todos.append(newTodo)
            isPresented = false
          }
          .disabled(title.isEmpty)
        }
      }
    }
  }
}

struct SearchableList: View {
  @State private var searchText = ""
  let items = ["Swift", "SwiftUI", "UIkit", "Combine", "Core Data"]

  var filteredItems: [String] {
    if searchText.isEmpty {
      return items
    } else {
      return items.filter {
        $0.localizedCaseInsensitiveContains(searchText)
      }
    }
  }

  var body: some View {
    NavigationStack {
      List(filteredItems, id: \.self) { item in
        Text(item)
      }
      .searchable(text: $searchText, prompt: "검색")
      .navigationTitle("프레임워크")
    }
  }
}

#Preview {
  TodoListApp()
  SearchableList()
}
