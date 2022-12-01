//
//  DetailPageRouter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

class DetailPageRouter:PresenterToRouterDetailPageProtocol {
    static func createModule(ref: DetailPage) {
        ref.yemekDetayPresenterNesnesi = DetailPagePresenter()
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = DetailPageInteractor()
    }
    
    
}
