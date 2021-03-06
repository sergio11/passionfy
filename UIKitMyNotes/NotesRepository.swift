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
     Private Methods
     */
    
    private func getContext() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
}
