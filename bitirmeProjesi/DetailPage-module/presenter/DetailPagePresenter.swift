//
//  DetailPagePresenter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation


class DetailPagePresenter:ViewToPresenterDetailPageProtocol {
    func yemekEkle(yemek: Yemekler, adet: Int, username: String) {
        yemekDetayInteractor?.sepeteYemekEkle(yemek: yemek, adet: adet, username: username)
    }
    
    var yemekDetayInteractor: PresenterToInteractorDetailPageProtocol?
    
    
}


