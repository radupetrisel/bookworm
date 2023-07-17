//
//  DetailView.swift
//  Bookworm
//
//  Created by Radu Petrisel on 14.07.2023.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }

            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Untitled")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $isShowingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                isShowingDeleteAlert = true
            } label: {
                Label("Delete", systemImage: "trash")
            }

        }
    }
    
    private func deleteBook() {
        viewContext.delete(book)
        try? viewContext.save()
        
        dismiss()
    }
}
