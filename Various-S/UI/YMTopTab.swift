//
//  YMTopTab.swift
//  Various-S
//
//  Created by YmWw on 2017/8/15.
//
//

import UIKit

enum YMTopTabType {
    
    case Bigger
    case Slider
    case BiGSLIDER
}



class YMTopTab: UIView {
    
    var collectionView:UICollectionView!
    var titles:Array<String> {
      
        didSet {
          
            assert(titles.count > 0, "title 不能设置为空")
            let attribute = titles.first! as NSString
            let titleSize = attribute.boundingRect(with: CGSize(width:self.frame.size.width, height:0), options:.usesFontLeading, attributes: [NSFontAttributeName:self.selectedFont], context: nil)
            
            self.frame = 
        }
    }
    var topGap = 5
    var bottomGap = 4
    var fillout = true
    var normalFont = UIFont.systemFont(ofSize: 14.0)
    var selectedFont = UIFont.systemFont(ofSize: 14.0)
    var lastSelectedByTap = false
    var style:YMTopTabType = .Bigger
    var sliderHeight = 3
    var scrollingChangeFont = true
    
    override init(frame:CGRect) {
        
        self.titles = [String]()

        super.init(frame:frame)
        self.createCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createCollectionView(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flowLayout)
        collectionView.register(YMTopCell.classForCoder(), forCellWithReuseIdentifier: "YMTopCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView;
    }
    
}

extension YMTopTab:UICollectionViewDelegate, UICollectionViewDataSource {
    
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YMTopCell", for: indexPath)
        return cell
    }
    
    
    
    
}
