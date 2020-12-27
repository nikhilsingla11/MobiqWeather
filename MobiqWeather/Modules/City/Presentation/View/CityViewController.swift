//
//  CityViewController.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var vwContainer: UIView!
    @IBOutlet private weak var vwCollectionContainer: UIView!
    @IBOutlet private weak var activityController: UIActivityIndicatorView!
    @IBOutlet private weak var lblMaxTemp: UILabel!
    @IBOutlet private weak var lblMinTemp: UILabel!
    @IBOutlet private weak var lblFeelsLike: UILabel!
    @IBOutlet private weak var lblHumid: UILabel!
    @IBOutlet private weak var lblRain: UILabel!
    @IBOutlet private weak var lblWind: UILabel!
    @IBOutlet private weak var vwMaxTemp: UIView!
    @IBOutlet private weak var vwMinTemp: UIView!
    private lazy var dataSource: CityDataSource = CityDataSource()
    private var weatherArray: [WeatherCityViewModel] = []
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: "DateCollectionViewCell", bundle: nil)
        cv.register(nib, forCellWithReuseIdentifier: "dateCollectionViewCell")
        return cv
    }()
    private var selectedCity = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
        fetchCityWeather(city: selectedCity)
    }
    
    func setupView() {
        lblTitle.text = selectedCity
        vwContainer.isHidden = true
        vwMaxTemp.isHidden = !PermissionManager.isMaxTempEnabled()
        vwMinTemp.isHidden = !PermissionManager.isMinTempEnabled()
    }
    
    private func setupCollectionView() {
        dataSource.context = self
        vwCollectionContainer.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.topAnchor.constraint(equalTo: vwCollectionContainer.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: vwCollectionContainer.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: vwCollectionContainer.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: vwCollectionContainer.bottomAnchor, constant: 0).isActive = true
    }

    func setupWeatherData(viewModel: WeatherCityViewModel) {
        lblMaxTemp.text = viewModel.getMaxTemp()
        lblMinTemp.text = viewModel.getMinTemp()
        lblFeelsLike.text = viewModel.getFeelsLikeTemp()
        lblHumid.text = viewModel.getHumidity()
        lblRain.text = viewModel.getCloudCover()
        lblWind.text = viewModel.getWindSpeed()
    }
}

//Actions
extension CityViewController {
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//Utils
extension CityViewController {
    static func instantiate(city: String) -> CityViewController? {
        let storyboard: UIStoryboard = UIStoryboard.init(name: "City", bundle: nil)
        if let vc: CityViewController = storyboard.instantiateViewController(withIdentifier: "CityVC") as? CityViewController {
            vc.selectedCity = city
            return vc
        }
        return nil
    }
}

//API calls
extension CityViewController {
    func fetchCityWeather(city: String) {
        activityController.startAnimating()
        NetworkManager().fetchCityData(cityName: city) { (response) in
                switch response {
                case .success(let viewModel):
                    self.weatherArray = viewModel
                    self.dataSource.data = self.weatherArray
                case .failure(let error):
                    print("Failed to fetch data", error)
            }
            DispatchQueue.main.async {
                self.activityController.isHidden = true
                self.activityController.stopAnimating()
                self.vwContainer.isHidden = false
                self.collectionView.reloadData()
                self.setupWeatherData(viewModel: self.weatherArray[0])
            }
        }
    }
}
