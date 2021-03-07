//
//  ViewController.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 6/3/21.
//

import UIKit

class MyNotesViewController: UIViewController {
    
    @IBOutlet weak var myNotesTable: UITableView!
    
    /// Spinner shown during load the TableView
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return spinner
    }()
    
    /// Text shown during load the TableView
    private var loadingLabel : UILabel =  {
        let loadingLabel = UILabel()
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading Notes ..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 190, height: 30)
        return loadingLabel
    }()
    /// View which contains the loading text and the spinner
    private let loadingView = UIView()
    
    
    private let viewModel = MyNotesViewModel()
    
    private let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNotesTable.delegate = self
        myNotesTable.dataSource = self
        showLoadingScreen()
        onLoadData()
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        print("performSegue \(identifier)")
        
    }
    
    
    // MARK: Private methods
    
    // Load data in the tableView
    private func onLoadData() {
        viewModel.getNotes(with: { [weak self] result in
            self?.myNotesTable.reloadData()
            self?.myNotesTable.separatorStyle = .singleLine
            self?.removeLoadingScreen()
        })
    }
    
    private func showLoadingScreen() {
        myNotesTable.separatorStyle = .none
        spinner.startAnimating()
        let width: CGFloat = 170
        let height: CGFloat = 30
        let x = (myNotesTable.frame.width / 2) - (width / 2)
        let y = (myNotesTable.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        myNotesTable.addSubview(loadingView)
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        loadingView.isHidden = true
    }
    
    // Delete note at index
    private func onDeleteNote(noteIdx: Int) {
        let noteToDelete: Note = viewModel.myNotes[noteIdx]
        let alertViewController = UIAlertController(title: "Would you like to delete this note?", message: "The note  \"\(noteToDelete.title)\" will be delete", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
            print("Delete note")
        })
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            print("Delete note was cancel")
            self.myNotesTable.reloadRows(at: [IndexPath(row: noteIdx, section: 0)], with: .right)
        })
        present(alertViewController, animated: true, completion: nil)
    }

}

extension MyNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCellView = myNotesTable.dequeueReusableCell(withIdentifier: "myNoteCell", for: indexPath)
        let myNote = viewModel.myNotes[indexPath.row]
        tableCellView.textLabel?.text = myNote.title
        tableCellView.detailTextLabel?.text = dateFormatter.string(from: myNote.createAt)
        return tableCellView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Borrar") { (_, _, _) in
            self.onDeleteNote(noteIdx: indexPath.row)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let editAction = UIContextualAction(style: .normal, title: "Editar") { (_, _, _) in
            print("Edit \(self.viewModel.myNotes[indexPath.row].title)")
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [editAction,deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(self.viewModel.myNotes[indexPath.row].title)")
    }
    
}

