//
//  RestaurantCells.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit
//TODO: import GoogleMaps pod and key. Then uncomment
//import GoogleMaps

protocol RestaurantCellDelegate: class {
    func shareBtnPressed()
    func heartBtnPressed()
    func seeAllBtnPressed()
}
class RestaurantCell: UICollectionViewCell {
    weak var delegate: RestaurantCellDelegate?
    
    func configureCell(withData data: RestaurantDataForUI?) {
        self.backgroundColor = .clear
    }
}

class RestaurantPhotoCell: RestaurantCell {
    var mainImageView: UIImageView!
    var shareBtn: RestaurantButton!
    var heartBtn: RestaurantButton!
    var seeAllBtn: UIButton!
    
    
    override func configureCell(withData data: RestaurantDataForUI?) {
        super.configureCell(withData: data)
        
        addImageView(withImage: data?.firstImage)
        createShareBtn()
        createHeartBtn()
        createSeeAllBtn(numOfPictures: data?.data?.pics_diaporama?.count ?? 0)
    }
    
    private func addImageView(withImage image: UIImage?) {
        mainImageView?.removeFromSuperview()
        
        mainImageView = UIImageView(frame: self.frame)
        mainImageView.image = image
        mainImageView.contentMode = .scaleAspectFill
        self.addSubview(mainImageView)
    }
    
    private func createShareBtn() {
        shareBtn?.removeFromSuperview()
        
        shareBtn = RestaurantButton(frame: CGRect(x: self.frame.width - 48 - 48, y: 16, width: 32, height: 32))
        shareBtn.setImage(getAssetsImage(named: "share"), for: .normal)
        shareBtn.addTarget(self, action:#selector(shareBtnAction), for: .touchUpInside)
        shareBtn.backgroundColor = .quartiaryBackground
        shareBtn.alpha = 0.6
        self.addSubview(shareBtn)
    }
    
    private func createHeartBtn() {
        heartBtn?.removeFromSuperview()
        
        heartBtn = RestaurantButton(frame: CGRect(x: self.frame.width - 48, y: 16, width: 32, height: 32))
        heartBtn.setImage(getAssetsImage(named: "solid-heart"), for: .normal)
        heartBtn.addTarget(self, action:#selector(heartBtnAction), for: .touchUpInside)
        heartBtn.backgroundColor = .quartiaryBackground
        heartBtn.alpha = 0.6
        self.addSubview(heartBtn)
    }
    
    private func createSeeAllBtn(numOfPictures: Int) {
        seeAllBtn?.removeFromSuperview()
        
        seeAllBtn = UIButton(frame: CGRect(x: 32, y: self.frame.height - 48, width: 160, height: 32))
        seeAllBtn.setTitle("See all \(numOfPictures) photos >", for: .normal)
        seeAllBtn.addTarget(self, action:#selector(seeAllBtnAction), for: .touchUpInside)
        seeAllBtn.backgroundColor = .quartiaryBackground
        seeAllBtn.alpha = 0.6
        seeAllBtn.roundCorners([.allCorners], radius: Constants.Radius.secondaryCornerRadius)
        self.addSubview(seeAllBtn)
    }
    
    @objc func shareBtnAction() {
        log("User tapped shareBtnAction")
        delegate?.shareBtnPressed()
    }
    
    @objc func heartBtnAction() {
        log("User tapped shareBtnAction")
        delegate?.heartBtnPressed()
    }
    
    @objc func seeAllBtnAction() {
        log("User tapped shareBtnAction")
        delegate?.seeAllBtnPressed()
    }
}

class RestaurantInfoCell: RestaurantCell {
    var mainView: UIView!
    var titleView: UILabel!
    var listViews: [RestaurantListElement]!
    
    private var leftMargin: CGFloat = 26
    
    override func configureCell(withData data: RestaurantDataForUI?) {
        super.configureCell(withData: data)
        
        addMainView()
        addTitle(data?.data?.name)
        
        listViews = []
        let textPlace = self.getPlaceText(address: data?.data?.address, city: data?.data?.city, zipcode: data?.data?.zipcode)
        addList(text: textPlace, image: getAssetsImage(named: "location"), belowView: titleView)
        addList(text: data?.data?.speciality, image: getAssetsImage(named: "food"), belowView: listViews[0])
        let textPrice = self.getPriceText(currency: data?.data?.currency_code, value: data?.data?.card_price)
        addList(text: textPrice, image: getAssetsImage(named: "cash"), belowView: listViews[1])
    }
    
    private func addMainView() {
        mainView?.removeFromSuperview()
        
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - 16))
        mainView.backgroundColor = .primaryBackground
        
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
        let view = RestaurantListElement(frame: CGRect(x: leftMargin, y: belowView.frame.maxY, width: self.frame.width, height: 40))
        view.text = text
        view.image = image
        listViews.append(view)
        mainView.addSubview(view)
    }
    
    private func getPlaceText(address: String?, city: String?, zipcode: String?) -> String {
        if let address = address, let city = city, let zipcode = zipcode {
            return "\(address), \(city) \(zipcode)"
        }
        return "Address N/A"
    }
    
    private func getPriceText(currency: String?, value: Int?) -> String {
        if let currency = currency, let value = value {
            //TODO: Convert currency in symbol
            return "Average price \(currency)\(value)"
        }
        return "Average price N/A"
    }
}

class RestaurantMapCell: RestaurantCell {
    //TODO: import GoogleMaps pod and key. Then uncomment
//    private var mapView: GMSMapView!
    
    override func configureCell(withData data: RestaurantDataForUI?) {
        super.configureCell(withData: data)
        
        //TODO: import GoogleMaps pod and key. Then uncomment
//        mapView = GMSMapView(frame: view.frame)
//        mapView.settings.myLocationButton = false
//        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mapView.isMyLocationEnabled = true
//        mapView.mapType = .normal
//
//        let camera = GMSCameraPosition.camera(withLatitude: data?.data?.gps_lat,
//                                              longitude: data?.data?.gps_long,
//                                              zoom: 17.0)
//
//        mapView?.camera = camera
    }
}
