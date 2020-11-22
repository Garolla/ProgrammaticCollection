//
//  RestaurantListElement.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantListElement: UIView {
    var image: UIImage?
    var text: String? {
        didSet {
            addTitle(text)
        }
    }
    
    var titleView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTitle(_ title: String?) {
        titleView = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        titleView.backgroundColor = .clear
        titleView.textColor = .primaryText
        titleView.textAlignment = .left
        titleView.font = .primary(ofSize: 18)
        titleView.text = title
        self.addSubview(titleView)
    }
}
