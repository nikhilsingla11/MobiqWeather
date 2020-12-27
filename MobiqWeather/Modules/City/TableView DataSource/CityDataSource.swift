//
//  CityDataSource.swift
//  MobiqWeather
//
//  Created by Nikhil Aggarwal on 25/12/20.
//  Copyright © 2020 Demo Project. All rights reserved.
//

import UIKit

class CityDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    weak var context: CityViewController?
    var data: [WeatherCityViewModel] = []
    var selectedIndex: Int = 0
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCollectionViewCell", for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell.init() }
        if indexPath.row == selectedIndex {
            cell.setupView(viewModel: data[indexPath.row], isSelected: true)
        } else {
            cell.setupView(viewModel: data[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        context?.setupWeatherData(viewModel: data[indexPath.row])
    }
}
 
