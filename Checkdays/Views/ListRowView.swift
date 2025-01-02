//
//  ListRowView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import SwiftUI

struct ListRowView: View {
    let item: ChecklistItem
    var body: some View {
        HStack {
            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
            item.isChecked ? 
            Text(item.title)
                .strikethrough()
                .foregroundStyle(.foreground.secondary) : 
            Text(item.title)
            Spacer()
        }.contentShape(Rectangle())
    }
}

#Preview {
    Group {
        ListRowView(item: ChecklistItem(title: "pancetta", isChecked: false))
        ListRowView(item: ChecklistItem(title: "kiwi", isChecked: true))
    }
}

