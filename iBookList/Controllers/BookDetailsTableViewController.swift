//
//  BookDetailsTableViewController.swift
//  iBookList
//
//  Created by Anika Tahsin Chowdhury on 23/3/23.
//

import UIKit

class BookDetailsTableViewController: UITableViewController {
    @IBOutlet weak var loadingData: UIActivityIndicatorView!

    private let numberOfDetails = 5
    var id: Int!
    var contentSize: CGFloat = 0
    var bookDetails: BookDetails?
    var showText: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Record Details"
        DispatchQueue.main.async {
            var frame = self.tableView.frame;
            frame.size.height = self.tableView.contentSize.height;
            self.tableView.frame = frame
        }
    }
    

    func fetchBookDetails() {
        BookManager.sharedBookManager().getBookDetails(id , completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let data = data {
                    self.bookDetails = data
                }
                self.showText = true
                self.loadingData.isHidden = true
                self.tableView.reloadData()
            })
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booktitle", for: indexPath)
        if showText == true {
            cell.textLabel?.isHidden = false
        }
        
        if let detail = self.bookDetails {
            cell.textLabel?.text = """
                        Title: \(String(describing: detail.title))
                        
                        Author: \(String(describing: detail.author))
                        
                        Description: \(String(describing: detail.description))
                        
                        ISBN: \(String(describing: detail.isbn))
                        
                        Price: \(String(describing: detail.price)) \(String(describing: detail.currencyCode))
                        """
            return cell
        }
        cell.textLabel?.text = """
                               Sorry, Unexpected Error Retrieving book details
                               """
        return cell
    }

}
