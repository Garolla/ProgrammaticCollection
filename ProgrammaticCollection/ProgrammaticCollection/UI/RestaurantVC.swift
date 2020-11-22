//
//  RestaurantVC.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantVC: UIViewController {
    
    var myCollectionView: UICollectionView?
    
    private let photosCellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCollectionView()
    }
    
    private func createCollectionView() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: photosCellId)
        myCollectionView?.backgroundColor = .secondaryBackground
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }

}

extension RestaurantVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: photosCellId, for: indexPath)
        myCell.backgroundColor = .primaryBackground
        return myCell
    }
}

extension RestaurantVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       log("User tapped on item \(indexPath.row)")
    }
}
