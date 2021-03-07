//
//  MyNotesViewModel.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 7/3/21.
//

import Foundation

class MyNotesViewModel {
    
    private(set) var myNotes: [Note] = []

    
    func getNotes(with callback: @escaping (ResultEnum) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.myNotes = self.getMyNotesFromDB()
            callback(ResultEnum.success(myNotes: self.myNotes))
        }
    }
    
    enum ResultEnum {
        case success(myNotes: [Note])
        case error(ex: NSException)
    }
    
    /**
        Private Methods
     */
    
    private func getMyNotesFromDB() -> [Note] {
        
        return [Note](
            arrayLiteral:  Note(title: "Note de prueba", content: "Contenido de la nota", createAt: Date()),
            Note(title: "Note de prueba 2", content: "Contenido de la nota", createAt: Date()),
            Note(title: "Note de prueba 3", content: "Contenido de la nota", createAt: Date()),
            Note(title: "Note de prueba 4", content: "Contenido de la nota", createAt: Date())
        )
        
    }
    
    
}
