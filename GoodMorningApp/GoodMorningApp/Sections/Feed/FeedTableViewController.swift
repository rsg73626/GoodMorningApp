//
//  FeedTableViewController.swift
//  GoodMorningApp
//
//  Created by Renan Soares Germano on 08/01/2018.
//  Copyright © 2018 Renan Soares Germano. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        var data: Data!
        
        let contact: Contact = Contact(content: "facebook.com/rsgermano1", type: .SocialNetwork)
        contact.id = 1
        let user: User = User(name: "Renan Soares Germano", email: "renan.rsg@hotmail.com", photo: "photoLink", about: "Renan, 20. Estudante de Ciência de Computação. Desenvolvedor iOS.", contacts: [contact])
        user.id = 1
        
        data = try! encoder.encode(user)
        
        var jsonDataString = String.init(data: data, encoding: .utf8)
        print("*** Encoded User ***\n\(jsonDataString!)")
        
        let userFromData: User = try! decoder.decode(User.self, from: data)
        print("*** Decoded User ***\n")
        print("\(userFromData)")
        
        let greeting: Greeting = Greeting(type: .GoodAfternoon, message: "Que você tenha uma tarde maravilhosa! :)", date: Date(), user: user)
        greeting.id = 1
        
        data = try! encoder.encode(greeting)
        
        jsonDataString = String.init(data: data, encoding: .utf8)
        print("*** Encoded Greeting ***\n\(jsonDataString)")
        
        let greetingFromData: Greeting = try! decoder.decode(Greeting.self, from: data)
        print("*** Decoded Greeting ***\n")
        print(greetingFromData)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "greeting", for: indexPath) as! GreetingTableViewCell

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
