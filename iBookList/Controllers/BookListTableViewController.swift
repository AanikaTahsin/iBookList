//
//  BookListTableViewController.swift
//  iBookList
//
//  Created by Anika Tahsin Chowdhury on 21/3/23.
//

import UIKit

class BookListTableViewController: UITableViewController {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var bookList: [Books] = []
    var selectedBookDetails: Books? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book List"
        self.fetchBookList()
    }
    
    func fetchBookList() {
        BookManager.sharedBookManager().getBookList(completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let data = data {
                    print(data)
                    self.bookList = data
                    self.loadingView.isHidden = true
                    self.tableView.reloadData()
                }
            })
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        
        cell.textLabel?.text = self.bookList[indexPath.row].title
        cell.detailTextLabel?.text = "Author: \(self.bookList[indexPath.row].author)"
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBookDetails = self.bookList[indexPath.row]
        performSegue(withIdentifier: "selectedBookSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nevController: UINavigationController = segue.destination as! UINavigationController
        let bookDetailsVC : BookDetailsTableViewController = nevController.topViewController as! BookDetailsTableViewController
        bookDetailsVC.id = self.selectedBookDetails?.id
        bookDetailsVC.fetchBookDetails()
    }

}
