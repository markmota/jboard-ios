//
//  CardCollectionView.swift
//  jboard
//
//  Created by Luis Ezcurdia on 2/7/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class PageCollectionView: UIView {
    let cellId = "pageCell"
    var buttons: [PageBarButtonItem] = [] {
        didSet{
            var items = [UIBarButtonItem]()
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            for button in buttons {
                button.action = #selector(moveToPage)
                items.append(button)
                items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            }
            toolbar.items = items
        }
    }
    
    var cards: [UIView] = [] {
        didSet {
            pageControl.numberOfPages = cards.count
        }
    }
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = Theme.Colors.sectionHeader.color
        toolbar.tintColor = Theme.Colors.background.color
        return toolbar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .red
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = Theme.Colors.darkBackground.color
        control.numberOfPages = self.cards.count
        return control
    }()

    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(44)
        }
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.toolbar.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func moveToPage(_ sender: PageBarButtonItem) {
        scrollTo(page: sender.page)
    }
    
    func scrollTo(page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        updateCurrent(page: page)
    }
    
    func updateCurrent(page: Int) {
        pageControl.currentPage = page
        for button in buttons {
            button.isEnabled = button.page != page
        }
    }
}

extension PageCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let card = cards[indexPath.row]
        cell.addSubview(card)
        card.snp.makeConstraints { make in
            make.top.equalTo(cell.snp.top)
            make.left.equalTo(cell.snp.left)
            make.right.equalTo(cell.snp.right)
            make.bottom.equalTo(cell.snp.bottom)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / self.frame.width)
        updateCurrent(page: pageNumber)
    }
}
