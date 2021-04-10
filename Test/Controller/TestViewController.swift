//
//  TestViewController.swift
//  Test
//
//  Created by Prince Alvin Yusuf on 08/04/21.
//

import UIKit

class TestViewController: UITableViewController {
    
    
    var fakeManager = FakeManager()
    var result: FakeModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fakeManager.fetchData()
        fakeManager.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return result?.id.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        if let safeResult = self.result {
            cell.textLabel?.text = safeResult.body[indexPath.row]
        }
        
        
        return cell
    }
    
}

extension TestViewController: FakeManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    func updateData(_ fakeManager: FakeManager, fakeModel: FakeModel) {
        
        
        DispatchQueue.main.async {
            self.result = fakeModel
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    
    @IBAction func optionsPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Test", message: "Choose One", preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Fetch Data", style: .default) { (action) in
            
            DispatchQueue.main.async {
                self.fakeManager.fetchData()
                self.tableView.reloadData()
            }
        }
        
        let action2 = UIAlertAction(title: "Post Data", style: .default) { (action) in
            self.fakeManager.postData()
        }
        
        let action3 = UIAlertAction(title: "Delete Data", style: .default) { (action) in
            self.fakeManager.deleteData()
        }
        
        let action4 = UIAlertAction(title: "Update Data", style: .default) { (action) in
            self.fakeManager.putData()
        }
        
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        present(alert, animated: true, completion: nil)
    }
    
}

