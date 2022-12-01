//
//  ilkOnboardingPageCollectionViewCell.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 28.10.2022.
//

import UIKit

class OnboardingPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideDescription: UILabel!
    @IBOutlet weak var slideTitle: UILabel!
    
    func setup(_ slide: OnboardingSlides) {
        slideImageView.image = slide.image
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
    
}
