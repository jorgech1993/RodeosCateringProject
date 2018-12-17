//
//  OwnerTableViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/16/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var persons_clicked_on_uid:String? = ""
var person_clicked_on_username:String? = ""

struct User
{
    let user_name:String?
    let user_id:String?
}

class UserCell:UITableViewCell
{
    @IBOutlet weak var name: UILabel!
}

 var users = [User]()

class OwnerTableViewController: UITableViewController
{
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UserCell
        {
            cell.name.text = users[indexPath.row].user_name
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let user_clicked_on = users[indexPath.row]
        persons_clicked_on_uid = user_clicked_on.user_id
        person_clicked_on_username = user_clicked_on.user_name
        self.performSegue(withIdentifier: "owner_to_chat_page", sender: self)
    }
}
