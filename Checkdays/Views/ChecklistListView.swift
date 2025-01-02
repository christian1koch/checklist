//
//  ChecklistListView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 30.12.24.
//

import SwiftUI
import SwiftData

struct ChecklistListView: View {
    @Query var checklists: [Checklist]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklists) { checklist in
                    HStack {
                        NavigationLink(checklist.name, value: checklist)
                    }
                }.onDelete(perform: deleteItems)
            }
            .navigationTitle("Checklists")
            .navigationDestination(for: Checklist.self) { checklist in
                ListView(checklist: checklist)
            }.toolbar {
                NavigationLink("Add") {
                    AddChecklistView()
                }
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let checklistToDelete = checklists[index]
            modelContext.delete(checklistToDelete)
        }
    }
}

#Preview {
    ChecklistListView()
}
