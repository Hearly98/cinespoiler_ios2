//
//  DulceriaTableViewCell.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit

class DulceriaTableViewCell: UITableViewCell {
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var precioDulceLabel: UILabel!
    var dulceria: Dulcerias?
    var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureDulceria(dulceria: Dulcerias, viewController: UIViewController) {
        self.nombreLabel.text = "\(dulceria.nombre ?? "")"
        let precioString = "\(dulceria.precio)"
        precioDulceLabel.text = precioString
        
        self.dulceria = dulceria
        self.viewController = viewController
    }
}
