//
//  CheckListApp.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import SwiftUI
import SwiftData

@main
struct CheckListApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
            }
        }.modelContainer(for: ChecklistItem.self)
    }
}
