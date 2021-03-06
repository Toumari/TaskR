//
//  CategoryViewController.swift
//  TaskR
//
//  Created by Jack Williams on 09/08/2018.
//  Copyright © 2018 Jack Williams. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        tableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categoryArray?[indexPath.row] {
            
            cell.textLabel?.text = category.name
            
            let progress = cell.viewWithTag(100) as! UIProgressView //refer the label by Tag
            
            let label2 = cell.viewWithTag(101) as! UILabel //refer the label by Tag
            
            guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
            
            cell.backgroundColor = categoryColour
            
            label2.text = String(category.progress) + " Items"
            
            progress.setProgress(Float(category.progress) / 10 , animated: true)
            
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
            label2.textColor = ContrastColorOf(categoryColour, returnFlat: true)
            
        }
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexpath.row]
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New TaskR Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            //What happens once user clicks add item
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            newCategory.progress = 0
            
            self.save(category: newCategory)
            
            self.loadItems()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context \(error)")
        }
            tableView.reloadData()
    }
    
    func loadItems() {
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {

            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("error")
            }

        }
    }
    
}

