// MIT License
//
// Copyright (c) 2017-2022 MessageKit
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import UIKit

// MARK: - MessagesLayoutDelegate

/// A protocol used by the `MessagesCollectionViewFlowLayout` object to determine
/// the size and layout of a `MessageCollectionViewCell` and its contents.
public protocol MessagesLayoutDelegate: AnyObject {
  /// Specifies the size to use for a header view.
  ///
  /// - Parameters:
  ///   - section: The section number of the header.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this header will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is a size of `GGSize.zero`.
  func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize

  /// Specifies the size to use for a footer view.
  ///
  /// - Parameters:
  ///   - section: The section number of the footer.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this footer will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is a size of `GGSize.zero`.
  func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize

  /// Specifies the size to use for a typing indicator view.
  ///
  /// - Parameters:
  ///   - layout: The `MessagesCollectionViewFlowLayout` layout.
  ///
  /// - Note:
  ///   The default value returned by this method is the width of the `messagesCollectionView` minus insets and a height of 62.
  func typingIndicatorViewSize(for layout: MessagesCollectionViewFlowLayout) -> CGSize

  /// Specifies the top inset to use for a typing indicator view.
  ///
  /// - Parameters:
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this view will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is a top inset of 15.
  func typingIndicatorViewTopInset(in messagesCollectionView: MessagesCollectionView) -> CGFloat

  /// Specifies the height for the `MessageContentCell`'s top label.
  ///
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is zero.
  func cellTopLabelHeight(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView)
    -> CGFloat

  /// Specifies the height for the `MessageContentCell`'s bottom label.
  ///
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is zero.
  func cellBottomLabelHeight(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CGFloat

  /// Specifies the height for the message bubble's top label.
  ///
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is zero.
  func messageTopLabelHeight(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CGFloat

  /// Specifies the label alignment for the message bubble's top label.
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView:  The `MessagesCollectionView` in which this cell will be displayed.
  /// - Returns: Optional LabelAlignment for the message bubble's top label. If nil is returned or the delegate method is not implemented,
  ///  alignment from MessageSizeCalculator will be used depending if the message is outgoing or incoming
  func messageTopLabelAlignment(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> LabelAlignment?

  /// Specifies the height for the `MessageContentCell`'s bottom label.
  ///
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default value returned by this method is zero.
  func messageBottomLabelHeight(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CGFloat

  /// Specifies the label alignment for the message bubble's bottom label.
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView:  The `MessagesCollectionView` in which this cell will be displayed.
  /// - Returns: Optional LabelAlignment for the message bubble's bottom label. If nil is returned or the delegate method is not implemented,
  ///  alignment from MessageSizeCalculator will be used depending if the message is outgoing or incoming
  func messageBottomLabelAlignment(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> LabelAlignment?

  /// Specifies the size for the `MessageContentCell`'s avatar image view.
  /// - Parameters:
  ///   - message: The `any MessageType` that will be displayed for this cell.
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  /// - Returns: Optional CGSize for the avatar image view. If nil is returned or delegate method is not implemented,
  /// size from `MessageSizeCalculator`'s `incomingAvatarSize` or `outgoingAvatarSize` will be used depending if the message is outgoing or incoming
  func avatarSize(for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView)
    -> CGSize?

  /// Text cell size calculator for messages with any MessageType.text.
  ///
  /// - Parameters:
  ///   - message: The text message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.text.
  func textCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Attributed text cell size calculator for messages with any MessageType.attributedText.
  ///
  /// - Parameters:
  ///   - message: The attributedText message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.attributedText.
  func attributedTextCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Emoji cell size calculator for messages with any MessageType.emoji.
  ///
  /// - Parameters:
  ///   - message: The emoji message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.emoji.
  func emojiCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Photo cell size calculator for messages with any MessageType.photo.
  ///
  /// - Parameters:
  ///   - message: The photo message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.text.
  func photoCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Video cell size calculator for messages with any MessageType.video.
  ///
  /// - Parameters:
  ///   - message: The video message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.video.
  func videoCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Location cell size calculator for messages with any MessageType.location.
  ///
  /// - Parameters:
  ///   - message: The location message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.location.
  func locationCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Audio cell size calculator for messages with any MessageType.audio.
  ///
  /// - Parameters:
  ///   - message: The audio message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.audio.
  func audioCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Contact cell size calculator for messages with any MessageType.contact.
  ///
  /// - Parameters:
  ///   - message: The contact message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with any MessageType.contact.
  func contactCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?

  /// Custom cell size calculator for messages with any MessageType.custom.
  ///
  /// - Parameters:
  ///   - message: The custom message
  ///   - indexPath: The `IndexPath` of the cell.
  ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
  ///
  /// - Note:
  ///   The default implementation will throw fatalError(). You must override this method if you are using messages with any MessageType.custom.
  func customCellSizeCalculator(
    for message: any MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator
}

extension MessagesLayoutDelegate {
  public func headerViewSize(for _: Int, in _: MessagesCollectionView) -> CGSize {
    .zero
  }

  public func footerViewSize(for _: Int, in _: MessagesCollectionView) -> CGSize {
    .zero
  }

  public func typingIndicatorViewSize(for layout: MessagesCollectionViewFlowLayout) -> CGSize {
    let collectionViewWidth = layout.messagesCollectionView.bounds.width
    let contentInset = layout.messagesCollectionView.contentInset
    let inset = layout.sectionInset.horizontal + contentInset.horizontal
    return CGSize(width: collectionViewWidth - inset, height: 62)
  }

  public func typingIndicatorViewTopInset(in _: MessagesCollectionView) -> CGFloat {
    15
  }

  public func cellTopLabelHeight(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    0
  }

  public func cellBottomLabelHeight(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    0
  }

  public func messageTopLabelHeight(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    0
  }

  public func messageTopLabelAlignment(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> LabelAlignment? {
    nil
  }

  public func messageBottomLabelHeight(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGFloat {
    0
  }

  public func avatarSize(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGSize? {
    nil
  }

  public func messageBottomLabelAlignment(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> LabelAlignment?
  {
    nil
  }

  public func textCellSizeCalculator(for _: any MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CellSizeCalculator? {
    nil
  }

  public func attributedTextCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func emojiCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func photoCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func videoCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func locationCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func audioCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func contactCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator?
  {
    nil
  }

  public func customCellSizeCalculator(
    for _: any MessageType,
    at _: IndexPath,
    in _: MessagesCollectionView)
    -> CellSizeCalculator
  {
    fatalError("Must return a CellSizeCalculator for MessageKind.custom(Any?)")
  }
}
