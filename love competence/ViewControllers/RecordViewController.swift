//
//  ViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/05/22.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var recordTableView: UITableView!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        recordTableView.rowHeight = 70
        
        //userScoreという箱を作り、その中にrealm内のオブジェクトを入れる（確認用）
        let userScore = realm.objects(Score.self)
//            .sorted(byKeyPath: "id", ascending: false)
        //userScoreに入ったデータをコンソールに表示
        print("データ\(userScore)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        recordTableView.reloadData()
    }
   
    //セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userScore = realm.objects(Score.self)
        return userScore.count
    }
    
    //セル内の情報の処理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セルを生成
        let cell: UITableViewCell = recordTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //セル内の情報が入った箱を指定、この場合はuserScoreを指定
        let userScore = realm.objects(Score.self)
        
        //セル内の情報を指定、この場合はuserDataの中のcreatedAtとtotalScoreをそれぞれ指定
//        cell.textLabel!.text = "\(userScore[indexPath.row].createdAt)"
//
        

        let dt = userScore[indexPath.row].createdAt
        let now = DateFormatter()

        now.dateFormat = "yyyy/MM/dd HH:mm"
        
        cell.textLabel!.text = now.string(from: dt)
        cell.detailTextLabel!.text = String("\(userScore[indexPath.row].totalScore)%")
        
        //セル内のフォントサイズを指定
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return cell
    }
    
    //TableViewを左スワイプした時の処理
    func tableView(_ tableView: UITableView, trailingSwipeActionConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in

            self.DeleteRecordRealm(indexPath: indexPath.row)

            completionHandler(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //cellとrealmの削除
    func DeleteRecordRealm(indexPath: Int){
        let realm = try! Realm()
        let targetScore = realm.objects(Score.self)
        
        try! realm.write{
            realm.delete(targetScore)
        }
        
        self.recordTableView.reloadData()
    }
    
}

