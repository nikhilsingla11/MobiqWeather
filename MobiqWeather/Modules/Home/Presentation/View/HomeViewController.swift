//
//  HomeViewController.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    @IBOutlet private weak var tableVwHome: UITableView!
    @IBOutlet private weak var lblBookmarkError: UILabel!
    @IBOutlet private weak var mapVw: MKMapView!
    @IBOutlet private weak var vwMap: UIView!
    private lazy var dataSource: HomeDataSource = HomeDataSource()
    private var bookmarkedArray: [AnnotationModel] = []
    lazy var router: HomeRouter = {
        let router = HomeRouter()
        router.context = self
        return router
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarkedArray = BookmarkManager.getBookmarkedCities() ?? []
        setupTableview()
        registerNotification()
        addTapGesture()
        setMapAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        vwMap.isHidden = !PermissionManager.isMapEnabled()
    }

    private func setupTableview() {
        registerNib()
        dataSource.context = self
        dataSource.data = bookmarkedArray
        tableVwHome.dataSource = dataSource
        tableVwHome.delegate = dataSource
        checkBookmarkError()
    }
    
    private func registerNib() {
        tableVwHome.register(UINib(nibName: "HomeListTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.homeCellId)
    }
    
    func removeBookmarkFromList(model: AnnotationModel) {
        bookmarkedArray = BookmarkManager.getBookmarkedCities() ?? []
        dataSource.data = bookmarkedArray
        for annotation in mapVw.annotations {
            if annotation.title == model.city {
                mapVw.removeAnnotation(annotation)
            }
        }
        checkBookmarkError()
        tableVwHome.reloadData()
    }
    
    private func checkBookmarkError() {
        if bookmarkedArray.count == 0 {
            tableVwHome.isHidden = true
            lblBookmarkError.isHidden = false
        } else {
            tableVwHome.isHidden = false
            lblBookmarkError.isHidden = true
        }
    }
    
    private func setMapAnnotations() {
        mapVw.removeAnnotations(mapVw.annotations)
        for bookmarkCity in bookmarkedArray {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(bookmarkCity.latitude)!, longitude: CLLocationDegrees(bookmarkCity.longitude)!)
            annotation.title = bookmarkCity.city
            self.mapVw.addAnnotation(annotation)
        }
    }
    
}

extension HomeViewController {
    @IBAction func searchBtnClicked(_ sender: Any) {
        router.routeToSearchScreen()
    }
    
    @IBAction func btnSettingsClicked(_ sender: Any) {
        router.routeToSettingsScreen()
    }
}

extension HomeViewController {
    func registerNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("BookmarkedChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBookmarkedList), name: NSNotification.Name.init("BookmarkedChanged"), object: nil)
    }
    
    @objc func refreshBookmarkedList() {
        bookmarkedArray = BookmarkManager.getBookmarkedCities() ?? []
        dataSource.data = bookmarkedArray
        checkBookmarkError()
        setMapAnnotations()
        tableVwHome.reloadData()
    }
    
    func addTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        mapVw.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        let location = sender.location(in: mapVw)
        let coordinate = mapVw.convert(location, toCoordinateFrom: mapVw)
        
        // Added below code to get city name & placing a pin on map.
        let geoCoder = CLGeocoder()
        let location1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location1, completionHandler: { placemarks, error -> Void in
            guard let placeMark = placemarks?.first else { return }
            if let city = placeMark.subAdministrativeArea, let cityName = city.components(separatedBy: " ").first {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = cityName
                self.mapVw.addAnnotation(annotation)
                let annotationModel = AnnotationModel(city: cityName, longitude: String(coordinate.longitude), latitude: String(coordinate.latitude))
                BookmarkManager.editBookmarkedCities(model: annotationModel)
                self.refreshBookmarkedList()
            }
        })
    }
}
