//
//  DetailPage.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 19.10.2022.
//

import UIKit
import Firebase


class DetailPage: UIViewController {

    @IBOutlet weak var sepeteEkle: UIButton!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodCalculateLabel: UILabel!
    @IBOutlet weak var foodImageDetail: UIImageView!
    @IBOutlet weak var adetLabel: UILabel!
    
    var fiyat:Int?
    var food:Yemekler?
    var count : Int = 1
    
    
    var yemekDetayPresenterNesnesi : ViewToPresenterDetailPageProtocol?
    
    @IBOutlet weak var foodNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailPageRouter.createModule(ref: self)
    
        foodCalculateLabel.text = "Tutar: \(food?.yemek_fiyat! ?? "").00 ₺"
        foodPriceLabel.text! = "\(food?.yemek_fiyat! ?? "").00 ₺"
        
        if let f = food{
            foodNameLabel.text = f.yemek_adi
            if let url = URL(string : "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)") {
                    DispatchQueue.main.async {
                        self.foodImageDetail.kf.setImage(with : url)
                    }
                }
        }
    }
    
    func addFoodToCart(){
        if count >= 1 && count < 20{
            count += 1
            }
        adetLabel.text = "\(count)"
        if let f = food
            {
                let toplamYemekFiyati = Int(f.yemek_fiyat!)
                foodCalculateLabel.text = "Tutar: \(toplamYemekFiyati! * count).00 ₺"
            }
    }
    func takeFoodOutFromCart(){
        if count > 1 && count <= 20 {
            count -= 1
        }
        adetLabel.text = "\(count)"
            if let f = food {
                let toplamYemekFiyati = Int(f.yemek_fiyat!)
                foodCalculateLabel.text = "Tutar: \(toplamYemekFiyati! * count).00 ₺"
            }
        }
    
    
    @IBAction func minusButton(_ sender: Any) {
        takeFoodOutFromCart()
    }
    @IBAction func plusButton(_ sender: Any) {
        addFoodToCart()
    }
    
    

    @IBAction func sepeteEkle(_ sender: Any) {
        
        if let f = food{
            yemekDetayPresenterNesnesi?.yemekEkle(yemek: food!, adet: count, username: (Auth.auth().currentUser?.email)!)
            
            //alert
            let alert = UIAlertController(title: "Sepete Eklendi", message: "\(f.yemek_adi!) sepete eklendi!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Tamam", style: .default)
                alert.addAction(OKAction)
            self.present(alert, animated: true)
        }
    }

  
}


