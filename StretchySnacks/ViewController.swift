//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Javier Xing on 2017-12-07.
//  Copyright © 2017 Javier Xing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var navBarButton: UIButton!
    
    var navBarIsOpen: Bool = false
    var snacksStackView: UIStackView?
    var savedSnacks: [String] = []
    var titleCenterYConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setupStackView()
        setupLabel()
        snacksStackView?.isHidden = true
        
    }
    
    func setupStackView(){
        let oreoImage = UIImageView(image: UIImage(named: "oreos"))
        let pocketImage = UIImageView(image: UIImage(named: "pizza_pockets"))
        let poptartsImage = UIImageView(image: UIImage(named: "pop_tarts"))
        let popsicleImage = UIImageView(image: UIImage(named: "popsicle"))
        let ramenImage = UIImageView(image: UIImage(named: "ramen"))
        
        snacksStackView = UIStackView(arrangedSubviews: [oreoImage, pocketImage, poptartsImage, popsicleImage, ramenImage])
        self.navBar.addSubview(snacksStackView!)
        
        snacksStackView?.axis = .horizontal
        snacksStackView?.distribution = .fillEqually
        snacksStackView?.alignment = .fill
        snacksStackView?.spacing = 8
        snacksStackView?.translatesAutoresizingMaskIntoConstraints = false
        snacksStackView?.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 0).isActive = true
        snacksStackView?.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: 0).isActive = true
        snacksStackView?.bottomAnchor.constraint(equalTo: self.navBar.bottomAnchor, constant: -10).isActive = true
        snacksStackView?.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let tapOreo = UITapGestureRecognizer(target: self, action: #selector(addSnack(sender:)))
        oreoImage.isUserInteractionEnabled = true
        oreoImage.addGestureRecognizer(tapOreo)
        tapOreo.name = "oreo"
        
        let tapPizzaPocket = UITapGestureRecognizer(target: self, action: #selector(addSnack(sender:)))
        pocketImage.isUserInteractionEnabled = true
        pocketImage.addGestureRecognizer(tapPizzaPocket)
        tapPizzaPocket.name = "pizzaPocket"
        
        let tapPopTart = UITapGestureRecognizer(target: self, action: #selector(addSnack(sender:)))
        poptartsImage.isUserInteractionEnabled = true
        poptartsImage.addGestureRecognizer(tapPopTart)
        tapPopTart.name = "popTart"
        
        let tapPopsicle = UITapGestureRecognizer(target: self, action: #selector(addSnack(sender:)))
        popsicleImage.isUserInteractionEnabled = true
        popsicleImage.addGestureRecognizer(tapPopsicle)
        tapPopsicle.name = "popsicle"
        
        
        let tapRamen = UITapGestureRecognizer(target: self, action: #selector(addSnack(sender:)))
        ramenImage.isUserInteractionEnabled = true
        ramenImage.addGestureRecognizer(tapRamen)
        tapRamen.name = "ramen"
        
    }
    
    func setupLabel(){
        let titleLabel = UILabel()
        titleLabel.text = "SNACKS"
        navBar.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleCenterYConstraint = titleLabel.centerYAnchor.constraint(equalTo: navBar.centerYAnchor)
        titleCenterYConstraint!.isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
    }
    
    @objc func addSnack(sender: UITapGestureRecognizer) {
        switch sender.name {
        case "oreo"?:
            savedSnacks.insert("Oreo", at: 0)
        case "pizzaPocket"?:
            savedSnacks.insert("Pizza Pocket", at: 0)
        case "popTart"?:
            savedSnacks.insert("PopTart", at: 0)
        case "popsicle"?:
            savedSnacks.insert("Popsicle", at: 0)
        case "ramen"?:
            savedSnacks.insert("Ramen", at: 0)
        default:
            return
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    
    
    @IBAction func plusIconPressed(_ sender: Any) {
        
        if !navBarIsOpen {
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
                self.heightConstraint.constant = 200
                self.titleCenterYConstraint?.constant = -40
                self.view.layoutIfNeeded()
                
                self.navBarButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
                self.navBarIsOpen = true
                self.snacksStackView?.isHidden = false
            }, completion: nil)
            
            
            
        }
        else{
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
                self.heightConstraint.constant = 64
                self.titleCenterYConstraint?.constant = 0
                self.view.layoutIfNeeded()
                
                self.navBarButton.transform = CGAffineTransform(rotationAngle: 0)
                self.navBarIsOpen = false
                self.snacksStackView?.isHidden = true
            }, completion: nil)
    }
    
}
    
//    Mark: TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return savedSnacks.count
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        let snackString: String = savedSnacks[indexPath.row]
    
        cell.textLabel?.text = snackString
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    
}
