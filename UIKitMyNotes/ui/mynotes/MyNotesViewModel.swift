//
//  MyNotesViewModel.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 7/3/21.
//

import Foundation

class MyNotesViewModel {
    
    
    fileprivate let notesRepository = NotesRepository.shared
    
    private(set) var myNotes: [Note] = []

    
    func getNotes(completionBlock: @escaping (Result<[Note], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.myNotes = self.getMyNotesFromDB()
            completionBlock(.success(self.myNotes))
        }
    }
    
    func saveNote(note: Note, completionBlock: (Result<Note, Error>) -> Void) {
        do {
            let noteSaved = try notesRepository.save(note: note)
            completionBlock(.success(noteSaved))
        } catch let error {
            completionBlock(.failure(error))
        }
        
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
