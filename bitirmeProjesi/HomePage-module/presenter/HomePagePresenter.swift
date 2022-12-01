//
//  HomePagePresenter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

class HomePagePresenter:ViewToPresenterHomePageProtocol {
    var homePageInteractor: PresenterToInteractorHomePageProtocol?
    var homePageView: PresenterToViewHomePageProtocol?
    
    func ara(aramaKelimesi: String) {
        homePageInteractor?.yemekAra(aramaKelimesi: aramaKelimesi)
    }
    
    func yemekleriGetir() {
        homePageInteractor?.tumYemekleriGetir()
    }
}

extension HomePagePresenter : InteractorToPresenterHomePageProtocol {
    func presenteraVeriGonder(yemeklerListesi: [Yemekler]) {
        homePageView?.viewaVeriGonder(yemeklerListesi: yemeklerListesi)
        
    }
}

