//
//  DetailPageProtocols.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

protocol ViewToPresenterDetailPageProtocol {
    var yemekDetayInteractor : PresenterToInteractorDetailPageProtocol? {get set}
    
    func yemekEkle(yemek: Yemekler, adet: Int, username: String)
    
}

protocol PresenterToInteractorDetailPageProtocol {
    func sepeteYemekEkle(yemek: Yemekler, adet: Int, username: String)
   
}

protocol PresenterToRouterDetailPageProtocol {
    static func createModule(ref:DetailPage)
}
