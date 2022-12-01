//
//  HomePageProtocols.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

protocol ViewToPresenterHomePageProtocol {
    var homePageInteractor : PresenterToInteractorHomePageProtocol? {get set}
    var homePageView : PresenterToViewHomePageProtocol? {get set}

    func ara(aramaKelimesi:String)
    func yemekleriGetir()
}

protocol PresenterToInteractorHomePageProtocol {
    var homePagePresenter : InteractorToPresenterHomePageProtocol? {get set}

    func yemekAra(aramaKelimesi:String)
    func tumYemekleriGetir()
}

protocol InteractorToPresenterHomePageProtocol {
    func presenteraVeriGonder(yemeklerListesi : Array<Yemekler>)
    
}

protocol PresenterToViewHomePageProtocol {
    func viewaVeriGonder(yemeklerListesi : Array<Yemekler>)
   
}

protocol PresenterToRouterHomePageProtocol {
    static func createModule(ref: HomePage)
}






