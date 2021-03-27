//
//  NotesRepository.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 6/3/21.
//

import Foundation
import CoreData
import UIKit

class NotesRepository {
    
    public static let shared = NotesRepository()
    
    
    /**
            Save a note
     */
    func save(note: Note) throws -> Note  {
        
        let context = getContext()
        let noteEntity = NSEntityDescription.insertNewObject(forEntityName: "NoteEntity", into: context) as! NoteEntity
        
        noteEntity.title = note.title
        noteEntity.content = note.content
        //noteEntity.priority = note.priority
        noteEntity.creationDate = note.createAt
    
    
        do {
            try context.save()
            print("Note saved")
            return note
        } catch let error as NSError {
            print("Error when save a note", error.localizedDescription)
            throw RepositoryException()
        }
        
    }
    
    
    /**
     Private Methods
     */
    
    private func getContext() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
}
