//
//  AddToCartPageRouter.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

class CartPageRouter:PresenterToRouterCartPageProtocol {
    static func createModule(ref: CartPage) {
        let presenter = CartPagePresenter()
        ref.cartPagePresenterObject = presenter
        ref.cartPagePresenterObject?.cartPageInteractor = CartPageInteractor()
        ref.cartPagePresenterObject?.cartPageView = ref
        ref.cartPagePresenterObject?.cartPageInteractor?.cartPagePresenter = presenter
    }
    

}
