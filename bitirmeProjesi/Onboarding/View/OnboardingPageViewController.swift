//
//  ilkOnboardingPageViewController.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 28.10.2022.
//

import UIKit

class OnboardingPageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var slides: [OnboardingSlides] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.isHidden = false
                nextButton.setTitle("Harika! Başlayalım", for: .normal)
            } else {
                nextButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
            OnboardingSlides(title: "Binlerce Çeşit", description: "Acıktım'da canın ne yemek isterse bulabilirsin. Üstelik başlangıca özel indirimli menüler seni bekliyor.", image: UIImage(named: "food1.jpeg")!),
        OnboardingSlides(title: "Hızlı Teslimat", description: "Siparişin 45 dakikada gelmediğinde ücret talep etmiyoruz.", image: UIImage(named: "food2.jpeg")!),
            OnboardingSlides(title: "Sürpriz Kampanyalar", description: "Sipariş verdikçe katlanan indirimlerden faydalanmak için hemen başla.", image: UIImage(named: "food3.jpeg")!)
        
        ]
        nextButton.isHidden = false
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if currentPage == slides.count - 1 {
            performSegue(withIdentifier: "toAuthenticationPage", sender: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
       
    }
    
}

extension OnboardingPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingPageCollectionViewCell
        cell.setup(slides[indexPath.row])
        cell.slideImageView.contentMode = .scaleAspectFit
        cell.slideImageView.autoresizingMask = .flexibleHeight
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
       
    }
}

    



