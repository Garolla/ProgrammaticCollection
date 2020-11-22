//
//  RestaurantVC.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    func configureCell(withData data: RestaurantDataForUI?) {
        self.backgroundColor = .white
    }
}

class RestaurantPhotoCell: RestaurantCell {
    var mainImageView: UIImageView!
    
    override func configureCell(withData data: RestaurantDataForUI?) {
        super.configureCell(withData: data)
        
        mainImageView = UIImageView(frame: self.frame)
        mainImageView.image = data?.firstImage
        self.addSubview(mainImageView)
    }
}

class RestaurantInfoCell: RestaurantCell {
    var mainView: UIView!
    var titleView: UILabel!
    var listViews: [RestaurantListElement]!
    
    private var leftMargin: CGFloat = 32
    
    override func configureCell(withData data: RestaurantDataForUI?) {
        super.configureCell(withData: data)
        
        addMainView()
        addTitle(data?.data?.name)
        
        listViews = []
        addList(text: data?.data?.speciality, image: getAssetsImage(named: "location"), belowView: titleView)
        addList(text: data?.data?.speciality, image: getAssetsImage(named: "food"), belowView: listViews[0])
        addList(text: data?.data?.speciality, image: getAssetsImage(named: "cash"), belowView: listViews[1])
    }
    
    private func addMainView() {
        mainView?.removeFromSuperview()
        
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 16))
        mainView.backgroundColor = .green
        
        mainView.roundCorners([.bottomLeft, .bottomRight], radius: Constants.Radius.cardCornerRadius)
        //FIXME: Shadow not working properly
        mainView.layer.setShadow()
        
        self.addSubview(mainView)
    }
    
    private func addTitle(_ title: String?) {
        titleView?.removeFromSuperview()
        
        titleView = UILabel(frame: CGRect(x: leftMargin, y: 0, width: self.frame.width, height: 60))
        titleView.backgroundColor = .clear
        titleView.textColor = .primaryText
        titleView.textAlignment = .left
        titleView.font = .primaryBold(ofSize: 32)
        titleView.text = title
        mainView.addSubview(titleView)
    }
    
    private func addList(text: String?, image: UIImage?, belowView: UIView) {
        let view = RestaurantListElement(frame: CGRect(x: leftMargin, y: belowView.frame.maxY, width: self.frame.width, height: 60))
        view.text = text
        view.image = image
        listViews.append(view)
        mainView.addSubview(view)
    }
}

class RestaurantMapCell: RestaurantCell {
    
}

class RestaurantVC: UIViewController {
    
    private var myCollectionView: UICollectionView!
    private var bottonBtn: RestaurantButton!
    
    private var cellsTypes = [RestaurantPhotoCell.self,
                              RestaurantInfoCell.self,
                              RestaurantMapCell.self]
    
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
    
    //MARK: UI
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
        
        for type in cellsTypes {
            myCollectionView.register(type, forCellWithReuseIdentifier: type.description())
        }
        
        myCollectionView.backgroundColor = .secondaryBackground
        myCollectionView.isScrollEnabled = true
        
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
    
    private func createBottonBtn() {
        bottonBtn = RestaurantButton(frame: CGRect(x: 8, y: self.view.frame.height - 88, width: self.view.frame.width - 16, height: 44))
        bottonBtn.setTitle("Book a table", for: .normal)
        bottonBtn.addTarget(self, action:#selector(bottonBtnAction), for: .touchUpInside)
        bottonBtn.backgroundColor = .primary
        self.view.addSubview(bottonBtn)
    }
    
    @objc func bottonBtnAction() {
        log("User tapped bottonBtnAction")
    }
    
    //MARK: Logic
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
        return cellsTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = cellsTypes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.description(), for: indexPath) as! RestaurantCell
        cell.configureCell(withData: restaurantData)
        return cell
    }
}

extension RestaurantVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       log("User tapped item \(indexPath.row)")
    }
}
