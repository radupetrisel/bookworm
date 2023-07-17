//
//  ContentView.swift
//  Bookworm
//
//  Created by Radu Petrisel on 14.07.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) private var books: FetchedResults<Book>
    
    @State private var isShowingAddBookView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
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
                .onDelete(perform: deleteBooks(at:))
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddBookView.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddBookView) {
                AddBookView()
            }
        }
    }
    
    private func deleteBooks(at indices: IndexSet) {
        for index in indices {
            let book = books[index]
            viewContext.delete(book)
        }
        
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
