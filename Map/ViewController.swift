//
//  ViewController.swift
//  Map
//
//  Created by AtsushiShimizu on 2020/04/14.
//  Copyright © 2020 ats432. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Text Fieldのdelegate通知先を設定
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる（１）
        textField.resignFirstResponder()
        
        // 入力された文字を取り出す（２）
        if let searchKey = textField.text {
            // 入力された文字をデバッグエリアに表示（３）
            print(searchKey)
            
            // CLGeocoderインスタンスを取得（５）
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得（６）
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks,error)  in
            
                // 位置情報が存在する場合は、unwrapPlacemarksに取り出す（７）
                if let unwrapPlacemarks = placemarks {
                    
                    // １件目の情報を取り出す（８）
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        // 位置情報を取り出す（９）
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から軽度緯度をtargetCoordinateに取り出す（１０）
                            let targetCoordinate = location.coordinate
                            
                            // 軽度緯度をデバッグエリアに表示（１１）
                            print(targetCoordinate)
                            
                            
                            // MKPointAnnotationインスタンスを取得し、ピンを生成（１２）
                            let pin = MKPointAnnotation()
                            
                            // ピンを置く場所に軽度緯度を設定（１３）
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定（１４）
                            pin.title = searchKey
                            
                            // ピンを地図に置く（１５）
                            self.dispMap.addAnnotation(pin)
                            
                            //
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                            
                        }
                    }
                }
            })
        }
        
        // デフォルト動作を行うのでtrueを返す（４）
        return true
    }
}

