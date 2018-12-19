//
//  ContactUsViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/16/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var owner_string = " @OWNER"

class MessageCell:UITableViewCell
{
    @IBOutlet weak var text_view: UITextView!
}

struct Post
{
    let body_text: String
    let is_owner:Bool
}


class ContactUsViewController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    @IBOutlet weak var user_entered_message_text_field: UITextField!
    @IBOutlet weak var table_view: UITableView!
    
    @IBOutlet weak var send_button: UIButton!
    
    @IBOutlet weak var nav_item: UINavigationItem!
    
    @IBOutlet weak var button_on_nav_item: UIBarButtonItem!
    
    @IBAction func when_nav_button_clicked(_ sender: Any)
    {
        if(we_are_owner)
        {
            self.performSegue(withIdentifier: "chat_to_conversations", sender: self)
        }
        else
        {
             self.performSegue(withIdentifier: "chat_page_to_home", sender: self)
        }
    }
    
    var posts = [Post]()
    
    @IBAction func sendMessage(_ sender: Any)
    {
        if let message = user_entered_message_text_field.text
        {
            // don't let anyone spam blanks
            if(!message.isEmpty)
            {
                let uid = Auth.auth().currentUser?.uid
                let db_ref = Database.database().reference()
                var bodyData: [String:Any] =
                [
                        "uid": uid,
                        "body_text": message
                ]
                
                if(!we_are_owner)
                {
                    db_ref.child("Posts").child("/\(Auth.auth().currentUser?.uid)/").childByAutoId().setValue(bodyData)
                }
                else
                {
                    // the owner is sending
                    var get_message = bodyData["body_text"] as? String
                    // store a key so we know who the owner is
                    // helps in color coordination
                    get_message?.append(owner_string)
                    
                    bodyData["body_text"] = get_message
                    
                    db_ref.child("Posts").child("/\(persons_clicked_on_uid)/").childByAutoId().setValue(bodyData)
                }
            }
        }
        user_entered_message_text_field.text?.removeAll()
    }
    
    override func viewDidLoad()
    {
        table_view.delegate = self
        table_view.dataSource = self
        self.hideKeyboardWhenTappedAround()
        table_view.separatorStyle = UITableViewCell.SeparatorStyle.none
    
        send_button.layer.cornerRadius = 15
        
        // if this is a regular user
        // then we want to show
        // that they are texting or chatting
        // rodeo's and a sign out button
        // which will sign them out and take them
        // to the home screen
        if(!we_are_owner)
        {
            self.nav_item.title = "RODEO'S"
            self.button_on_nav_item.title = "Sign out"
        }
        else
        {
            // if this is the owner
            // then we want to show
            // the username of who they are
            // communicating with
            // and instead of sign out
            // we want it to say
            // Back, which would take them
            // back to the conversations page
            // instead of signing them out
            self.nav_item.title = person_clicked_on_username
            self.button_on_nav_item.title = "Back"
        }
       
        // /\(FIRAuth.auth!.currentUser!.uid)/
        // /\(Auth.auth().currentUser?.uid)/
        // /\(persons_clicked_on_uid)/
        let db_ref = Database.database().reference()

        // if the owner is logged in
        // and has clicked on a persons
        // chat they will see the whole chat
        // between the two users
        // and we want to read specifically from the
        // person's clicked on database, because that is
        // where we are writing to for the whole chat
        if(we_are_owner)
        {
            db_ref.child("Posts").child("/\(persons_clicked_on_uid)/").queryOrderedByKey().observe(.childAdded, with:
                
            {
                snapshot in
                
                var body_message =
                {
                    (snapshot.value as? NSDictionary)?["body_text"] as? String ?? ""
                }()
                
                if(!body_message.contains(owner_string))
                {
                    self.posts.insert( Post(body_text: body_message, is_owner: true), at: 0)
                    self.table_view.reloadData()
                }
                else
                {
                    // mark so we know this is the owner
                    // and we can change text color or background color
                    // and remove the corresponding flag/string we are looking for
                    body_message = body_message.replacingOccurrences(of: owner_string, with: "")
                    self.posts.insert( Post(body_text: body_message, is_owner: false), at: 0)
                    self.table_view.reloadData()
                }
            })
        }
        else
        {
            db_ref.child("Posts").child("/\(Auth.auth().currentUser?.uid)/").queryOrderedByKey().observe(.childAdded, with:
                
                {
                    snapshot in
                    
                    var body_message =
                    {
                        (snapshot.value as? NSDictionary)?["body_text"] as? String ?? ""
                    }()
        
                    if(!body_message.contains(owner_string))
                    {
                        self.posts.insert( Post(body_text: body_message, is_owner: false), at: 0)
                        self.table_view.reloadData()
                    }
                    else
                    {
                        // mark so we know this is the owner
                        // and we can change text color or background color
                        // and remove the corresponding flag/string we are looking for
                        body_message = body_message.replacingOccurrences(of: owner_string, with: "")
                        self.posts.insert( Post(body_text: body_message, is_owner: true), at: 0)
                        self.table_view.reloadData()
                    }
            })
        }
        
        table_view.reloadData()
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = table_view.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageCell
        {
            cell.text_view.text = posts[indexPath.row].body_text
            if(posts[indexPath.row].is_owner)
            {
                cell.text_view.textColor =
                    UIColor.init(
                        red: (26/255),
                        green: (120/255),
                        blue: (194/255),
                        alpha: 1)
                cell.text_view.textAlignment = .left

            }
            else
            {
                cell.text_view.textColor =
                    UIColor.init(
                        red: (255/255),
                        green: (255/255),
                        blue: (255/255),
                        alpha: 1)
                
                cell.text_view.textAlignment = .right
            }
            
            return cell
        }
        
        return table_view.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}
