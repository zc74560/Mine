//
//  mine.swift
//  Mine
//
//  Created by 赵安 on 2017/9/23.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

let rowNum = 7;
let columnNum = 7;
let dx = [-1, -1, -1, 0, 1, 1, 1, 0]
let dy = [-1, 0, 1, 1, 1, 0, -1, -1]

class Mine: NSObject {
    var mineData = [[Int]]()
    var randomRowNum : Int = 0
    var randomColumnNum : Int = 0
    var rightPosition : Int?
    
    override init() {
        super.init();
        
        for i in 0 ..< rowNum {
            mineData.append([])
            for _ in 0 ..< columnNum {
                mineData[i].append(0)
            }
        }
    }
    
    func numsOfMineAround (rowIndex : Int, columnIndex : Int) -> Int {
        var mineNum = 0
        
        for i in 0..<8 {
            if rowIndex + dx[i] >= 0 && rowIndex + dx[i] < rowNum && columnIndex + dy[i] >= 0 && columnIndex + dy[i] < columnNum {
                if mineData[rowIndex + dx[i]][columnIndex + dy[i]] == -1 {
                    mineNum = mineNum + 1
                }
            }
        }
        
        return mineNum
    }
    
    func checkFitCell(rowIndex : Int, columnIndex : Int) -> Bool {
        if mineData[randomRowNum][randomColumnNum] == -1 {
            return true
        }
        if mineData[randomRowNum][randomColumnNum] == 0 {
            return true
        }
        
        for i in 0..<8 {
            if rowIndex + dx[i] >= 0 && rowIndex + dx[i] < rowNum && columnIndex + dy[i] >= 0 && columnIndex + dy[i] < columnNum {
                if mineData[rowIndex + dx[i]][columnIndex + dy[i]] == 0 {
                    return true
                }
            }
        }
     
        return false
    }
    
    func newdata() {
        let mineNum = rowNum * columnNum / 3
        
        //initial data
        for i in 0 ..< rowNum {
            for j in 0 ..< columnNum {
                mineData[i][j] = 0
            }
        }
        
        //random get mines
        for _ in 0 ..< mineNum {
            randomRowNum = Int(arc4random()) % rowNum
            randomColumnNum = Int(arc4random()) % columnNum
            mineData[randomRowNum][randomColumnNum] = -1
        }
        
        for i in 0 ..< rowNum {
            for j in 0 ..< columnNum {
                if mineData[i][j] != -1 {
                    mineData[i][j] = numsOfMineAround(rowIndex: i, columnIndex: j)
                }
            }
        }
        
        rightPosition = Int(arc4random()) % 2
        
        //get a wrong cell
        if rightPosition == 0 {
            repeat {
                randomRowNum = Int(arc4random()) % rowNum
                randomColumnNum = Int(arc4random()) % columnNum
            } while (checkFitCell(rowIndex : randomRowNum, columnIndex : randomColumnNum))
            
            mineData[randomRowNum][randomColumnNum] = -1
            
            print("row: \(String(describing: randomRowNum)) column: \(String(describing: randomColumnNum))")
        } else {
            print("right position");
        }
        
    }
    
    
}



