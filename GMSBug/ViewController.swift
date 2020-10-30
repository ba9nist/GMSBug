//
//  ViewController.swift
//  GMSBug
//
//  Created by Yevhenii Boryspolets on 29.10.2020.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(MapCell.self, forCellReuseIdentifier: "MapCell")
        return view
    }()
    
    let positionLondon = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.127)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapCell
        cell.configure(model: .init(coordinates: positionLondon))
        return cell
    }
}

class MapCell: UITableViewCell {
    struct ViewModel {
        let location: CLLocation
        
        init(coordinates: CLLocationCoordinate2D) {
            location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
    }
    
    let mapView: GMSMapView = {
        let view = GMSMapView()
        view.isMyLocationEnabled = false
        view.settings.myLocationButton = false
        view.settings.rotateGestures = false
        view.settings.tiltGestures = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    func configure(model: ViewModel) {
//        mapView.animate(to: GMSCameraPosition(target: model.location.coordinate, zoom: 15))
        mapView.camera = GMSCameraPosition(target: model.location.coordinate, zoom: 15)
        setupMarker(location: model.location)
    }
    
    private func setupMarker(location: CLLocation) {
        let marker = GMSMarker(position: location.coordinate)
        marker.icon = UIImage(named: "map")
        marker.map = mapView
    }
    
    private func setupView() {
        contentView.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 287).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

