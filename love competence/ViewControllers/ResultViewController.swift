//
//  ResultViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/05/22.
//

import UIKit
import RealmSwift

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
    @IBOutlet var Total: UILabel!
    
//    let defaults: UserDefaults = UserDefaults.standard
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Q4\(scoreQ4)")
        print("Q5\(scoreQ5)")
        print("Q9\(scoreQ9)")
        print("Q10\(scoreQ10)")
        print("誠実性\(con)")
        print("メンタル\(men)")
        print("適性\(scoreQ10)")
        
        calculateConscience()
        calculateMental()
        calculateTotal()
    }
    
    func calculateConscience(){
        con = (scoreQ4 + scoreQ9)*10
        conscience.text = "\(con)%"
        
        //データをrealmに保存
        let user = Score()
        user.createdAt = Date()
        user.totalScore = total
        try! realm.write {
            realm.add(user)
        }
    }

    func calculateMental(){
        men = (scoreQ5 + scoreQ10)*10
        mental.text = "\(men)%"
    }

    func calculateTotal(){
        total = (con + men)/2
        Total.text = "\(total)%"
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
