//
//  CollectionViewController.swift
//  Mine
//
//  Created by 赵安 on 2017/9/23.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var data = Mine()
    var mineData = [[Int]]()
    var sz : CGFloat = 0.0
    var correctNum : Int = 0
    var wrongNum : Int = 0
    var dismissNum : Int = 0
    var gameNum : Int = 5
    var gameTime = 3200
    var timeRecord : Int = 0
    var timer : Timer!
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var correctNumField : UITextField!
    @IBOutlet weak var wrongNumField : UITextField!
    @IBOutlet weak var dismissNumField: UITextField!
    @IBOutlet weak var timeShow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //get mine data
        data.newdata()
        mineData = data.mineData
        correctNum = 0
        wrongNum = 0
        timeRecord = 0
        textShow()
        
        self.view.backgroundColor = UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        //size of item
        sz = (self.collectionView.bounds.width) / CGFloat(mineData[0].count)
        layout.itemSize = CGSize(width: sz, height: sz)
        //dis of line and row
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0;
        
        collectionView.collectionViewLayout = layout
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView!.register(MineCollectionViewCell.self, forCellWithReuseIdentifier: "celll")
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return mineData.count * mineData[0].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celll", for: indexPath) as! MineCollectionViewCell
        
        cell.sizeThatFits(CGSize(width: sz, height: sz));
        // Configure the cell
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.1
        
        cell.label.text = String(mineData[indexPath.item / mineData.count][indexPath.item % mineData[0].count])
        
        cell.loadPic(cellNum: Int(mineData[indexPath.item / mineData.count][indexPath.item % mineData[0].count]))
        
        
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        
        
        return cell
    }

    //unused
    @IBAction func click() {
        correctNum = 0
        wrongNum = 0
        dismissNum = 0
        data.newdata()
        mineData = data.mineData
        collectionView.reloadData()
        textShow()
    }
    
    @IBAction func correctClick() {
        if data.rightPosition == 0 {
            wrongNum = wrongNum + 1
        } else {
            correctNum = correctNum + 1
        }
        textShow()
        newScene()
    }
    
    @IBAction func wrongClick() {
        if data.rightPosition == 1 {
            wrongNum = wrongNum + 1
        } else {
            correctNum = correctNum + 1
        }
        textShow()
        newScene()
    }
    
    func dismissClick() {
        dismissNum = dismissNum + 1
        textShow()
        newScene()
    }
    
    @objc func timeUpdate() {
        timeRecord = timeRecord + 1
        timeShow.text = String(timeRecord)
        if timeRecord > gameTime {
            dismissClick()
        }
    }
    
    func textShow() {
        correctNumField.text = String(correctNum)
        wrongNumField.text = String(wrongNum)
        dismissNumField.text = String(dismissNum)
        
    }
    
    
    func newScene() {
        //end game
        timer.invalidate()
        timeRecord = 0
        if wrongNum + correctNum + dismissNum >= gameNum {
            let correctRating = (Double)(correctNum) / (Double)(gameNum) * 100
            let alertController = UIAlertController(title:"游戏结束", message:"答对：\(correctNum)\n答错：\(wrongNum)\n错过：\(dismissNum) 正确率：\(correctRating)%", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "确认", style: .default, handler: {
                action in
                self.presentingViewController!.dismiss(animated: true, completion: nil)
            })
            let againAction = UIAlertAction(title: "重玩", style: .default, handler: {
                action in
                self.correctNum = 0
                self.wrongNum = 0
                self.dismissNum = 0
                self.textShow()
                self.data.newdata()
                self.mineData = self.data.mineData
                self.collectionView.reloadData()
                self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timeUpdate), userInfo: nil, repeats: true)
            })
            alertController.addAction(okAction)
            alertController.addAction(againAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //new mine data
            data.newdata()
            mineData = data.mineData
            collectionView.reloadData()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func backClk(_ sender: Any) {
        timer.invalidate()
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
