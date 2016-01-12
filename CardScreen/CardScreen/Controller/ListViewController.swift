//
//  ListViewController.swift
//  CardScreen
//
//  Created by Alexander Lobanov on 12.01.16.
//  Copyright © 2016 Omega-R. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    private let cellTitleTag: Int = 100
    var listData: [CardItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.listData = CheckListProvider.data()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListDataItemIdentifier", forIndexPath: indexPath)

        let data = self.listData[indexPath.row]
        (cell.viewWithTag(cellTitleTag) as? UILabel)?.text = data.author

        return cell
    }
    
    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return self.tableView.indexPathForSelectedRow != nil
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let dvc: CardViewController = segue.destinationViewController as! CardViewController
        let idx = self.tableView.indexPathForSelectedRow?.row;
        dvc.card = self.listData[idx!]
    }

}
