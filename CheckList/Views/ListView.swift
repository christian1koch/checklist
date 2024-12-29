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
    @State var isInAddMode = false;
    
    @State var textFieldText = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var addButtonText: String {
        isInAddMode ? "Done" : "Add"
    }
    
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
            if isInAddMode {
                AddRowView(isOnAddMode: $isInAddMode, textFieldText: $textFieldText, handleOnSubmit: handleOnSubmit)
            }
        }
        .background(.white)
        .listStyle(.plain)
        .navigationTitle("Checklist")
        .toolbar {
            ToolbarItem(placement: .secondaryAction) {
                EditButton()
            }
            ToolbarItem(placement: .primaryAction) {
                Button(addButtonText) {
                    if (isInAddMode) {
                        handleOnSubmit()
                    }
                    isInAddMode.toggle()
                    
                }
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = items[index]
            modelContext.delete(item)
        }
    }
    
    func handleOnSubmit() {
        if (textFieldText.isEmpty) {
            return
        }
        let maxSortItem = items.max(by: {$0.sortIndex < $1.sortIndex})
        let maxSortIndex = maxSortItem?.sortIndex ?? -1
        modelContext.insert(ChecklistItem(title: textFieldText, sortIndex: maxSortIndex + 1))
        textFieldText = ""
    }
    
}

#Preview {
    NavigationStack {
        ListView()
    }
}
