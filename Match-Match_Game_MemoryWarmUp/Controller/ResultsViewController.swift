//
//  ResultsViewController.swift
//  Match-Match_Game_MemoryWarmUp
//
//  Created by Rustam Shorov on 02.01.2019.
//  Copyright © 2019 Rustam Shorov. All rights reserved.
//

import UIKit
import RealmSwift

class ResultsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users: Results<User>!
    
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = RealmService.shared.realm
        users = realm.objects(User.self)
        
       notificationToken = realm.observe { (notification, realm) in
            self.tableView.reloadData()
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
    }
    
}

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(with: user)

        return cell
    }
    
    
}
