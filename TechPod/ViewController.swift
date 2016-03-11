//
//  ViewController.swift
//  TechPod
//
//  Created by ShinokiRyosei on 2016/03/06.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import AVFoundation //フレームワークをインポートする
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //TableViewをIBOutletで関連付け
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //mp3ファイルの名前の配列を作成
    var musicArray: [String] = ["One_way_or_another", "shut_up_and_dance", "something_new"]//"sun"は入ってない,one→One,shat→shut
    
    //アルバムの写真のUIImageの配列を作成
    var iconArray: [UIImage] = [UIImage(named: "one_way_or_another.jpeg")!, UIImage(named: "shut_up_and_dance.jpg")!, UIImage(named: "something_new.jpg")!]   //曲名打ち間違い(_を挿入)
    

    
    //AVAudioPlayerのインスタンスを作成
    var audioPlayer: AVAudioPlayer! = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TableViewのcellの高さを動的に変更
        tableView.estimatedRowHeight = 64.0 //TableViewのRowHeightに値入力
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //xibファイルをTableViewに登録
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "ListCell")  //xibでセルのidentifier変更
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSourceメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListCell", forIndexPath: indexPath) as! ListTableViewCell
        cell.iconImageView.image = iconArray[indexPath.row]
        cell.titleLabel.text = String(musicArray[indexPath.row] )as String
        return cell
    }
    
    //UITableViewDelegateメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(musicArray[indexPath.row], ofType: "mp3")!)
////ERROR:unexpectedly found nil while unwrapping an Optional value
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: audioPath)
//ERROR:Cannot convert value of type 'String?' to expected argument type 'NSURL'
        }catch {
            print("ファイルが読み込めませんでした")
        }
        
        
        audioPlayer.play()
        
        
    }
    
    //UITableViewメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    

}

