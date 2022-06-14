//
//  ResultViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/05/22.
//

import UIKit

class ResultViewController: UIViewController {
  
    var con: Double = 0
    var men: Double = 0
    var total: Double = 0
    
    @IBOutlet var conscience: UILabel!
    @IBOutlet var mental: UILabel!
    @IBOutlet var Total: UILabel!
    @IBOutlet weak var crown: UIImageView!
    @IBOutlet var anatano: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        anatano.adjustsFontSizeToFitWidth = true
        
        print("誠実性\(con)")
        print("メンタル\(men)")
        print("適性\(total)")
               
        conscience.text = "\(Int(con))%"
        mental.text = "\(Int(men))%"
        Total.text = "\(Int(total))%"
        
        if total <= 33{
            crown.tintColor = UIColor.brown
        }else if total >= 66{
            crown.tintColor = UIColor.yellow
        }else{
            crown.tintColor = UIColor.gray
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
