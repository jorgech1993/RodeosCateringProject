//
//  MeatsTableViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/10/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class meatCell: UITableViewCell
{
    
    @IBOutlet weak var meat_image_view: UIImageView!
    @IBOutlet weak var meat_label: UILabel!
}

class MeatsTableViewController: UITableViewController
{
    
    
    
    @IBAction func cancel_meat(_ sender: Any)
    {
        performSegue(withIdentifier: "cancel_meat", sender: self)
    }
    
    
    
    override func viewDidLoad()
    {
        // now sort the array alphabetically
        // so we can match it with the corresponding
        // indecies of the picture array, and so the
        // user can find the items in an aesthetic
        // fashion
        meat_name_array = meat_name_array.sorted()
        juice_name_array = juice_name_array.sorted()
        print(juice_name_array)
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return meat_name_array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? meatCell

        if let meat_cell = cell
        {
            meat_cell.meat_label.text = meat_name_array[indexPath.row]
            meat_cell.meat_image_view.image = meat_images[indexPath.row]
            return meat_cell
        }
    
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  110
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
}
