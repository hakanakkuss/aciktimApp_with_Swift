//
//  YemekDetay.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import Foundation

class YemekDetay : Codable {
        var sepet_yemek_id:String?
        var yemek_adi:String?
        var yemek_resim_adi:String?
        var yemek_fiyat:String?
        var yemek_siparis_adet:String?
        var kullanici_adi:String?
    //initializers
        init(sepet_yemek_id:String?, yemek_adi:String?, yemek_resim_adi:String?, yemek_siparis_adet:String?, kullanici_adi:String?)
        {
            self.sepet_yemek_id = sepet_yemek_id
            self.yemek_adi = yemek_adi
            self.yemek_resim_adi = yemek_resim_adi
            self.yemek_siparis_adet = yemek_siparis_adet
            self.kullanici_adi = kullanici_adi
        }
}
