//
//  MatchInfoViewController.swift
//  SportzCric
//
//  Created by Smollan Karan on 08/11/23.
//

import UIKit

class MatchInfoViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var transperentView: UIView!
    @IBOutlet weak var infoTableView: UITableView!
    
    var arr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.delegate = self
        self.transperentView.addGestureRecognizer(tap)
        self.prepareView()
    }
    
    func prepareView() {
        self.popUpView.layer.cornerRadius = 15
        self.popUpView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        self.infoTableView.delegate = self
        self.infoTableView.dataSource = self
        self.infoTableView.register(UINib(nibName: "MatchInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchInfoTableViewCell")
        
        self.infoTableView.reloadData()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}

extension MatchInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchInfoTableViewCell", for: indexPath) as? MatchInfoTableViewCell else {
            return MatchInfoTableViewCell()
        }
        cell.infoLabel.text = self.arr[indexPath.row]
        return cell
    }
    
    
}
