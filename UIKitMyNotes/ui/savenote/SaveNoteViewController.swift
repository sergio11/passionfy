//
//  SaveNoteViewController.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 7/3/21.
//

import UIKit

class SaveNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    private let viewModel = MyNotesViewModel()
    
    
    @IBAction func onSave(_ sender: Any) {
        
    
        let newNote = Note(
            title: titleTextField.text ?? "", content: contentTextView.text, createAt: Date(), priority:
                Note.NotePriorityEnum.of(ordinal: prioritySegmentedControl.selectedSegmentIndex)
        )
        
        viewModel.saveNote(note: newNote, completionBlock:{ [weak self] (result) in
            switch result {
                case .success(let note):
                    self?.onNoteSaved(note: note)
                case .failure(let accountError):
                    self?.onShowError(message: accountError.localizedDescription)
            }
        })
        
    
    }
    
    private func onNoteSaved(note: Note) {
        
        let alertViewController = UIAlertController(title: "Note Saved Successfully", message: "The note  \"\(note.title)\" has been save successfully", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        })
        present(alertViewController, animated: true, completion: nil)
        
    }
    
    private func onShowError(message: String) {
        let alertViewController = UIAlertController(title: "An Error ocurred", message: "An error ocurred when save the note", preferredStyle: .alert)
        present(alertViewController, animated: true, completion: nil)
        
    }
        

}
