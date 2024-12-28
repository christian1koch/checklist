//
//  AddView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    @Query var items: [ChecklistItem]
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            TextField("Type something here", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.buttonBorder)
            Button(action: handleSaveButtonPressed, label: {
                Text("Save").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).frame(height: 40)
            }).buttonStyle(.borderedProminent)
        }.navigationTitle("Agrega algo").padding()
            .alert(isPresented: $showAlert, content: getAlert
            )
    }
    
    func handleSaveButtonPressed() {
        if (isTextAppropiate()) {
            modelContext.insert(ChecklistItem(title: textFieldText, sortIndex: items.count))
            return dismiss()
        }
        alertTitle = "A new checklist item needs to be at least 3 characters long"
        return showAlert.toggle()
    }
    
    func isTextAppropiate() -> Bool {
        if textFieldText.count < 3 {
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

#Preview {
    NavigationStack {
        AddView()
    }.environmentObject(ListViewModel())
}
