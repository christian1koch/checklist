//
//  AddChecklistView.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 30.12.24.
//

import SwiftUI
import SwiftData

struct AddChecklistView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext

    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            TextField("Name", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.buttonBorder)
            Button(action: handleSaveButtonPressed, label: {
                Text("Save").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).frame(height: 40)
            }).buttonStyle(.borderedProminent)
        }.navigationTitle("New Checklist").padding()
            .alert(isPresented: $showAlert, content: getAlert
            )
    }
    
    func handleSaveButtonPressed() {
        if (isTextAppropiate()) {
            modelContext.insert(Checklist(name: textFieldText))
            return dismiss()
        }
        alertTitle = "A new checklist needs to be at least 3 characters long"
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
        AddChecklistView()
    }
}
