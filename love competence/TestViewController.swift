//
//  TestViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/05/22.
//

import UIKit

class TestViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var answerTableView: UITableView!
    
    var questionArray = [String]()
    var nowNumber: Int = 0
    
    let answers = ["完全に当てはまる","やや当てはまる","どちらとも言えない","ほとんど当てはまらない","全く当てはまらない"]
    
    @IBOutlet var question: UILabel!
    @IBOutlet var nowNumberLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
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
    
    @IBAction func nextButton(){
        //現在の問題をquestionArayから取り除く
        questionArray.remove(at: 0)
        
        //tableViewのハイライト状態を解除
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
            {
                tableView.deselectRow(at: indexPath, animated: true)

            }
        
        if questionArray.count == 0 {
            performSegueToResult()
        } else{
            
        choiceQuestion()
            
    }
    }
    
    @IBAction func backButton(){
        
    }
    
    //次の問題を表示
    func choiceQuestion(){
        question.text = questionArray[0]
        nowNumber += 1
        nowNumberLabel.text = String(nowNumber)+"/10"
    }
    
    //結果画面への遷移
    func performSegueToResult(){
        performSegue(withIdentifier: "toResultView", sender: nil)
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
