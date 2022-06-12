//
//  TestViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/05/22.
//

import UIKit
import RealmSwift

class TestViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var questionArray = [String]()
    var nowNumber: Int = 0
    var scoreQ4: Double = 0
    var scoreQ5: Double = 0
    var scoreQ9: Double = 0
    var scoreQ10: Double = 0
    var otherScore: Int = 0
    var none: Int = 0
    
    var con: Double = 0
    var men: Double = 0
    var total: Double = 0
    
    let answers = ["完全に当てはまる","やや当てはまる","どちらとも言えない","ほとんど当てはまらない","全く当てはまらない"]
    let defaults: UserDefaults = UserDefaults.standard
    let realm = try! Realm()
    
    @IBOutlet var question: UILabel!
    @IBOutlet var nowNumberLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        nowNumber += 1
        nowNumberLabel.text = String(nowNumber)+"/10"
        questionArray.append("ここに問題が表示されます")
        questionArray.append("初対面の人と積極的に\n話すことができる")
        questionArray.append("他人の快適さや幸せを願い\n差別なく行動できる")
        questionArray.append("好奇心が強い性格で\nクリエイティブな活動が好き")
        questionArray.append("計画を立て、事前準備を\nしっかりと行う")
        questionArray.append("憂鬱な気分になったり\n落ち込むことが多い")
        questionArray.append("人前に出ることが好きでなく\n控えめな性格")
        questionArray.append("他人の感情を気にせず\n言いたいことを言う")
        questionArray.append("形式や伝統を重視し\n型破りなことはあまりしない")
        questionArray.append("あまり深く考えずに\n行動に移る性格")
        questionArray.append("ストレスや不安を感じるより\n落ち着いていることが多い")
        
        choiceQuestion()
    }
   
   
//    //画面遷移時に、ResultViewConにスコア情報を渡す
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toResultView"{
//                let nextVC = segue.destination as! ResultViewController
//
//            nextVC.con = con.self
//            nextVC.men = men.self
//            nextVC.total = total.self
//        }
//    }
    
    @IBAction func nextButton(){

        print("Q4_\(scoreQ4)")
        print("Q5_\(scoreQ5)")
        print("Q9_\(scoreQ9)")
        print("Q10_\(scoreQ10)")
        print("otherScore\(otherScore)")
        
        if otherScore == 0{
            showAlert()
        }else{
            nowNumber += 1
            nowNumberLabel.text = String(nowNumber)+"/10"
            
            if nowNumber == 11{
                nowNumberLabel.text = "10/10"

                //スコアを計算
                calculateConscience()
                calculateMental()
                calculateTotal()
                
                //realmにuserのスコアを登録
                let user = Score()
                try! realm.write {
                    realm.add(user)
                          
                user.createdAt = Date()
                user.totalScore = total
                user.finalCon = con
                user.finalMen = men
            }
                
            }else{
                choiceQuestion()
                otherScore = 0
                print("otherScore\(otherScore)")
            }
        }
    }
    
    func calculateConscience(){
        con = Double((scoreQ4 + scoreQ9) / 8 * 100)
    }

    func calculateMental(){
        men = Double((scoreQ5 + scoreQ10) / 8 * 100)
    }

    func calculateTotal(){
        total = (con + men) / 2
        print("誠実性\(con)")
        print("メンタル\(men)")
        print("適性\(total)")
        
        //次の画面に遷移
        let nextView = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        nextView.modalTransitionStyle = .crossDissolve
        nextView.modalPresentationStyle = .fullScreen
        
        //遷移先のViewControllerに値を渡す
        nextView.con = Double(con)
        nextView.men = Double(men)
        nextView.total = Double(total)
        
        self.present(nextView, animated: true, completion: nil)
    }
    
    @IBAction func backButton(){

        nowNumber -= 1
        nowNumberLabel.text = String(nowNumber)+"/10"
        choiceQuestion()
    }

    //セルが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        //tableViewのハイライト状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        otherScore = 1
        print("otherScore\(otherScore)")
        
        //4,5,9,10問目のスコア計算
        switch nowNumber {
        case 4:
           otherScore = 1
            if answers[indexPath.row] == "全く当てはまらない"{
                scoreQ4 = 0
           }else if answers[indexPath.row] == "ほとんど当てはまらない"{
                scoreQ4 = 1
           }else if answers[indexPath.row] == "どちらとも言えない"{
                scoreQ4 = 2
           }else if answers[indexPath.row] == "やや当てはまる"{
                scoreQ4 = 3
           }else if answers[indexPath.row] == "完全に当てはまる"{
                scoreQ4 = 4
           }
            
        case 5:
            otherScore = 1
            if answers[indexPath.row] == "全く当てはまらない"{
                scoreQ5 = 0
           }else if answers[indexPath.row] == "ほとんど当てはまらない"{
                scoreQ5 = 1
           }else if answers[indexPath.row] == "どちらとも言えない"{
                scoreQ5 = 2
           }else if answers[indexPath.row] == "やや当てはまる"{
                scoreQ5 = 3
           }else if answers[indexPath.row] == "完全に当てはまる"{
                scoreQ5 = 4
           }
            

        case 9:
            otherScore = 1
            if answers[indexPath.row] == "全く当てはまらない"{
                scoreQ9 = 4
           }else if answers[indexPath.row] == "ほとんど当てはまらない"{
                scoreQ9 = 3
           }else if answers[indexPath.row] == "どちらとも言えない"{
                scoreQ9 = 2
           }else if answers[indexPath.row] == "やや当てはまる"{
                scoreQ9 = 1
           }else if answers[indexPath.row] == "完全に当てはまる"{
                scoreQ9 = 0
           }
            
        case 10:
            otherScore = 1
            if answers[indexPath.row] == "全く当てはまらない"{
                scoreQ10 = 4
           }else if answers[indexPath.row] == "ほとんど当てはまらない"{
                scoreQ10 = 3
           }else if answers[indexPath.row] == "どちらとも言えない"{
                scoreQ10 = 2
           }else if answers[indexPath.row] == "やや当てはまる"{
                scoreQ10 = 1
           }else if answers[indexPath.row] == "完全に当てはまる"{
                scoreQ10 = 0
           }
        default:
            otherScore = 1
        }
    }
    
    //次の問題を表示
    func choiceQuestion(){
        question.text = questionArray[nowNumber]
    }
    
    //アラート表示
    func showAlert(){
        let alert = UIAlertController(
                title: "解答を選択してください",
                message: "",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            present(alert, animated: true, completion: nil)
    }
    
    //tableViewのセルの数を指定（この場合はanswersの中の文字列の数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    //tableViewに表示する内容を指定（この場合はanswersの中身）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = answerTableView.dequeueReusableCell(withIdentifier: "answerTableViewCell", for: indexPath)
        
        cell.textLabel?.text = answers[indexPath.row]
        
        return cell
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
