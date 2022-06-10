//
//  RecordViewController.swift
//  love competence
//
//  Created by saki shishikura on 2022/06/10.
//

    import UIKit
    import RealmSwift

    class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
        @IBOutlet weak var recordTableView: UITableView!
        
        let realm = try! Realm()
        var conToSend: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.

            recordTableView.rowHeight = 70
            
            //userScoreという箱を作り、その中にrealm内のオブジェクトを入れる（確認用）
            let userScore = realm.objects(Score.self).sorted(byKeyPath: "createdAt", ascending: false)
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
            
            //セル内の情報を指定
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
        
    //    //resultViewに値渡す
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    //
    //        let sendingVC = segue.destination as! ResultViewController
    //
    //        sendingVC.con = Double(conToSend.self)
    //        print(conToSend)
    //    }
        
        //セルが選択された時の処理
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

             //選択したセルの情報を取得
            let userScore = realm.objects(Score.self)

            //取得したセル内の情報を、ResultViewControllerに送るものの箱に入れる
            let choosedCon = userScore[indexPath.row].finalCon
            conToSend = Int(choosedCon)
            print(conToSend)

            //resultViewに遷移
            performSegue(withIdentifier: "toResultView", sender: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
