//
//  HomePageInteractor.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation
import Alamofire
import Firebase
import Kingfisher

class HomePageInteractor: PresenterToInteractorHomePageProtocol {
    var homePagePresenter: InteractorToPresenterHomePageProtocol?
    
  
        func yemekAra(aramaKelimesi: String) {
            AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
                if let data = response.data {
                    do{
                        let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                       
                        if var liste = cevap.yemekler {
                            if aramaKelimesi == "" {
                                self.homePagePresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                            }
                            else {
                                liste = liste.filter({veri -> Bool in
                                    (veri.yemek_adi?.lowercased().contains(aramaKelimesi.lowercased()))!
                                    
                                })
                                self.homePagePresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    
    func tumYemekleriGetir() {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method:.get).response { response in
                    if let data = response.data {
                        do {
                            let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                            var liste = [Yemekler]()
                            if let cevapListesi = cevap.yemekler {
                                liste = cevapListesi
                                
                            }
                            self.homePagePresenter?.presenteraVeriGonder(yemeklerListesi: liste)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
    }

}


