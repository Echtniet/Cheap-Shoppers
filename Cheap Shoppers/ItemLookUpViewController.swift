//
//  ItemLookUpViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 10/1/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class ItemLookUpViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    //outlet for item search
    
    @IBOutlet weak var itemSearchBar: UISearchBar!
    
    //outlett for table
    @IBOutlet weak var table: UITableView!
    
    // arrays to add items to help with the search functionalities
    var itemArray = [ShopItem]()
    var currentItemArray = [ShopItem]()
    
    //loads the title and placeholder and methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        navigationItem.title = "Cheap Shoppers"
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched), name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
        itemSearchBar.placeholder = "Search Item by Name"
        
        ItemArchive.shared.fetchAllItems()
        
         }
    //loads the tabbar title and image
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.navigationController?.tabBarItem.image = UIImage(named:"Search_1.png")
        navigationController?.tabBarItem.title = "Items"
        fetchAllItems()
        
    }
    //fetches the items into the table
    override func viewWillAppear(_ animated: Bool) {
        fetchAllItems()
        table.reloadData()
        
         }
    //returns the count of items
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItemArray.count
    }
    //populates the data in the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        
        let item = currentItemArray[indexPath.row]
        cell.itemNameLBL.text = item.itemName
        cell.itemPriceLBL.text = NumberFormatter.localizedString(from: NSNumber(value:item.price), number: .currency)
        cell.storeNameLBL.text = item.storeName
        cell.itemImage?.image = UIImage(named:item.itemName)
        return cell
        
    }
    //height for the table cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    //fetches the data in the background thread
    @objc func dataFetched(notification:Notification){
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    // adds the items to itemArray
    @objc func fetchAllItems(){
        ItemArchive.shared.fetchAllItems()
        itemArray = []
        for it in 0..<ItemArchive.shared.numItem{
            itemArray.append(ItemArchive.shared[it])
        }
        currentItemArray = itemArray
        
    }
    //delegates to this class from UISearchDelegate bar
    private func setUpSearchBar() {
        itemSearchBar.delegate = self
    }
    //notices the searchbar for any textchange and loads the data accordingly
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        guard !searchText.isEmpty else { currentItemArray = itemArray
            table.reloadData()
            return
            
        }
        currentItemArray = itemArray.filter({item -> Bool in
            return item.itemName.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
        
    }
    
}
