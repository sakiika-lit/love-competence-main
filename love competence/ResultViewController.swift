//
//  ResultViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/05/22.
//

import UIKit

class ResultViewController: UIViewController {
    
    var scoreQ4: Int = 0
    var scoreQ5: Int = 0
    var scoreQ9: Int = 0
    var scoreQ10: Int = 0
    
    var con: Int = 0
    var men: Int = 0
    var total: Int = 0
    @IBOutlet var conscience: UILabel!
    @IBOutlet var mental: UILabel!
    @IBOutlet var competence: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calculateConscience()
        calculateMental()
        calculateCompetence()
        
}
    
    func calculateConscience(){
        con = (scoreQ4 + scoreQ9)/10*100
        conscience.text = String(con) + "%"
    }
    
    func calculateMental(){
        men = (scoreQ5 + scoreQ10)/10*100
        conscience.text = String(men) + "%"
    }
    
    func calculateCompetence(){
        total = (con + men)/200*100
        conscience.text = String(total) + "%"
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
