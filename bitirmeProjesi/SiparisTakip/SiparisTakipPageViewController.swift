//
//  SiparişTakipPageViewController.swift
//  bitirmeProjesi
//
//  Created by Macbook Pro on 20.10.2022.
//

import UIKit
import Lottie
import CoreLocation
import MapKit

class SiparisTakipPageViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "11990-moving-vehicle")
        animationView.frame = CGRect(x: 110, y: 108, width: 200, height: 200)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
    
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        
    }
    
    @IBAction func goToHomePageButton(_ sender: Any) {
      performSegue(withIdentifier: "toHomePage", sender: nil)
    }
}

extension SiparisTakipPageViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum = locations[locations.count - 1]
        
        let enlem = sonKonum.coordinate.latitude
        let boylam = sonKonum.coordinate.longitude
        let hiz = sonKonum.speed
        
        
        let location = CLLocationCoordinate2D(latitude: enlem, longitude: boylam)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
    
    }
}
