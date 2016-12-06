//
//  FAAlertControllerPickerView.swift
//  FAAlertController
//
//  Created by Jesse Cox on 12/3/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit


/// Adopted by types used as items in an `FAAlertController` with the `.picker` presentation style
public protocol Pickable {
    /// The title to be displayed for the item
    var title: String { get }
    /// The subtitle to be displayed for the item
    var subtitle: String? { get }
}

protocol FAAlertControllerPickerDelegate {
    func didSelectItem(_ item: Pickable)
}

class FAAlertControllerPickerView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var items: [Pickable]?
    
    init(items: [Pickable]?) {
        super.init(frame: .zero, style: .plain)
        
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 200).isActive = true
        backgroundColor = FAAlertControllerAppearanceManager.sharedInstance.tableViewBackgroundColor
        separatorColor = FAAlertControllerAppearanceManager.sharedInstance.tableViewSeparatorColor
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else {
            fatalError("There should never be more than one section here.")
        }
        return items?.isEmpty == true ? 0 : items!.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "identifier")
        // Adjust the appearance...
        cell.backgroundColor = FAAlertControllerAppearanceManager.sharedInstance.tableViewCellBackgroundColor
        cell.textLabel?.textColor = FAAlertControllerAppearanceManager.sharedInstance.titleTextColor
        cell.detailTextLabel?.textColor = FAAlertControllerAppearanceManager.sharedInstance.titleTextColor
        // Configure the cell...
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subtitle
        }
        return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // MARK: Table view delagate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items?[indexPath.row], let pickerDelegate = FAAlertControllerAppearanceManager.sharedInstance.pickerDelegate {
            pickerDelegate.didSelectItem(item)
        }
    }
    
}
