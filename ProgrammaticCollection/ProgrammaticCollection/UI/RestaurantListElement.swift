//
//  RestaurantListElement.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantListElement: UIView {
    var image: UIImage? {
        didSet {
            addImage(image)
        }
    }
    
    var text: String? {
        didSet {
            addTitle(text)
        }
    }
    
    var titleView: UILabel!
    var imageView: UIImageView!
    var imageContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTitle(_ title: String?) {
        titleView?.removeFromSuperview()
        
        titleView = UILabel(frame: CGRect(x: 40, y: -4, width: self.frame.width, height: self.frame.height))
        titleView.backgroundColor = .clear
        titleView.textColor = .primaryText
        titleView.textAlignment = .left
        titleView.font = .primary(ofSize: 14)
        titleView.text = title
        self.addSubview(titleView)
    }
    
    private func addImage(_ image: UIImage?) {
        imageView?.removeFromSuperview()
        imageContainerView?.removeFromSuperview()
        
        imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageContainerView.backgroundColor = .tertiaryBackground
        imageContainerView.roundCorners([.allCorners], radius: Constants.Radius.secondaryCornerRadius)
        
        imageView = UIImageView(frame: CGRect(x: 4, y: 4, width: 24, height: 24))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image

        self.addSubview(imageContainerView)
        
        imageContainerView.addSubview(imageView)
    }
}
