//
//  placesVC.swift
//  Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 19/12/2016.
//  Copyright © 2016 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Parse

class placesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeNamesArray = [String]()
    
    var tappedPlace = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        getDataFromServer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(placesVC.getDataFromServer), name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromPlacestoDetailsSegue" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.chosenPlace = self.tappedPlace
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tappedPlace = placeNamesArray[indexPath.row]
        self.performSegue(withIdentifier: "fromPlacestoDetailsSegue", sender: nil)
    }

    
    func getDataFromServer () {
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                self.placeNamesArray.removeAll(keepingCapacity: false)
                
                for object in objects! {
                    self.placeNamesArray.append(object.object(forKey: "name") as! String)
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "fromPlacestoAttributesSegue", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNamesArray[indexPath.row]
        return cell
    }
    
    

    @IBAction func signOutButtonClicked(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                UserDefaults.standard.removeObject(forKey: "userinfo")
                UserDefaults.standard.synchronize()
                
                let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "signInVC") as! signInVC
                
                let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                
                delegate.window?.rootViewController = signInVC
                
                delegate.rememberLogin()
                
            }
        }
        
        
    }
  
 
}
