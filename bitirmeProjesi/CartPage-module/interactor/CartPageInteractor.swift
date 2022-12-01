//
//  AddToCartPageInteractor.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation
import Alamofire
import Firebase


class CartPageInteractor: PresenterToInteractorCartPageProtocol {
    var cartPagePresenter: InteractorToPresenterCartPageProtocol?
    
    
    func getCount() {
        let param : Parameters = ["kullanici_adi" : "\(Auth.auth().currentUser?.email ?? "")"]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: param).response{ response in
                    if let data = response.data {
                        do {
                            let cevap = try JSONDecoder().decode(YemekDetayCevap.self, from: data)
                            var list = [YemekDetay]()
                            if let answerList = cevap.sepet_yemekler {
                                list = answerList
                            }
                            //print(list)
                            self.cartPagePresenter?.sendDataToPresenter(yemekSayisi: list.count)
                        } catch  {
                            print(error.localizedDescription)
                        }
                    }
                }
        
    }
    
    func sepetinHepsiniSil(carts: Array<YemekDetay>) {
        for sepetItem in carts{
                   DispatchQueue.main.async { [weak self] in
                       self?.yemekSil(sepet: sepetItem, kullanici_adi: Auth.auth().currentUser?.email ?? "")
                   }
            
            
               }
    }

    func sepetiGetir() {
        let param : Parameters = ["kullanici_adi" : "\(Auth.auth().currentUser?.email ?? "")"]
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: param).response { response in
                    if let data = response.data {
                        do {
                            let answer = try JSONDecoder().decode(YemekDetayCevap.self, from: data)
                            var list = [YemekDetay]()
                            if let answerList = answer.sepet_yemekler {
                                list = answerList
                                
                            }
                            self.cartPagePresenter?.presenteraVeriGonder(sepetListesi: list)
                        } catch  {
                            print(error.localizedDescription)
                        }
                    }
                }
        
    }
    
    func yemekSil(sepet: YemekDetay, kullanici_adi: String) {
        let param : Parameters = [
            "sepet_yemek_id" : sepet.sepet_yemek_id!,
            "kullanici_adi" : Auth.auth().currentUser?.email ?? ""]
        
        //POST İLE SEPETTEN VERİ SİLME
                AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: param).response{ response in
                    if let data = response.data {
                        do{
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                                //print(json)
                                self.sepetiGetir()
                                }
                        }catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
