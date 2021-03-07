//
//  ViewController.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 6/3/21.
//

import UIKit

class MyNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myNotesTable: UITableView!
    
    
    private let dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    
    var myNotes = [Note](
        arrayLiteral: Note(title: "Note de prueba", content: "Contenido de la nota", createAt: Date()),
        Note(title: "Note de prueba 2", content: "Contenido de la nota", createAt: Date()),
        Note(title: "Note de prueba 3", content: "Contenido de la nota", createAt: Date()),
        Note(title: "Note de prueba 4", content: "Contenido de la nota", createAt: Date())
    )
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myNotesTable.delegate = self
        myNotesTable.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCellView = myNotesTable.dequeueReusableCell(withIdentifier: "myNoteCell", for: indexPath)
        let myNote = myNotes[indexPath.row]
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
            print("Edit \(self.myNotes[indexPath.row].title)")
        }
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [editAction,deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print("didSelectRowAt \(self.myNotes[indexPath.row].title)")
        
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        print("performSegue \(identifier)")
        
    }
    
    
    private func onDeleteNote(noteIdx: Int) {
        let noteToDelete: Note = myNotes[noteIdx]
        
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

