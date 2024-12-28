//
//  ContentView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Query(sort: \ChecklistItem.sortIndex) var items: [ChecklistItem]
    @Environment(\.modelContext) var modelContext
    
    
    var body: some View {
        
        List {
            ForEach(items) { item in
                ListRowView(item: item).onTapGesture {
                    withAnimation(.snappy) {
                        item.isChecked = !item.isChecked
                    }
                }
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: { indices, newOffset in
                var s = items.sorted(by: { $0.sortIndex < $1.sortIndex })
                s.move(fromOffsets: indices, toOffset: newOffset)
                for (index, item) in s.enumerated() {
                    item.sortIndex = index
                }
                try? self.modelContext.save()
                print(items.map{$0.sortIndex});
            })
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
