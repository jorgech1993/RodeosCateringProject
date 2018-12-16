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

var total_meats_selected = 0
var meats_ordered_string = String()

// function that allows us to color coordinate
// certain words in a string/label
// reference: https://stackoverflow.com/questions/27728466/use-multiple-font-colors-in-a-single-label
extension NSMutableAttributedString
{
    func setColorForText(textForAttribute: String, withColor color: UIColor)
    {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

class meatCell: UITableViewCell
{
    @IBOutlet weak var meat_image_view: UIImageView!
    @IBOutlet weak var meat_label: UILabel!
    
    @IBOutlet weak var add_button: UIButton!
    @IBOutlet weak var subtract_button: UIButton!
    
    @IBOutlet weak var text_field_number: UILabel!
    
    var current_index_clicked = 0
    
    @IBAction func when_add_pressed(_ sender: Any)
    {
        if(total_meats_selected < max_number_of_meats_to_select)
        {
           if let current_number_meat = text_field_number.text
            {
                if var current_number_meat_total = Int(current_number_meat)
                {
                    current_number_meat_total = current_number_meat_total + 1
                    meat_number_per_order[current_index_clicked] =
                        current_number_meat_total
                    
                    text_field_number.text =
                    String(current_number_meat_total)
                    total_meats_selected = total_meats_selected + 1
                }
            }
        }
    }
    
    
    @IBAction func when_subtract_pressed(_ sender: Any)
    {
        if let current_number_meat =
            text_field_number.text
        {
            if var current_number_meat_total =
                Int(current_number_meat)
            {
                if(current_number_meat_total > 0)
                {
                    current_number_meat_total = current_number_meat_total - 1
                    meat_number_per_order[current_index_clicked] =
                        current_number_meat_total
                    
                    text_field_number.text =
                        String(current_number_meat_total)
                    total_meats_selected = total_meats_selected - 1
                }
            }
        }
    }
}

class MeatsTableViewController: UITableViewController
{
    @IBAction func cancel_meat(_ sender: Any)
    {
        performSegue(withIdentifier: "cancel_meat", sender: self)
    }
    
    @IBAction func Done_Pressed(_ sender: Any)
    {
        // if the number of meats is not the required amount
        // for catering for the given number of guests chosen
        // then we need to let the user know via alert
        // and not allow them to perform segue to the select
        // juices
        if (total_meats_selected != max_number_of_meats_to_select)
        {
            let title   = "Invalid Number of Meats"
            let message = "Insufficient number of meats selected:" +
            String(total_meats_selected) + " of " + String(max_number_of_meats_to_select)
            displayAlert(a_title: title, a_message: message)
        }
        else
        {
            if(!should_show_full_menu)
            {
                performSegue(withIdentifier: "juice_menu", sender: self)
                
            }
            else
            {
               create_meat_info_string()
                performSegue(withIdentifier: "juice_menu", sender: self)
            }
        }
    }
    
    @IBOutlet weak var nav_item: UINavigationItem!
    
    @IBOutlet weak var done_nav: UIBarButtonItem!
    
    @IBAction func cancel_pressed(_ sender: Any)
    {
        if(!should_show_full_menu)
        {
            performSegue(
                withIdentifier:"cancel_meat_back_to_home",
                sender: self)
        }
        else
        {
            performSegue(
                withIdentifier:"cancel_meat_regular_user",
                sender: self)
        }
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
        if(!should_show_full_menu)
        {
            nav_item.title = "Meat Selection"
            done_nav.title = "Next"
        }
        else
        {
            nav_item.title = "Choice of " + String(max_number_of_meats_to_select) + " Meats"
            done_nav.title = "Done"
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
        return meat_name_array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? meatCell

        if let meat_cell = cell
        {
            meat_cell.current_index_clicked = indexPath.row
            meat_cell.meat_label.text = meat_name_array[indexPath.row]
            meat_cell.meat_image_view.image = meat_images[indexPath.row]
            meat_cell.text_field_number.text = String(meat_number_per_order[indexPath.row])
            meat_cell.text_field_number.layer.cornerRadius = 15
            
            if(!should_show_full_menu)
            {
                meat_cell.add_button.isHidden = true
                meat_cell.subtract_button.isHidden = true
                meat_cell.text_field_number.isHidden = true
            }
            else
            {
                meat_cell.add_button.isHidden = false
                meat_cell.subtract_button.isHidden = false
                meat_cell.text_field_number.isHidden = false
            }
            
            return meat_cell
        }
    
        return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return  110
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return false
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
    
    // we want to create a order info (meats)
    // string with new lines, and a nice way
    // of displaying the text when we go to
    // the checkout screen so the user can confirm their order
    func create_meat_info_string() -> Void
    {
        var index_of_meat  = 0
        var meat_number    = 1
        meats_ordered_string.removeAll()
        meats_ordered_string.append("MEATS ORDERED:")
        meats_ordered_string.append("\n")
        meats_ordered_string.append("-------------------------")
        meats_ordered_string.append("\n")
        for meat in meat_number_per_order
        {
            // meaning there was a meat ordered
            // for that specific meat
            // then we go look for the corresponding meat info
            if(meat > 0)
            {
                // we want the format to look like:
                /*
                 MEAT NUMBER x:
                   - MEAT KIND: y
                   - QUANTITY: z
                 ----------------
                 */
                meats_ordered_string.append("MEAT NUMBER ")
                meats_ordered_string.append(String(meat_number))
                meat_number = meat_number + 1
                meats_ordered_string.append(":")
                meats_ordered_string.append("\n")
                meats_ordered_string.append("  - MEAT KIND: ")
                meats_ordered_string.append(meat_name_array[index_of_meat])
                meats_ordered_string.append("\n")
                meats_ordered_string.append("  - QUANTITY: ")
            meats_ordered_string.append(String(meat_number_per_order[index_of_meat]))
                meats_ordered_string.append("\n")
                meats_ordered_string.append("\n")
            }
            index_of_meat  = index_of_meat + 1
        }
        meats_ordered_string.append("\n")
    } // func create_meat_info_string() -> Void
    
}
