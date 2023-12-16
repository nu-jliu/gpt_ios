//
//  Conversation.swift
//  GPT-ios
//
//  Created by Jingkun Liu on 12/13/23.
//

import Foundation

class Conversation {
    var title: String
    var created_on: String
    
    init(title: String, created_on: String) {
        self.title = title
        self.created_on = created_on
    }
}
