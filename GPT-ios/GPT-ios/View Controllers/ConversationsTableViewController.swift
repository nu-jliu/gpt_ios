//
//  ConversationsTableViewController.swift
//  GPT-ios
//
//  Created by Jingkun Liu on 12/12/23.
//

import Foundation
import UIKit

class ConversationsTableViewCell: UITableViewCell {
    @IBOutlet weak var createdOn: UILabel!
    @IBOutlet weak var title: UILabel!
}

class ConversationsTableViewController: UITableViewController {
    
    var conversations = [Conversation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(<#T##@objc method#>))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.conversations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CONVERSATION_CELL_ID, for: indexPath) as! ConversationsTableViewCell
        
        return cell
    }
}
