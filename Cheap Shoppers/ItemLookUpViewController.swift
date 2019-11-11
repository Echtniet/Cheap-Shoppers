//
//  ItemLookUpViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 10/1/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class ItemLookUpViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var itemSearchBar: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
        alterLayout()
        setUpSearchBar()
        
        // Do any additional setup after loading the view.
    }
    
    
    var itemArray = [Item]()
    var currentItemArray = [Item]()
    
    class Item{
        var itemName:String
        var price:Double
        var storeName:String
        var category: ItemType
        
        init(itemName: String, price:Double, storeName:String, category: ItemType){
            self.itemName=itemName
            self.price=price
            self.storeName=storeName
            self.category=category
            
        }
    }
    
    enum ItemType: String {
        
        case vegetables="Vegetable"
        case groceries="Groceries"
    }
    
    private func setUpItems(){
        //VEGETABLES
        itemArray.append(Item(itemName: "Tomato", price: 2.3, storeName: "Walmart", category: .vegetables))
        itemArray.append(Item(itemName: "Potato", price: 1.3, storeName: "Hyvee", category: .vegetables))
        itemArray.append(Item(itemName: "Cauliflower", price: 4.3, storeName: "Walmart", category: .vegetables))
        //GROCERIES
        itemArray.append(Item(itemName: "Milk", price: 6.0, storeName: "Walmart", category: .groceries))
        itemArray.append(Item(itemName: "Bread", price: 3.0, storeName: "Walmart", category: .groceries))
        itemArray.append(Item(itemName: "Coke", price: 8.0, storeName: "Hyvee", category: .groceries))
        
        currentItemArray = itemArray
        
    }
    
    
    private func setUpSearchBar() {
        itemSearchBar.delegate = self
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: itemSearchBar)
        navigationItem.titleView = itemSearchBar
        itemSearchBar.showsScopeBar = false // you can show/hide this dependant on your layout
        itemSearchBar.placeholder = "Search Item by Name"
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.itemNameLBL.text = currentItemArray[indexPath.row].itemName
        cell.itemPriceLBL.text = "\(currentItemArray[indexPath.row].price)"
        cell.storeNameLBL.text = currentItemArray[indexPath.row].storeName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return itemSearchBar
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        guard !searchText.isEmpty else { currentItemArray = itemArray
            table.reloadData()
            return
            
        }
        currentItemArray = itemArray.filter({item -> Bool in
            //guard let text = searchBar.text else { return false }
            return item.itemName.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope {
        case 0:
            currentItemArray = itemArray
        case 1:
            currentItemArray = currentItemArray.filter({item -> Bool in
                item.category == ItemType.vegetables
            })
        case 2:
            currentItemArray = currentItemArray.filter({item -> Bool in
                item.category == ItemType.groceries
            })
            
        default:
            break
        }
        table.reloadData()
    }
}
