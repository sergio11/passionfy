//
//  SaveNoteViewController.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 7/3/21.
//

import UIKit

class SaveNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSave(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    


}
