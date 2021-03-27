//
//  Note.swift
//  UIKitMyNotes
//
//  Created by Sergio Sánchez Sánchez on 6/3/21.
//

import Foundation

class Note {
    
    private(set) var title: String
    private(set) var content: String
    private(set) var createAt: Date
    private(set) var priority: NotePriorityEnum
    
    init(title: String, content: String, createAt: Date, priority: NotePriorityEnum = NotePriorityEnum.LOW) {
        self.title = title
        self.content = content
        self.createAt = createAt
        self.priority = priority
    }

    enum NotePriorityEnum {
        case LOW
        case MEDIUM
        case HIGHT
        
        static func of(ordinal: Int) -> NotePriorityEnum {
            let priorityEnum: NotePriorityEnum
            switch ordinal {
                case 0: priorityEnum = NotePriorityEnum.LOW
                case 1: priorityEnum = NotePriorityEnum.MEDIUM
                default: priorityEnum = NotePriorityEnum.HIGHT
            }
            return priorityEnum;
        }
        
    }
    
}
