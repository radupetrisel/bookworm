//
//  BookExtensions.swift
//  Bookworm
//
//  Created by Radu Petrisel on 17.07.2023.
//

import CoreData

extension Book {
    static func preview(context: NSManagedObjectContext) -> Book {
        var book = Book(context: context)
        book.title = "Test title"
        book.author = "Test Author"
        book.genre = "Mystery"
        book.rating = 3
        book.review = "Test review"
        return book
    }
}
