//
//  AddToCartPageProtocols.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

protocol ViewToPresenterCartPageProtocol {
    var cartPageInteractor : PresenterToInteractorCartPageProtocol? {get set}
    var cartPageView : PresenterToViewCartPageProtocol? {get set}
    
    func tumSepetiGetir()
    func sil(sepet: YemekDetay, kullanici_adi: String)
    func sepetiSil(carts : Array<YemekDetay>)
    func getCount()

}
protocol PresenterToInteractorCartPageProtocol {
    var cartPagePresenter : InteractorToPresenterCartPageProtocol? {get set}
    
    func sepetiGetir()
    func yemekSil(sepet: YemekDetay, kullanici_adi: String)
    
    func sepetinHepsiniSil(carts : Array<YemekDetay>)
    func getCount()
}

protocol InteractorToPresenterCartPageProtocol {
    func presenteraVeriGonder(sepetListesi : Array<YemekDetay>)
    func sendDataToPresenter(yemekSayisi : Int)
}

protocol PresenterToViewCartPageProtocol {
    func viewaVeriGonder(sepetListesi : Array<YemekDetay>)
//    func viewaVeriGonder(yemekSayisi : Int)
}

protocol PresenterToRouterCartPageProtocol{
    static func createModule(ref:CartPage)
}

