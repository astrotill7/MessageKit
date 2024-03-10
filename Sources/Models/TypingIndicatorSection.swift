//
//  TypingIndicatorSection.swift
//  
//
//  Created by Dom Tillman on 3/9/24.
//

import Foundation
import UIKit

struct TypingSender: SenderType {
    var senderId: String = String()
    var displayName: String = String()
}

struct TypingIndicatorItem: MessageType {
    var sender: any SenderType = TypingSender()
    var messageId: String = String()
    var sentDate: Date = Date()
    var kind: MessageKind = .custom(nil)
}

internal struct TypingIndicatorSection {
    
    internal static let identifier = "typingIndicator"
    
    let section: MessageSection
    let items: [MessageTypeItem]
    
    internal static var shared: TypingIndicatorSection = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let date = formatter.date(from: "08/05/2009") ?? Date()
        return TypingIndicatorSection(
            section: MessageSection(date: date, identifier: identifier),
            items: [MessageTypeItem(message: TypingIndicatorItem())]
        )
    }()
}
