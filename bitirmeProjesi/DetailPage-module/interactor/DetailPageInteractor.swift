//
//  DetailPageInteractor.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation
import Alamofire
import Firebase

class DetailPageInteractor:PresenterToInteractorDetailPageProtocol {
    var sepetYemekListesi = [YemekDetay]()
    
    
    func sepeteYemekEkle(yemek: Yemekler, adet: Int, username: String) {
        var aynıYemek: YemekDetay?
        
        sepetiGetir(username: username) {
            aynıYemek = self.yemekKontrol(food: yemek)
            
            if aynıYemek != nil {
                let oldCount = aynıYemek?.yemek_siparis_adet
                let addCount = adet
                aynıYemek?.yemek_siparis_adet = String(Int(oldCount!)! + addCount)
                
                self.yemekSil(foodId: (aynıYemek?.sepet_yemek_id)!, username: username) {
                    let newFood = Yemekler(yemek_id: nil, yemek_adi: aynıYemek?.yemek_adi, yemek_fiyat: aynıYemek?.yemek_fiyat, yemek_resim_adi: aynıYemek?.yemek_resim_adi)
                    
                    self.sepeteYemekEkleYeni(food: newFood, count: Int(aynıYemek!.yemek_siparis_adet!)!, username: (aynıYemek?.kullanici_adi!)!)
                }
            }else{
                self.sepeteYemekEkleYeni(food: yemek, count: adet, username: username)
            }
        }
        
    }
    
    func sepeteYemekEkleYeni(food: Yemekler, count: Int, username: String) {
        let params: Parameters = ["yemek_adi": food.yemek_adi!, "yemek_resim_adi": food.yemek_resim_adi!, "yemek_fiyat": food.yemek_fiyat!, "yemek_siparis_adet": count, "kullanici_adi": username]
        
        //POST İLE SEPETE VERİ GÖNDERME
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONSerialization.jsonObject(with: data)
                    //print(response)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func yemekSil(foodId: String, username: String, isFinished: @escaping () -> Void) {
        let params: Parameters = ["sepet_yemek_id": foodId, "kullanici_adi": username]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let response = try JSONSerialization.jsonObject(with: data)
                    //print(response)
                    isFinished()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetiGetir(username: String, completion: @escaping () -> Void) {
        let params: Parameters = ["kullanici_adi": username]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(YemekDetayCevap.self, from: data)
                    //print(data)
                    if let list = response.sepet_yemekler {
                        DispatchQueue.main.async {
                            self.sepetYemekListesi = list
                            completion()
                        }
                    }
            }catch{
                print(error.localizedDescription)
                completion()
                }
            }
        }
    }
    
    
    func yemekKontrol(food: Yemekler) -> YemekDetay? {
        let sameFood = sepetYemekListesi.first {$0.yemek_adi == food.yemek_adi}
        if sameFood != nil {
            return sameFood!
        }
        return nil
    }
}
