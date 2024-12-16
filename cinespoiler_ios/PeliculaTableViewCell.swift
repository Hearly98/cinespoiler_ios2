//
//  PeliculaTableViewCell.swift
//  cinespoiler_ios
//
//  Created by DAMII on 15/12/24.
//

import UIKit

class PeliculaTableViewCell: UITableViewCell {
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    var pelicula: Pelicula?
    var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurePelicula(pelicula: Pelicula, viewController: UIViewController) {
        let precioString = "\(pelicula.precio)"
        precioLabel.text = precioString
        self.tituloLabel.text = pelicula.titulo ?? ""
        self.pelicula = pelicula
        self.viewController = viewController
    }
}
