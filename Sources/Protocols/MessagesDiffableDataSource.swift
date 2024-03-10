//
//  MessagesDiffableDataSource.swift
//  
//
//  Created by Dom Tillman on 2/11/24.
//

import Foundation
import UIKit

public struct MessageSection: Hashable {
    
    public var date: Date
    public var identifier: String
    
    public init(date: Date, identifier: String? = nil) {
        self.date = date
        self.identifier = identifier ?? date.description
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        hasher.combine(identifier)
    }
    
}

public struct MessageTypeItem: Hashable {
    
    public var message: any MessageType
    
    public init(message: any MessageType) {
        self.message = message
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(message.messageId)
        hashValueForKind(into: &hasher)
    }
    
    public func hashValueForKind(into hasher: inout Hasher) {
        switch message.kind {
        case .text(let string):
            hasher.combine(string)
        case .attributedText(let nsAttributedString):
            hasher.combine(nsAttributedString)
        case .photo(let mediaItem):
            hasher.combine(mediaItem.url ?? URL(string: String()))
        case .video(let mediaItem):
            hasher.combine(mediaItem.placeholderImage)
        case .location(let locationItem):
            hasher.combine(locationItem.location)
        case .emoji(let string):
            hasher.combine(string)
        case .audio(let audioItem):
            hasher.combine(audioItem.url)
        case .contact(let contactItem):
            hasher.combine(contactItem.displayName)
        case .linkPreview(let linkItem):
            hasher.combine(linkItem.url)
        case .custom(let any):
            hasher.combine(Int.bitWidth)
        }
    }
    
    public static func == (lhs: MessageTypeItem, rhs: MessageTypeItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

public protocol MessagesDiffableDataSource: MessagesDataSource {
    
    var diffableDataSource: UICollectionViewDiffableDataSource<MessageSection, MessageTypeItem> { get set }
    
    func provideCellConfiguration(in collectionView: UICollectionView, at section: IndexPath, for item: MessageTypeItem) -> UICollectionViewCell?
    
    func provideSupplementaryCellConfiguration(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView?
    
    func configureDataSource(in messagesCollectionView: MessagesCollectionView)
    
}

public extension MessagesDiffableDataSource {
    
    func configureDataSource(in messagesCollectionView: MessagesCollectionView) {
        
        diffableDataSource = UICollectionViewDiffableDataSource(
            collectionView: messagesCollectionView as UICollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let item = self.provideCellConfiguration(
                in: collectionView,
                at: indexPath,
                for: itemIdentifier
            )
            return item
        })
        
        diffableDataSource.supplementaryViewProvider = { (collectionView, identifier, indexPath) in
            let configuration = self.provideSupplementaryCellConfiguration(
                collectionView, 
                viewForSupplementaryElementOfKind: identifier,
                at: indexPath
            )
            return configuration
        }
    }
    
    func provideCellConfiguration(
        in collectionView: UICollectionView,
        at section: IndexPath,
        for item: MessageTypeItem) -> UICollectionViewCell? {
            
            guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
                return nil
            }
            
            if messagesCollectionView.isSectionReservedForTypingIndicator(section.section)   {
                return typingIndicator(at: section, in: messagesCollectionView)
            }
            
            let message = item.message
            
            switch message.kind {
            case .text, .attributedText, .emoji:
                if let cell = textCell(for: message, at: section, in: messagesCollectionView) {
                    return cell
                } else {
                    let cell = messagesCollectionView.dequeueReusableCell(TextMessageCell.self, for: section)
                    cell.configure(with: message, at: section, and: messagesCollectionView)
                    return cell
                }
            case .photo, .video:
                if let cell = photoCell(for: message, at: section, in: messagesCollectionView) {
                    return cell
                } else {
                    let cell = messagesCollectionView.dequeueReusableCell(MediaMessageCell.self, for: section)
                    cell.configure(with: message, at: section, and: messagesCollectionView)
                    return cell
                }
            case .location:
                if let cell = locationCell(for: message, at: section, in: messagesCollectionView) {
                    return cell
                } else {
                    let cell = messagesCollectionView.dequeueReusableCell(LocationMessageCell.self, for: section)
                    cell.configure(with: message, at: section, and: messagesCollectionView)
                    return cell
                }
            case .audio:
                if let cell = audioCell(for: message, at: section, in: messagesCollectionView) {
                    return cell
                } else {
                    let cell = messagesCollectionView.dequeueReusableCell(AudioMessageCell.self, for: section)
                    cell.configure(with: message, at: section, and: messagesCollectionView)
                    return cell
                }
            case .contact:
                if let cell = contactCell(for: message, at: section, in: messagesCollectionView) {
                    return cell
                } else {
                    let cell = messagesCollectionView.dequeueReusableCell(ContactMessageCell.self, for: section)
                    cell.configure(with: message, at: section, and: messagesCollectionView)
                    return cell
                }
            case .linkPreview:
                let cell = messagesCollectionView.dequeueReusableCell(LinkPreviewMessageCell.self, for: section)
                cell.configure(with: message, at: section, and: messagesCollectionView)
                return cell
            case .custom:
                return customCell(for: message, at: section, in: messagesCollectionView)
            }
    }
    
    func provideSupplementaryCellConfiguration(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView? {
        
        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return displayDelegate.messageHeaderView(for: indexPath, in: messagesCollectionView)
        case UICollectionView.elementKindSectionFooter:
            return displayDelegate.messageFooterView(for: indexPath, in: messagesCollectionView)
        default:
            return nil
        }
    }
    
}

