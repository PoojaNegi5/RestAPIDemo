//
//  ViewController.swift
//  RestAPIDemo
//
//  Created by Appinventiv on 23/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit
var infoLabel : UILabel = UILabel()
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    
    var names  = [String]()
    var addresses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.separatorColor = .clear
        infoLabel.frame = CGRect(x: 10,y:75,width: 320,height: 160)
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "View Loaded \n"
        view.addSubview(infoLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func searchButtonClicked(_ sender: UIButton) {
        let typedText : String? = searchTextField.text!
        if typedText?.isEmpty == true{
            print("invalid search")
        }
        else{
            infoLabel.text = infoLabel.text! + "Control passed to API Controller\n"
            APIController().getModel(userEnteredText: typedText!, success: { (data) in
                
             for object in data.results
             {
                self.names.append(object.name)
                self.addresses.append(object.address)
                DispatchQueue.main.async {
                       self.tableView.reloadData()
                }
//                print(object.name)
//                print(object.address)
//                print("&************")
            }
                DispatchQueue.main.async {
                    infoLabel.text = infoLabel.text! + "Data transferred into table view\n"
                }
                
            })
        }
        UIView.animate(withDuration: 1, delay: 1.5, options: .transitionFlipFromLeft, animations: {
           self.tableView.isHidden = false
        }, completion: nil)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TableViewCell
        cell.nameLabel.text = names[indexPath.row]
        cell.addressLabel.text = addresses[indexPath.row]
        print(names[indexPath.row])
        print("9999999999999999999")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

