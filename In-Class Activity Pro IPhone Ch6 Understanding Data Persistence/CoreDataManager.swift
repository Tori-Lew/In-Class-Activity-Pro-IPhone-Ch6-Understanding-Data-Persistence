//
//  CoreDataManager.swift
//  In-Class Activity Pro IPhone Ch6 Understanding Data Persistence
//
//  Created by Student Account on 11/6/23.
//

import Foundation
import CoreData
class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
        }
    }
    func deleteBook(book: Book) {
        persistentContainer.viewContext.delete(book)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }



    func getAllBooks() -> [Book] {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    func saveBook(name: String, genre: String, isbn: String, author: String) {
        let book = Book(context: persistentContainer.viewContext)
        book.name = name
        book.author = author
        book.genre = genre
        book.isbn = isbn
        do {
            try persistentContainer.viewContext.save()
            print("Book saved!")
        } catch {
            print("Failed to save book \(error)")
        }
    }
}
