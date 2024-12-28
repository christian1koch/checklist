//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 28.12.24.
//

import Foundation
import SwiftData

@Model
class ChecklistItem {
    var id: String
    var title: String;
    var isChecked: Bool;
    
    init(id: String = UUID().uuidString, title: String, isChecked: Bool = false) {
        self.id = id
        self.title = title
        self.isChecked = isChecked
    }
}
