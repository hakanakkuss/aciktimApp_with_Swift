//
//  AddToCartPage.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 19.10.2022.
//

import UIKit
import Firebase
import UserNotifications
import Lottie

class CartPage: UIViewController {

    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var sepetTableView: UITableView!
    @IBOutlet weak var siparisVerButton: UIButton!
    @IBOutlet weak var kargoUcreti: UILabel!
    @IBOutlet weak var araToplam: UILabel!
    @IBOutlet weak var minSepetTutariLabel: UILabel!
    @IBOutlet weak var minSepetTutariInfo: UILabel!
    
    var cartFoods = [YemekDetay]()
    var cartPagePresenterObject : ViewToPresenterCartPageProtocol?
    var foodsCount = 0
    var izinKontrol = false
    var kargoUcret : Int = 14
    var minSepet : Int = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CartPageRouter.createModule(ref: self)
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: { (granted,error) in
            self.izinKontrol = granted
        })
        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        cartPagePresenterObject?.tumSepetiGetir()
        kargoUcreti.text = "\(kargoUcret).00 ₺"

        
    }

    
    @IBAction func siparisVerButton(_ sender: Any) {
        performSegue(withIdentifier: "toSiparisTakip", sender: nil)
        
    }
        
}

extension CartPage : PresenterToViewCartPageProtocol {
    
    func viewaVeriGonder(sepetListesi: Array<YemekDetay>) {
        
        self.cartFoods = sepetListesi
        DispatchQueue.main.async {
            self.sepetTableView.reloadData()
            var total = 0
            self.cartFoods.forEach { cart_food in
                total = total + (Int(cart_food.yemek_fiyat ?? "0")! * Int(cart_food.yemek_siparis_adet ?? "0")!)
                self.araToplam.text = "\(total).00 ₺"
            }
            self.totalPriceLabel.text = "Sepet Tutarı : \(String((total) + (self.kargoUcret))).00 ₺"
            self.minSepetTutariLabel.text = "Teslimat ücreti ödememek için 15 tl lik daha ürün ekleyin"
            self.minSepetTutariInfo.text = "Minimum sepet tutarı \(self.minSepet).00 ₺'dir"
            self.minSepetTutariInfo.textColor = .red
    
            
            if total >= self.minSepet {
                self.kargoUcreti.text = "0"
                self.totalPriceLabel.text = "Sepet Tutarı : \(total).00 ₺"
                self.minSepetTutariLabel.textColor = .gray
                self.minSepetTutariLabel.text = "Ücretsiz Teslimat"
                self.minSepetTutariInfo.text = "Minimum sepet tutarı \(self.minSepet).00 ₺'dir"
                self.minSepetTutariInfo.textColor = .systemGreen
                self.siparisVerButton.isEnabled = true
                
            }
            else {
                self.minSepetTutariLabel.textColor = .gray
                self.minSepetTutariLabel.text = "Teslimat ücreti ödememek için sepetinize \(String((self.minSepet) - (total)))₺ değerinde ürün ekleyin."
                self.kargoUcreti.text = String(self.kargoUcret)
                self.siparisVerButton.isEnabled = false
               
            }
           
        }
       
    }
    func viewaVeriGonder(yemekSayisi: Int) {
        self.foodsCount = yemekSayisi
        DispatchQueue.main.async {
            self.sepetTableView.reloadData()
        }
    }
    
    

}

extension CartPage : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound,.badge])
    }
    
}

extension CartPage : UITableViewDelegate, UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartFoods.isEmpty { //sepet boşsa uyarı bildirimi verir.
            tabBarItem.badgeValue = nil
            siparisVerButton.isEnabled = false
            
            if izinKontrol {
                let icerik = UNMutableNotificationContent()
                    icerik.title = "Sepet Boş"
                    icerik.badge = 1
                    icerik.subtitle = "Sepetini hemen doldurmak ister misin?"
                    icerik.sound = UNNotificationSound.default
                let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let bildirimIstegi = UNNotificationRequest(identifier: "id", content: icerik, trigger: tetikleme)
                        UNUserNotificationCenter.current().add(bildirimIstegi)
                    }
            
            self.totalPriceLabel.text = "Sepet Tutarı : 0 ₺"
            sepetTableView.setEmptyMessage("Sepet boş ürün ekleyiniz...")
            
        }else {
            sepetTableView.restore()
            tabBarItem.badgeValue = "\(cartFoods.count)" //sepetteki ürün adedi kadar badge ekler
            siparisVerButton.isEnabled = true
        }
        return cartFoods.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartFood = cartFoods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetHucre", for: indexPath) as! SepetTableViewCell
        
        cell.FoodNameL.text = cartFood.yemek_adi!
        cell.FoodCount.text = "Adet: \(cartFood.yemek_siparis_adet!)"
        cell.FoodPrice.text = "Fiyat: \(Int(cartFood.yemek_fiyat!)!).00 ₺"
        
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(cartFood.yemek_resim_adi!)") {
           
            DispatchQueue.main.async {
                cell.FoodImageV.kf.setImage(with: url)
            }
           
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction,view,bool) in
                let cart = self.cartFoods[indexPath.row]
                self.cartFoods.remove(at: indexPath.row) //seçilen elemanı sepetten siler
                self.cartPagePresenterObject?.sil(sepet: cart, kullanici_adi: "\(Auth.auth().currentUser?.email ?? "")")
               
                  self.foodsCount -= 1
                    if self.foodsCount == 0 {
                        self.totalPriceLabel.text = "0"
                   }
            tableView.reloadData()
            self.araToplam.text = "0"
            self.minSepetTutariLabel.text = nil
                }
                return UISwipeActionsConfiguration(actions: [deleteAction])
            }
    
    
}

extension UITableView {

    func setEmptyMessage(_ message: String) {

        let uiView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))

        //sepet boşken ekranda çıkan uyarı animasyonu
        var animationView = LottieAnimationView()
        animationView = .init(name: "112087-empty")
        animationView.frame = CGRect(x: uiView.bounds.size.width * 0.2, y: uiView.bounds.size.height * 0.1, width: uiView.bounds.size.width * 0.6, height: uiView.bounds.size.height * 0.5)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        //sepet boşken ekranda çıkan uyarı mesajı
        let messageLabel = UILabel(frame: CGRect(x: uiView.bounds.size.width * 0.27, y: uiView.bounds.size.height * 0.7, width: uiView.bounds.size.width * 0.9, height: uiView.bounds.size.height * 0.9))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        uiView.addSubview(animationView)
        uiView.addSubview(messageLabel)

        self.backgroundView = uiView
    }

    func restore() {
        self.backgroundView = nil
    }
}
