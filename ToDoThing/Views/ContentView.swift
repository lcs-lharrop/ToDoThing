//
//  ContentView.swift
//  ToDoThing
//
//  Created by Lexi on 2024-04-09.
//

import SwiftUI

struct ContentView: View {
    
    @State var newItemDescription: String = ""
    
    @State var searchText = ""
    
    @State var todos: [TodoItem] = exampleItems
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List($todos) { $todo in
                    
                    ItemView(currentItem: $todo)
                        .swipeActions {
                            Button(
                                "Delete",
                                role: .destructive,
                                action: {
                                    delete(todo)
                                }
                            )
                        }
                        
                
                }
                .searchable(text: $searchText)
                
                HStack {
                    TextField("Enter a to-do item", text: $newItemDescription)
                        Button("ADD") {
                        createToDo(withTitle: newItemDescription)
                    }
                    .font(.caption)
                    .disabled(newItemDescription.isEmpty == true)
                }
                .padding(20)
                
            }
            .navigationTitle("To do")
        }
    }
    
    func createToDo(withTitle title: String) {
        let todo = TodoItem(
            text: title,
            done: false
        )
        todos.append(todo)
        
        searchText = ""
    }
    
    func delete(_ todo: TodoItem) {
        todos.removeAll() { currentItem in
            currentItem.id == todo.id
        }
    }
    
}

#Preview {
    ContentView()
}


