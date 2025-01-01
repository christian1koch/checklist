//
//  AddRowView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 29.12.24.
//

import SwiftUI
import SwiftData

struct AddRowView: View {
    enum FocusedField {
        case addItem
    }
    @Binding var isOnAddMode: Bool
    @Binding var textFieldText: String
    var handleOnSubmit: () -> Void
    @FocusState var focusField: FocusedField?
    
    var body: some View {
        HStack {
            Image(systemName:"circle")
            TextField("Item Name", text: $textFieldText).focused($focusField, equals: .addItem)
            Spacer()
        }
        .contentShape(Rectangle())
        .onAppear {
            focusField = .addItem
        }
        .onSubmit {
            handleOnSubmit()
            focusField = .addItem
        }
    }
    
}

//#Preview {
//    
//}
