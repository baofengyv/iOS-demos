//
//  ViewController.swift
//  Trax-i
//
//  Created by b on 16/4/8.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit
import MapKit

class GPXViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .Satellite //卫星地图
            mapView.delegate = self
        }
    }
    
    var gpxURL:NSURL? {
        didSet {
            
            clearWayPoints()
            if let url = gpxURL {
                // 这个地方可以写死传递一个url
                var points:[MKAnnotation] = []
                
                handleWayPoints(points)
            }
        }
    }
    
    private func clearWayPoints () {
        if mapView?.annotations != nil {
            mapView.removeAnnotations(mapView.annotations as [MKAnnotation])
        }
    }
    private func handleWayPoints (wayPoint:MKAnnotation) {
        mapView.addAnnotation(wayPoint)
        mapView.showAnnotations(wayPoint, animated: true)
    }

    // MARK: - Constants
    
    private struct Constants {
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationViewReuseIdentifier = "waypoint"
        static let ShowImageSegue = "Show Image"
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(Constants.AnnotationViewReuseIdentifier)
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
            view?.canShowCallout = true
        } else {
            view?.annotation = annotation
        }
        return view
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 接收电台信息
        // 获取默认的通知中心
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName(GPXURL.Notification, //要监听的广播名
                                  object: appDelegate, // 这个app的delegate 就是那个AppDelegate
                                  queue: queue)        //运行闭包的队列
        { notification in
          
        }
        
        
         gpxURL = NSURL(string: "http://192.168.1.170/html/x.gpx") // for demo/debug/testing
    }

}