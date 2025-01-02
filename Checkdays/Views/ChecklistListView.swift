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
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(checklists) { checklist in
                    HStack {
                        NavigationLink(checklist.name, value: checklist)
                    }
                }
            }
            .navigationTitle("CheckLists")
            .navigationDestination(for: Checklist.self) { checklist in
                ListView(checklist: checklist)
            }.toolbar {
                NavigationLink("Add") {
                    AddChecklistView()
                }
            }
        }
    }
}

#Preview {
    ChecklistListView()
}
