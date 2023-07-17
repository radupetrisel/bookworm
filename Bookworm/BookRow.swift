//
//  BookBook.swift
//  Bookworm
//
//  Created by Radu Petrisel on 17.07.2023.
//

import SwiftUI

struct BookRow: View {
    let book: Book
    
    var body: some View {
        NavigationLink {
            DetailView(book: book)
        } label: {
            HStack {
                EmojiRatingView(rating: book.rating)
                    .font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text(book.title ?? "Untitled")
                        .font(.headline)
                    
                    Text(book.author ?? "Unknown author")
                        .foregroundColor(book.rating == 1 ? .red.opacity(0.7) : .secondary)
                }
            }
            .foregroundColor(book.rating == 1 ? .red : .primary)
        }
    }
}

struct BookRow_Previews: PreviewProvider {
    static var viewContext = DataController.preview.container.viewContext
    
    static var previews: some View {
        BookRow(book: Book.preview(context: viewContext))
    }
}
