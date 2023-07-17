//
//  ContentView.swift
//  Bookworm
//
//  Created by Radu Petrisel on 14.07.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var books: FetchedResults<Book>
    
    @State private var isShowingAddBookView = false
    
    private var booksByDate: [Date: [Book]] {
        Dictionary(grouping: books, by: { $0.date?.ignoreTime ?? Date.distantPast })
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(booksByDate.sorted(by: { lhs, rhs in lhs.key > rhs.key }), id: \.key) { date, value in
                    Section {
                        ForEach(value) { BookRow(book: $0) }
                            .onDelete {
                                deleteBooks(from: date, at: $0)
                            }
                    } header: {
                        Text(date.formatted(date: .abbreviated, time: .omitted))
                    }
                }
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
    
    private func deleteBooks(from date: Date, at indices: IndexSet) {
        for index in indices {
            let book = booksByDate[date]![index]
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
