//
//  RestaurantVC.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    func configureCell() {
        self.backgroundColor = .primaryBackground
    }
}

class RestaurantPhotoCell: RestaurantCell {
    static let photosCellId = "RestaurantPhotoCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class RestaurantVC: UIViewController {
    
    private var myCollectionView: UICollectionView?
    
    private var cellsIds = [RestaurantPhotoCell.photosCellId,
                            RestaurantPhotoCell.photosCellId,
                            RestaurantPhotoCell.photosCellId]
    
    private var hasCollectionViewBeenCreated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !hasCollectionViewBeenCreated {
            createCollectionView()
            hasCollectionViewBeenCreated = true
        }
    }
    
    private func createCollectionView() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height / 3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView?.register(RestaurantPhotoCell.self, forCellWithReuseIdentifier: RestaurantPhotoCell.photosCellId)
        myCollectionView?.backgroundColor = .secondaryBackground
        myCollectionView?.isScrollEnabled = true
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }

}

extension RestaurantVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = cellsIds[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantCell
        cell.configureCell()
        return cell
    }
}

extension RestaurantVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       log("User tapped on item \(indexPath.row)")
    }
}
