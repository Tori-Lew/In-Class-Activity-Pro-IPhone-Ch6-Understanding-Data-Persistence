//
//  ContentView.swift
//  In-Class Activity Pro IPhone Ch6 Understanding Data Persistence
//
//  Created by Student Account on 11/6/23.
//

import SwiftUI
class UserSettings: ObservableObject {
    @Published var isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode") {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
}
struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    let coreDM: CoreDataManager
    @State var bookName = ""
    @State var bookAuthor = ""
    @State var bookGenre = ""
    @State var bookISBN = ""
    @State var bookArray = [Book]()
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $userSettings.isDarkMode)
            .tint(.accentColor)
            TextField("Enter book name", text: $bookName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter author", text: $bookAuthor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter genre", text: $bookGenre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter ISBN", text: $bookISBN)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
                coreDM.saveBook(name: bookName, genre: bookGenre, isbn: bookISBN, author: bookAuthor)
                displayBooks()
                bookName = ""
                bookAuthor = ""
                bookGenre = ""
                bookISBN = ""
            }
            .padding()
            List {
                ForEach(bookArray, id: \.self) { book in
                    VStack {
                        Text(book.name ?? "")
                        Text(book.author ?? "")
                        Text(book.genre ?? "")
                        Text(book.isbn ?? "")
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let book = bookArray[index]
                        coreDM.deleteBook(book: book)
                        displayBooks()
                    }
                })
            }
            .onAppear(perform: {
                displayBooks()
            })
        }
        .padding()
        .preferredColorScheme(userSettings.isDarkMode ? .dark : .light)
    }
    func displayBooks() {
        bookArray = coreDM.getAllBooks()
    }
}

#Preview {
    ContentView(coreDM: CoreDataManager())
}
