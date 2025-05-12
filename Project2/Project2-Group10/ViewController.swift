//
//  ViewController.swift
//  Project2-Group10
//
//  Created by Olivia Howard on 2024-11-30.
//

import UIKit
//Map List View Controller
class ViewController: UIViewController {
    
    var locationLatitude = 0.00
    var locationLongitude = 0.00
    var locationTitle = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    private var items: [ItemMapList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaultItems()
        tableView.dataSource = self
        tableView.delegate = self
    }
    //IBAction for when add (+) button is tapped
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        //Alert to add new location
        let alertController = UIAlertController(title: "Add Location", message: "Enter the title, latitude, and longitude for the location", preferredStyle: .alert)
        
        alertController.addTextField{ textField in
            textField.placeholder = "Location Title"
        }
        
        alertController.addTextField{ textField in
            textField.placeholder = "Latitude"
        }
        
        alertController.addTextField{ textField in
            textField.placeholder = "Longitude"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
            
            if let titleTextField = alertController.textFields?[0] as? UITextField, let latitudeTextField = alertController.textFields?[1] as? UITextField, let longitudeTextField = alertController.textFields?[2] as? UITextField {
                
                
                let title = titleTextField.text
                let latitude = latitudeTextField.text
                let longitude = longitudeTextField.text
                
                //Check to make sure all fields are filled out
                if title?.isEmpty ?? true || latitude?.isEmpty ?? true || longitude?.isEmpty ?? true {
                    let errorAlert = UIAlertController(title: "Error adding location", message: "All fields are required", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(errorAlert, animated: true)
                    return
                }
                //Check to make sure latitude is within appropriate range
                guard let lat = Double(latitude ?? "0.00"), lat >= -90, lat <= 90
                else{
                    let errorAlert = UIAlertController(title: "Error adding location", message: "Latitude must be a valid number", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(errorAlert, animated: true)
                    return
                }
                //Check to make sure longitude is within appropriate range
                guard let long = Double(longitude ?? "0.00"), long >= -180, long <= 180
                else{
                    let errorAlert = UIAlertController(title: "Error adding location", message: "Longitude must be a valid number", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(errorAlert, animated: true)
                    return
                }
                
                let item = ItemMapList(title: title ?? "", latitude: lat, longitude: long)
                self.items.append(item)
                self.tableView.reloadData()
            }
        }))
        
        self.present(alertController, animated: true)
    }
    
    //Load default locations into list
    private func loadDefaultItems(){
        items.append(ItemMapList(title: "Eiffel Tower", latitude: 48.8584, longitude: 2.2945))
        items.append(ItemMapList(title: "Statue of Liberty", latitude: 40.6892, longitude: -74.0445))
        items.append(ItemMapList(title: "Great Wall of China", latitude: 40.4319, longitude: 116.5704))
        items.append(ItemMapList(title: "Sydney Opera House", latitude: -33.8568, longitude: 151.2153))
        items.append(ItemMapList(title: "Christ the Redeemer", latitude: -22.9519, longitude: -43.2105))
        items.append(ItemMapList(title: "Colosseum", latitude: 41.8902, longitude: 12.4922))
        items.append(ItemMapList(title: "Machu Picchu", latitude: -13.1631, longitude: -72.5450))
    }
    
    //Override to send data to destination view controller on segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
       if segue.identifier == "goToMapDetails"{
           
           if let destinationVC = segue.destination as? MapViewController {
               destinationVC.lat = locationLatitude
               destinationVC.long = locationLongitude
               destinationVC.locTitle = locationTitle
           }
            
        }
    }

    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mapListCell", for: indexPath)
        let item = items[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = "Latitude: \(item.latitude), Longitude: \(item.longitude)"
        content.image = UIImage(systemName: "location.fill")
        
        cell.contentConfiguration = content
        return cell
    }
    
    
}
//Perform segue to Map Details when user selects row in tableView
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = items[indexPath.row]
        
        locationTitle = selectedLocation.title
        locationLatitude = selectedLocation.latitude
        locationLongitude = selectedLocation.longitude
        
        print(locationTitle)
        print(locationLatitude)
        print(locationLongitude)
        
        performSegue(withIdentifier: "goToMapDetails", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
//Struct for items in Map List
struct ItemMapList{
    let title: String
    let latitude: Double
    let longitude: Double
}

