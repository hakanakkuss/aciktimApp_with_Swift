//
//  ViewController.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 19.10.2022.
//

import UIKit
import Lottie
import Alamofire
import Kingfisher


class HomePage: UIViewController {
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animationHomeView: LottieAnimationView!
    
    
    var yemekler = [Yemekler]()
    var homePagePresenterObject : ViewToPresenterHomePageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        HomePageRouter.createModule(ref: self)
        
        animationHomeView = .init(name: "24703-food-animation")
        animationHomeView.frame = CGRect(x: 120, y: 108, width: 200, height: 200)
        animationHomeView!.contentMode = .scaleAspectFit
        animationHomeView!.loopMode = .loop
        animationHomeView!.animationSpeed = 0.5
        view.addSubview(animationHomeView!)
        animationHomeView!.play()
     

        
        let collectionViewDesign = UICollectionViewFlowLayout()
        collectionViewDesign.minimumLineSpacing = 10
        collectionViewDesign.minimumInteritemSpacing = 10
        collectionViewDesign.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 4)
        let width = collectionView.frame.size.width
        let cellWidht = (width - 30) / 2
        collectionViewDesign.itemSize = CGSize(width: cellWidht, height: cellWidht*1.5)
        collectionView.collectionViewLayout = collectionViewDesign
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toDetailPage" {
               let food = sender as? Yemekler
               let destinationVC = segue.destination as! DetailPage
               destinationVC.food = food
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        homePagePresenterObject?.yemekleriGetir()
    }
}

extension HomePage: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemekler.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = yemekler[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! CollectionViewCell
        cell.foodName.text = food.yemek_adi!
        cell.foodFiyat.text = "\(food.yemek_fiyat!).00 ₺"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)")
                {
                    DispatchQueue.main.async {
                        cell.foodImage.kf.setImage(with : url)
                    }
                }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = yemekler[indexPath.row]
        
        performSegue(withIdentifier: "toDetailPage", sender: food)
    }
    
    
}

extension HomePage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homePagePresenterObject?.ara(aramaKelimesi: searchText)
    }
}


extension HomePage : PresenterToViewHomePageProtocol {

    func viewaVeriGonder(yemeklerListesi: Array<Yemekler>) {
        self.yemekler = yemeklerListesi
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
