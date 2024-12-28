//
//  ListViewModel.swift
//  CheckList
//
//  Created by Christian Koch Echeverria on 28.12.24.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []
   
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "tocineta", isChecked: false),
            ItemModel(title: "kiwi", isChecked: false),
            ItemModel(title: "pancetta", isChecked: true),
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
            items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isChecked: false)
        items.append(newItem);
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
}
