//
//  LocationManager.swift
//  UpSticks-ios
//
//  Created by Rohit Saini on 17/04/20.
//  Copyright © 2020 Sukhmani. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

open class SainiLocationManager: NSObject {
    
    
    // - public
    public let locationManager = CLLocationManager()
    
    
    // - API
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
}


// MARK: - Core Location Delegate
extension SainiLocationManager: CLLocationManagerDelegate {
    
    
    public func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
    
        case .notDetermined         : log.error("notDetermined")/        // location permission not asked for yet
        case .authorizedWhenInUse   : log.success("authorizedWhenInUse")/  // location authorized
        case .authorizedAlways      : log.success("authorizedAlways")/     // location authorized
        case .restricted            : log.error("restricted")/           // TODO: handle
        case .denied                : log.error("denied")/               // TODO: handle
        @unknown default:
            fatalError()
        }
    }
}

// MARK: - Get Placemark
extension SainiLocationManager {
    
    
    public func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    public func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    public func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
