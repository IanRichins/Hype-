//
//  HypeListViewController.swift
//  Hype!
//
//  Created by Ian Richins on 5/10/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import UIKit

class HypeListViewController: UIViewController {
    
    var refresh = UIRefreshControl()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUpViews()
    }
    
    @IBAction func addHypeButtonTapped(_ sender: Any) {
    }
    
    
   @objc func loadData(){
        HypeController.sharedInstance.fetchHype { (success) in
            if success {
                self.updateViews()
            }
        }
    }
    
    func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        refresh.attributedTitle = NSAttributedString(string: "pull to see more Hypes!")
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
    
    func presentAddHypeAlert() {
        let alert = UIAlertController(title: "Get Hype", message: "What is Hype may never die!", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "what is hype today?"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addHypeAction = UIAlertAction(title: "Send", style: .default) { (_) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            
            HypeController.sharedInstance.saveHype(with: text) { (success) in
                if success {
                    self.updateViews()
                }
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addHypeAction)
        
        self.present(alert, animated: true)
    }
}

extension HypeListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HypeController.sharedInstance.hypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hypeCell", for: indexPath)
        
        let hype = HypeController.sharedInstance.hypes[indexPath.row]
        
        cell.textLabel?.text = hype.body
        cell.detailTextLabel?.text = hype.timeStamp.stringValue()
        
        return cell
    }
    
    
}
