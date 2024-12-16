//
//  ListDulceriaViewController.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit

class ListDulceriaViewController: UIViewController {
    @IBOutlet weak var nombreDulceLabel: UILabel!
    @IBOutlet weak var precioDulceLabel: UILabel!
    var dulceria: Dulceria?
    var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurePerson(person: Person, viewController: UIViewController) {
        self.nombreDulceLabel.text = "\(dulceria.nombre ?? "")"
        self.precioDulceLabel.text = "\(dulceria.precio ?? "")"
        self.dulceria = dulceria
        self.viewController = viewController
    }
}
