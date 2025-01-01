//
//  ItemModel.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 27.12.24.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String
    let title: String
    let isChecked: Bool
    
    init(id: String = UUID().uuidString, title: String, isChecked: Bool) {
        self.id = id
        self.title = title
        self.isChecked = isChecked
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isChecked: !isChecked)
    }
}
