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
    
    var itemArray = [ShopItem]()
    var currentItemArray = [ShopItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpItems()
        searchLayout()
        setUpSearchBar()
       // UIImageView.ContentMode = UIView.ContentMode.scaleAspectFill
       // fetchAllItems()
        navigationItem.title = "Cheap Shoppers"
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched), name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.navigationController?.tabBarItem.image = UIImage(named:"Search_1.png")
        navigationController?.tabBarItem.title = "Items"
        fetchAllItems()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ItemArchive.shared.fetchAllItems()
        fetchAllItems()
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItemArray.count
        //return ItemArchive.shared.numItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        
        let item = currentItemArray[indexPath.row]
        cell.itemNameLBL.text = item.itemName
        cell.itemPriceLBL.text = NumberFormatter.localizedString(from: NSNumber(value:item.price), number: .currency)
        cell.storeNameLBL.text = item.storeName
        cell.itemImage?.image = UIImage(named:item.itemName)
        // NumberFormatter.localizedString(from: NSNumber(value:item.price), number: .currency)
      
        //cell.imageView?.contentClippingRect = UIImage(named:item.itemName)
       // cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        cell.imageView?.frame.size.width = 300
        cell.imageView?.backgroundColor = UIColor.purple
       // cell.imageView?.image = UIImage(named:item.itemName)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func dataFetched(notification:Notification){
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    @objc func fetchAllItems(){
        ItemArchive.shared.fetchAllItems()
        itemArray = []
        for it in 0..<ItemArchive.shared.numItem{
            itemArray.append(ItemArchive.shared[it])
        }
        currentItemArray = itemArray
        
        
    }
    private func setUpItems(){
    }
    
    private func setUpSearchBar() {
        itemSearchBar.delegate = self
    }
    func searchLayout() {
       // table.tableHeaderView = UIView()
        // search bar in section header
     //   table.estimatedSectionHeaderHeight = 50
        // search bar in navigation bar
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: itemSearchBar)
     //   navigationItem.titleView = itemSearchBar
        
        itemSearchBar.placeholder = "Search Item by Name"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
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
