//
//  RestaurantReviewsView.swift
//  ProgrammaticCollection
//
//  Created by Emanuele Garolla on 22/11/2020.
//

import UIKit

class RestaurantReviewsView: UIView {
    enum ViewType {
        case thefork, tripadvisor
    }
    
    var scoreLbl: UILabel!
    var reviewsLbl: UILabel!
    var imageView: UIImageView!
    var scoreImagesView: [UIImageView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(type: ViewType, numberOfReviews: Int?, score: Double?) {
        if type == .thefork {
            addScoreLbl(score)
        } else {
            addScoreImages(score)
        }
        
        addReviewsLbl(type: type, numberOfReviews)
        
        addImage(type: type)
    }
    
    private func addScoreLbl(_ score: Double?) {
        scoreLbl?.removeFromSuperview()
        
        scoreLbl = UILabel(frame: CGRect(x: 48, y: 12, width: self.frame.width, height: 32))
        scoreLbl.backgroundColor = .clear
        scoreLbl.textColor = .primaryText
        scoreLbl.textAlignment = .left
        
        let scoreText = "\(score ?? 0)"
        let mutableAttributedString = NSMutableAttributedString()
        let scoreTextBold = NSAttributedString(string: scoreText, attributes: [.font: UIFont.primaryBold(ofSize: 32)])
        mutableAttributedString.append(scoreTextBold)
        let outOfTen = NSAttributedString(string: "/10", attributes: [.font: UIFont.primary(ofSize: 16)])
        
        mutableAttributedString.append(outOfTen)
        scoreLbl.attributedText = mutableAttributedString
        self.addSubview(scoreLbl)
    }
    
    private func addScoreImages(_ score: Double?) {
        scoreImagesView = []
        
        let score = score ?? 0
        
        for i in 1...5 {
            let scoreImageView = UIImageView(frame: CGRect(x: 36 + 14 * i, y: 20, width: 12, height: 12))
            scoreImageView.contentMode = .scaleAspectFit
            //FIXME: Add logic for ta-bubbles-half
            scoreImageView.image = getAssetsImage(named: score >= Double(i) ? "ta-bubbles-full" : "ta-bubbles-empty")
            self.addSubview(scoreImageView)
        }
    }
    
    private func addReviewsLbl(type: ViewType, _ numberOfReviews: Int?) {
        reviewsLbl?.removeFromSuperview()
        
        reviewsLbl = UILabel(frame: CGRect(x: 4, y: 56, width: self.frame.width, height: 20))
        reviewsLbl.backgroundColor = .clear
        reviewsLbl.textColor = .primaryText
        reviewsLbl.textAlignment = .left
        reviewsLbl.font = .primary(ofSize: 12)
        reviewsLbl.text = "\(numberOfReviews ?? 0) \(type == .thefork ? "TheFork" : "TripAdvisor") reviews"
        self.addSubview(reviewsLbl)
    }
    
    private func addImage(type: ViewType) {
        imageView?.removeFromSuperview()
        
        imageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 32, height: 32))
        imageView.contentMode = .scaleAspectFit
        imageView.image = getAssetsImage(named: type == .thefork ? "tf-logo" : "ta-logo")

        self.addSubview(imageView)
    }
}
