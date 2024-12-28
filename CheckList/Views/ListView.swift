//
//  ContentView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Query var items: [ChecklistItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        List {
            ForEach(items) { item in
                ListRowView(item: item).onTapGesture {
                    withAnimation(.linear) {
                        item.isChecked = !item.isChecked
                    }
                }
            }
            .onDelete(perform: deleteItems)
//            .onMove(perform: listViewModel.moveItem)
        }
        .background(.white)
        .listStyle(.plain)
        .navigationTitle("Checklist")
        .toolbar {
            ToolbarItem(placement: .secondaryAction) {
                EditButton()
            }
            ToolbarItem(placement: .primaryAction) {
                NavigationLink("Add", destination: AddView())
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = items[index]
            modelContext.delete(item)
        }
    }
    
}

#Preview {
    NavigationStack {
        ListView()
    }
}
