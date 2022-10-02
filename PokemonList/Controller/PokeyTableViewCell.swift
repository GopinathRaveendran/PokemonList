//
//  PokeyTableViewCell.swift
//  PokemonList
//
//  Created by gopinath.raveendran on 19/08/2022.
//

import UIKit
import SDWebImage
class PokeyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokeyImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var supertypeLabel: UILabel!
    @IBOutlet weak var evolvesFromLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    
    override func prepareForReuse() {
        pokeyImageView.image = nil
        nameLabel.text = ""
        supertypeLabel.text = ""
        evolvesFromLabel.text = ""
        hpLabel.text = ""
    }
    
    
    func setupUI(withdrawFrom: Card){
        nameLabel.text = "Name: " + withdrawFrom.name
        hpLabel.text = "Card value: " + (withdrawFrom.hp ?? "")
        evolvesFromLabel.text = "Evolves From: " + (withdrawFrom.evolvesFrom ?? "")
        
        self.pokeyImageView.sd_setImage(with: URL(string: withdrawFrom.imageURL), placeholderImage: UIImage(named: "pok.png"))
        
        if let supertype = withdrawFrom.supertype {
            supertypeLabel.text = "Type: " + supertype
            
            if withdrawFrom.supertype == "Trainer"{
                contentView.backgroundColor = .cyan
            }else{
                contentView.backgroundColor = .systemGreen
            }
        }
    }
}







