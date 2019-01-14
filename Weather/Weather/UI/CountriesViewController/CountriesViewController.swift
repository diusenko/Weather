//
//  CountriesViewController.swift
//  Weather
//
//  Created by Usenko Dmitry on 1/10/19.
//  Copyright © 2019 Usenko Dmitry. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, RootViewRepresentable, UITableViewDataSource, UITableViewDelegate {
    
    typealias RootView = CountriesView
    
    var model = Countries() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.countriesTableView?.reloadData()
            }
        }
    }
    
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Kiev&APPID=93ed6d9a1885eeb796fe06b73dea3866")
    
    struct Countries: Codable {
        var values = [Country]()
    }
    
    struct Country: Codable {
        let name: String
        let capital: String
    }
    
    struct Main: Codable {
        let main: [String : Double]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //self.rootView?.countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.rootView?.countriesTableView.delegate = self
        self.rootView?.countriesTableView.dataSource = self
        
        self.getData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherViewController = WeatherViewController()
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = self.rootView?.countriesTableView?.dequeueReusableCell(withIdentifier: "cell")
        let cell = UITableViewCell()
        let item = self.model.values[indexPath.row]
        cell.textLabel?.text = item.name + " " + item.capital
         //let item = self.modelWeather.values[indexPath.row]
        //cell?.textLabel?.text = "\(item.temp)"
        
        return cell
    }
    
    func getData() {
        if let url = self.url {
            URLSession.shared.dataTask(with: url) { (data, respose, error) in
                guard let data = data else { return }
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    self.model.values = countries

                } catch let jsonError {
                    print("Error", jsonError)
                }
                }.resume()
        }
        
//        if let url = self.weatherUrl {
//            URLSession.shared.dataTask(with: url) { (data, respose, error) in
//                guard let data = data else { return }
//                do {
//                    //print(String(bytes: data, encoding: .utf8)!)
//                    let weather = try JSONDecoder().decode(Main.self, from: data)
//                    print(weather.main["temp"])
//
//                } catch let jsonError {
//                    print("Error", jsonError)
//                }
//                }.resume()
//        }
    }
}
