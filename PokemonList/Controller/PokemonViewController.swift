//
//  PokemonViewController.swift
//  PokemonList
//
//  Created by gopinath.raveendran on 19/08/2022.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    var pokey: [Card] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokémon List"
        getPokemonData()
    }
   
    func getPokemonData(){
        let jsonUrl = "https://api.pokemontcg.io/v1/cards"
//    https://api.pokemontcg.io/v2/cards
        guard let url = URL(string: jsonUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (myData, myResponse, myError) in
            
            if myError != nil {
                print((myError?.localizedDescription)!)
            }
            
            guard let data = myData else{
                print(myError as Any)
                return
            }
            
            do{
                let jsonData = try JSONDecoder().decode(Pokemon.self, from: data)
//                print("jsonData: ", jsonData)
                print("Hello")
                self.pokey = jsonData.cards
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                }
            }catch{
                print("Error:::::: ", myError as Any)
            }
            
        }.resume()
    }
    
    

    var isFavButton = UserDefaults.standard.bool(forKey: "isFavButton")
  
    
   
    @IBAction func favButtonTapped(_ sender: AnyObject) {
        if isFavButton {
                let image = UIImage(named: "Pokemon.png")
            (sender as AnyObject).setImage(image, for: .normal)
            } else {
                let image = UIImage(named: "Pokemon_selected.png")
                sender.setImage(image, for: .normal)
            }

            isFavButton = !isFavButton
            UserDefaults.standard.set(isFavButton, forKey: "isFavButton")
            UserDefaults.standard.synchronize()
        }
    }
    
    
//end class

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokey.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokeyTableViewCell", for: indexPath) as? PokeyTableViewCell else {return UITableViewCell()}
        
        let pok = pokey[indexPath.row]
        cell.setupUI(withdrawFrom: pok)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
