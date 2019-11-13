//
//  ItemLookUpViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 10/1/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class ItemLookUpViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var items:[ShopItem]!
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
     
        navigationController?.tabBarItem.title = "Items"
        
        items = []
        for i in 0..<ItemArchive.shared.numItem{
            items.append(ItemArchive.shared[i])
            
        }
        
    }
    // var itemArray = [ShopItem]()
     var currentItemArray = [ShopItem]()
    // var currentItemArray:[ShopItem]!
    
    
    @IBOutlet weak var itemSearchBar: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
        alterLayout()
        setUpSearchBar()
        fetchAllItems()
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched), name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    @objc func dataFetched(notification:Notification){
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    @objc func fetchAllItems(){
        ItemArchive.shared.fetchAllItems()
    }
    
    //var itemArray = [Item]()
    private func setUpItems(){
        
        for i in 0..<ItemArchive.shared.numItem{
           // items.append(ItemArchive.shared[i].self)
        
            currentItemArray.append(ItemArchive.shared[i])
            items.append(ItemArchive.shared[i])
            print(items[i].itemName)
            print(currentItemArray[i].itemName)
        
        }
        
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
        
        
            //return items.count
         return ItemArchive.shared.numItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        
       let item = ItemArchive.shared[indexPath.row]
       // cell.itemNameLBL.text = x.itemName
        cell.itemNameLBL.text = item.itemName
           cell.itemPriceLBL.text = "\(item.price)"
        cell.storeNameLBL.text = item.storeName
        
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
        guard !searchText.isEmpty else {
            table.reloadData()
            return
            
        
        }
        
        
        
        //currentItemArray = itemArray.filter({item -> Bool in
            //guard let text = searchBar.text else { return false }
            
            
          //  return item.itemName.lowercased().contains(searchText.lowercased())
        }
    
    /*
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
     
     }*/
    /*
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
     }*/
    
}
