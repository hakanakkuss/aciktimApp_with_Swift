//
//  AddToCartPagePresenter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

class CartPagePresenter : ViewToPresenterCartPageProtocol {
  
    
    var cartPageInteractor: PresenterToInteractorCartPageProtocol?
    var cartPageView: PresenterToViewCartPageProtocol?
    
    func getCount() {
        cartPageInteractor?.getCount()
    }
    
    func sepetiSil(carts: Array<YemekDetay>) {
        cartPageInteractor?.sepetinHepsiniSil(carts: carts)
    }
    
    func sil(sepet: YemekDetay, kullanici_adi: String) {
        cartPageInteractor?.yemekSil(sepet: sepet, kullanici_adi: kullanici_adi)
    }
    func tumSepetiGetir() {
        cartPageInteractor?.sepetiGetir()
    }
}

extension CartPagePresenter : InteractorToPresenterCartPageProtocol {
    func sendDataToPresenter(yemekSayisi: Int) {
//        cartPageView?.viewaVeriGonder(yemekSayisi: yemekSayisi)
    }
    
    func presenteraVeriGonder(sepetListesi: Array<YemekDetay>) {
        cartPageView?.viewaVeriGonder(sepetListesi: sepetListesi)
    }
    
   
  
}
