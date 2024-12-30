//
//  Checklist.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 30.12.24.
//

import Foundation
import SwiftData

@Model
class Checklist {
    var name: String
    @Relationship(deleteRule: .cascade) var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name;
    }
    var sortedItems: [ChecklistItem] {
        return items.sorted(by: { $0.sortIndex < $1.sortIndex })
    }
}
