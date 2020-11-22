//
//  RestaurantVC.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    func configureCell(withData data: RestaurantDataForUI?) {
        self.backgroundColor = .primaryBackground
    }
}

class RestaurantPhotoCell: RestaurantCell {
    static let cellId = "RestaurantPhotoCellId"
    
    var mainImageView: UIImageView!
    
    override func configureCell(withData data: RestaurantDataForUI?) {
        super.configureCell(withData: data)
        
        mainImageView = UIImageView(frame: self.frame)
        mainImageView.image = data?.firstImage
        self.addSubview(mainImageView)
    }
}

class RestaurantInfoCell: RestaurantCell {
    static let cellId = "RestaurantInfoCellId"
    
}

class RestaurantMapCell: RestaurantCell {
    static let cellId = "RestaurantMapCellId"
    
}

class RestaurantVC: UIViewController {
    
    private var myCollectionView: UICollectionView!
    private var bottonBtn: RestaurantButton!
    
    private var cellsIds = [RestaurantPhotoCell.cellId,
                            RestaurantInfoCell.cellId,
                            RestaurantMapCell.cellId]
    
    private var restaurantData = RestaurantDataForUI(data: nil, firstImage: nil)
    
    private var hasUIBeenCreated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //UI created in will appear to tuckle potentials frame issues
        if !hasUIBeenCreated {
            createCollectionView()
            createBottonBtn()
            hasUIBeenCreated = true
        }
        
        getDataForUI()
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
        
        for id in cellsIds {
            myCollectionView.register(RestaurantPhotoCell.self, forCellWithReuseIdentifier: id)
        }
        
        myCollectionView.backgroundColor = .secondaryBackground
        myCollectionView.isScrollEnabled = true
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
    
    private func createBottonBtn() {
        bottonBtn = RestaurantButton(frame: CGRect(x: 16, y: self.view.frame.height - 88, width: self.view.frame.width - 32, height: 44))
        bottonBtn.setTitle("Book a table", for: .normal)
        bottonBtn.addTarget(self, action:#selector(bottonBtnAction), for: .touchUpInside)
        self.view.addSubview(bottonBtn)
    }
    
    @objc func bottonBtnAction() {
        log("User tapped bottonBtnAction")
    }
    
    private func getDataForUI() {
        restaurantManager.getRestaurant { [weak self] (data, error) in
            log("getRestaurant response arrived")
            if data != nil {
                log("getRestaurant restaurantData is NOT nil")
                self?.restaurantData.data = data
                self?.myCollectionView?.reloadData()
            }
            
            //First data to fill UI has arrived, now i need to get the first pic
            if let firstPic = data?.pics_diaporama?.first, let url = URL(string: firstPic) {
                restaurantManager.getRestaurantImage(imageURL: url) { (image, error) in
                    if image != nil {
                        self?.restaurantData.firstImage = image
                        self?.myCollectionView?.reloadData()
                    }
                }
            }
        }
    }

}

extension RestaurantVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = cellsIds[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RestaurantCell
        cell.configureCell(withData: restaurantData)
        return cell
    }
}

extension RestaurantVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       log("User tapped item \(indexPath.row)")
    }
}
