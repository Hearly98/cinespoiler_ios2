//
//  ListTablePeliculaViewCell.swift
//  cinespoiler_ios
//
//  Created by DISEÑO on 15/12/24.
//
import Alamofire
import UIKit
import AlamofireImage


class ListTablePeliculaViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var tituloCell: UILabel!
    @IBOutlet weak var precioCell: UILabel!
    
   
    override func awakeFromNib() {
          super.awakeFromNib()
          selectionStyle = .none
          layer.cornerRadius = 10
          backgroundColor = UIColor.clear
      }

      func configureView(movie: MovieResponse?) {
          guard let movie = movie else { return }
          tituloCell.text = movie.titulo
          precioCell.text = String(format: "S/. %.2f", movie.precio)
          
          if let url = URL(string: movie.imagen) {
              imageCell.af.setImage(withURL: url) // Usa AlamofireImage directo sin sesión
          }
          
          imageCell?.contentMode = .scaleAspectFill
          imageCell?.layer.cornerRadius = 10
          viewCell?.layer.shadowOffset = CGSize.zero
          viewCell?.layer.shadowRadius = 1
          viewCell?.layer.shadowOpacity = 1
          viewCell?.layer.cornerRadius = 40
      }
}
