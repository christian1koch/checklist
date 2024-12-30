//
//  ContentView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Bindable var checklist: Checklist
    @Environment(\.modelContext) var modelContext
    @State var isInAddMode = false;
    
    @State var textFieldText = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var addButtonText: String {
        isInAddMode ? "Done" : "Add"
    }
    
    var body: some View {
        VStack {
            Text(checklist.name)
                .font(.title)
                .lineLimit(1) // Prevents wrapping
                .minimumScaleFactor(0.5) // Scales down text size if needed
                .multilineTextAlignment(.center)
            List {
                ForEach(checklist.sortedItems) { item in
                    ListRowView(item: item).onTapGesture {
                        withAnimation(.snappy) {
                            item.isChecked = !item.isChecked
                        }
                    }
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: { indices, newOffset in
                    var s = checklist.sortedItems.sorted(by: { $0.sortIndex < $1.sortIndex })
                    s.move(fromOffsets: indices, toOffset: newOffset)
                    for (index, item) in s.enumerated() {
                        item.sortIndex = index
                    }
                    try? self.modelContext.save()
                    print(checklist.sortedItems.map{$0.sortIndex});
                })
                if isInAddMode {
                    AddRowView(isOnAddMode: $isInAddMode, textFieldText: $textFieldText, handleOnSubmit: handleOnSubmit)
                }
            }
            .background(.white)
            .listStyle(.plain)
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
        }.padding([.horizontal], 40)
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = checklist.sortedItems[index]
            modelContext.delete(item)
        }
    }
    
    func handleOnSubmit() {
        if (textFieldText.isEmpty) {
            return
        }
        let maxSortItem = checklist.sortedItems.max(by: {$0.sortIndex < $1.sortIndex})
        let maxSortIndex = maxSortItem?.sortIndex ?? -1
        let newItem = ChecklistItem(title: textFieldText, sortIndex: maxSortIndex + 1)
        checklist.items.append(newItem)
        textFieldText = ""
    }
    
}

//#Preview {
//    NavigationStack {
//        ListView()
//    }
//}
