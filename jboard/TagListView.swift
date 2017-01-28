//
//  TagListView.swift
//  jboard
//
//  Created by Luis Ezcurdia on 11/27/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

import UIKit

class TagListView: UIScrollView {
    var numberOfRows = 0
    var currentRow = 0
    var tags = [TagLabel]()

    var hashtagsOffset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
    var rowHeight: CGFloat = 30 //height of rows
    var tagHorizontalPadding: CGFloat = 5.0 // padding between tags horizontally
    var tagVerticalPadding: CGFloat = 2.0 // padding between tags vertically
    var tagCombinedMargin: CGFloat = 10.0 // margin of left and right combined, text in tags are by default centered.

    var target: AnyObject?
    var tapAction: Selector?
    var longPressAction: Selector?

    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfRows = Int(frame.height / rowHeight)
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func addTag(_ text: String) {
        self.addTag(withText: text, color: Theme.Colors.background.color)
    }

    func addTag(withText text: String, color: UIColor) {
        let label = TagLabel()
        label.setup(text: text, color: color)
        label.setupGestureActions(forTarget: target, tapAction: tapAction, longPressAction: longPressAction)
        self.tags.append(label)

        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width + tagCombinedMargin, height: rowHeight - tagVerticalPadding)
        if self.tags.count == 0 {
            label.frame = CGRect(x: hashtagsOffset.left,
                                 y: hashtagsOffset.top,
                                 width: label.frame.width,
                                 height: label.frame.height)
        } else {
            label.frame = self.generateFrameAt(index: tags.count-1, rowNumber: &currentRow)
        }
        self.addSubview(label)
    }

    func reset() {
        for tag in tags {
            tag.removeFromSuperview()
        }
        tags = []
        currentRow = 0
        numberOfRows = 0
    }

    func removeTagWith(name: String) {
        for (index, tag) in tags.enumerated() {
            if tag.text! == name {
                removeTagWith(index: index)
            }
        }
    }

    func removeTagWith(index: Int) {
        if index > tags.count - 1 {
            print("ERROR: Tag Index \(index) Out of Bounds")
            return
        }
        tags[index].removeFromSuperview()
        tags.remove(at: index)
        layoutTagsFromIndex(index)
    }

    func removeMultipleTagsWithIndices(_ indexSet: Set<Int>) {
        let sortedArray = Array(indexSet).sorted()
        for index in sortedArray {
            if index > tags.count - 1 {
                print("ERROR: Tag Index \(index) Out of Bounds")
                continue
            }
            tags[index].removeFromSuperview()
            tags.remove(at: index)
        }
        layoutTagsFromIndex(sortedArray.first!)
    }

    fileprivate func layoutTagsFromIndex(_ index: Int, animated: Bool = true) {
        if tags.count == 0 { return }
        let animation:()->Void = {
                var rowNumber = self.getRowNumber(index)
                for i in index...self.tags.count - 1 {
                    self.tags[i].frame = self.generateFrameAt(index: i, rowNumber: &rowNumber)
                }
        }
        UIView.animate(withDuration: 0.3, animations: animation)
    }

    fileprivate func getRowNumber(_ index: Int) -> Int {
        return Int((tags[index].frame.origin.y - hashtagsOffset.top)/rowHeight)
    }

    fileprivate func generateFrameAt(index: Int, rowNumber: inout Int) -> CGRect {
        var newPoint = self.getPositionForIndex(index, rowNumber: rowNumber)
        if (newPoint.x + self.tags[index].frame.width) >= self.frame.width {
            rowNumber += 1
            newPoint = CGPoint(x: self.hashtagsOffset.left, y: CGFloat(rowNumber) * rowHeight + self.hashtagsOffset.top)
        }
        self.isOutofBounds(newPoint, labelFrame: self.tags[index].frame)
        return CGRect(x: newPoint.x, y: newPoint.y, width: self.tags[index].frame.width, height: self.tags[index].frame.height)
    }

    func getPositionForIndex(_ index: Int, rowNumber: Int) -> CGPoint {
        if index == 0 {
            return CGPoint(x: hashtagsOffset.left, y: hashtagsOffset.top)
        }
        let y = CGFloat(rowNumber) * self.rowHeight + hashtagsOffset.top
        let lastTagFrame = tags[index-1].frame
        let x = lastTagFrame.origin.x + lastTagFrame.width + tagHorizontalPadding
        return CGPoint(x: x, y: y)
    }

    fileprivate func isOutofBounds(_ newPoint: CGPoint, labelFrame: CGRect) {
        let bottomYLimit = newPoint.y + labelFrame.height
        if bottomYLimit > self.contentSize.height {
            self.contentSize = CGSize(width: self.contentSize.width, height: self.contentSize.height + rowHeight - tagVerticalPadding)
        }
    }

}
