//
//  JuiceTableViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/14/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
var total_juices_selected = 0

var juice_order_string = String()

class JuiceCell:UITableViewCell
{
    @IBOutlet weak var juice_label: UILabel!
    @IBOutlet weak var juice_image: UIImageView!
    @IBOutlet weak var juice_name: UILabel!
    @IBOutlet weak var juice_add_button: UIButton!
    @IBOutlet weak var juice_subtract_button: UIButton!
    
    var current_index_clicked = 0
    
    @IBAction func juice_add_clicked(_ sender: Any)
    {
        if(total_juices_selected < max_number_of_juices_to_select)
        {
            if let current_number_juice = juice_label.text
            {
                if var current_number_juice_total = Int(current_number_juice)
                {
                    current_number_juice_total  = current_number_juice_total + 1
                    juice_number_per_order[current_index_clicked] =
                        current_number_juice_total
                    
                    juice_label.text = String(current_number_juice_total)
                    total_juices_selected = total_juices_selected + 1
                } // if var current_number_juice_total = Int(current_number_juice)
            } //if let current_number_juice = juice_label.text
        } // if(total_juices_selected < max_number_of_juices_to_select)
    } // @IBAction func juice_add_clicked(_ sender: Any)
    
    @IBAction func juice_subtract_clicked(_ sender: Any)
    {
        if let current_number_juice = juice_label.text
        {
            if var current_number_juice_total = Int(current_number_juice)
            {
                if(current_number_juice_total > 0)
                {
                    current_number_juice_total = current_number_juice_total - 1
                    juice_number_per_order[current_index_clicked] =
                        current_number_juice_total
                    
                    juice_label.text = String(current_number_juice_total)
                    total_juices_selected = total_juices_selected - 1
                } // if(current_number_juice_total > 0)
            } // if let current_number_juice_total = Int(current_number_juice)
        } // if let current_number_juice = juice_label.text
    } // @IBAction func juice_subtract_clicked(_ sender: Any)
} // class JuiceCell:UITableViewCell

class JuiceTableViewController: UITableViewController
{
    @IBOutlet weak var nav_item: UINavigationItem!
    
    @IBOutlet weak var done_nav_button: UIBarButtonItem!
    
    @IBAction func cancel_button_clicked(_ sender: Any)
    {
        performSegue(withIdentifier: "go_back_meat_page", sender:self)
    }
    
    
    @IBAction func go_to_cust_info(_ sender: Any)
    {
        // if the number of juices is not the required amount
        // for catering for the given number of guests chosen
        // then we need to let the user know via alert
        // and not allow them to perform segue to the
        // customer info page
        if (total_juices_selected != max_number_of_juices_to_select)
        {
            let title   = "Invalid Number of Juices"
            let message = "Insufficient number of juices selected:" + "\n" +
                String(total_juices_selected) + " of " + String(max_number_of_juices_to_select)
            displayAlert(a_title: title, a_message: message)
        }
        else
        {
            create_juice_info_string()
            performSegue(withIdentifier: "customer_info", sender: self)

        }
    }
    
    override func viewDidLoad()
    {
        juice_name_array = juice_name_array.sorted()
        
        if(!should_show_full_menu)
        {
            nav_item.title = "Juice Selection"
            done_nav_button.isEnabled = false
        }
        else
        {
            nav_item.title = "Choice of " + String(max_number_of_juices_to_select) + " Juices"
            done_nav_button.isEnabled = true
        }

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
        return juice_name_array.count
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? JuiceCell
        
        if let juice_cell = cell
        {
            juice_cell.current_index_clicked = indexPath.row
            juice_cell.juice_name.text = juice_name_array[indexPath.row]
            juice_cell.juice_image.image = juice_images[indexPath.row]
            juice_cell.juice_label.text = String(juice_number_per_order[indexPath.row])
            
            if(!should_show_full_menu)
            {
                juice_cell.juice_add_button.isHidden = true
                juice_cell.juice_subtract_button.isHidden = true
                juice_cell.juice_label.isHidden = true
            }
            else
            {
                juice_cell.juice_add_button.isHidden = false
                juice_cell.juice_subtract_button.isHidden = false
                juice_cell.juice_label.isHidden = false
            }
            
            return juice_cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  110
    }
    
    func displayAlert(a_title:String, a_message:String) -> Void
    {
        
        let alert = UIAlertController(
            title: a_title,
            message: a_message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }

    // we want to create a order info (juices)
    // string with new lines, and a nice way
    // of displaying the text when we go to
    // the checkout screen so the user can confirm their order
    func create_juice_info_string() -> Void
    {
        var index_of_juice  = 0
        var juice_number    = 1
        juice_order_string.removeAll()
        juice_order_string.append("JUICES ORDERED:")
        juice_order_string.append("\n")
        juice_order_string.append("-------------------------")
        juice_order_string.append("\n")
        for juice in juice_number_per_order
        {
            // meaning there was a juice ordered
            // for that specific juice
            // then we go look for the corresponding juice info
            if(juice > 0)
            {
                // we want the format to look like:
                /*
                 JUICE NUMBER x:
                   - JUICE KIND: y
                   - QUANTITY: z
                 ----------------
                 */
                juice_order_string.append("JUICE NUMBER ")
                juice_order_string.append(String(juice_number))
                juice_number = juice_number + 1
                juice_order_string.append(":")
                juice_order_string.append("\n")
                juice_order_string.append("  - JUICE KIND: ")
            juice_order_string.append(juice_name_array[index_of_juice])
                juice_order_string.append("\n")
                juice_order_string.append("  - QUANTITY: ")
                juice_order_string.append(String(juice_number_per_order[index_of_juice]))
                juice_order_string.append("\n")
                juice_order_string.append("\n")
            }
            index_of_juice  = index_of_juice + 1
        }
        juice_order_string.append("\n")
    } // func create_juice_info_string() -> Void
}
