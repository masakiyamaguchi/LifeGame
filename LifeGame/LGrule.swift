//
//  LGrule.swift
//  LifeGame
//
//  Created by 山口将槻 on 2015/12/04.
//  Copyright © 2015年 山口将槻. All rights reserved.
//

import Foundation

class LGstage {
    
    private var stage:Array<[LGcell]> = []
    let size:Int
    var life = 0
    
    init (stageSize:Int, pos:Float) {
        self.size = stageSize
        for var i in 0...stageSize+1 {
            var arr:Array<LGcell> = []
            for var j in 0...stageSize+1 {
                arr.append(LGcell(s: false))
            }
            self.stage.append(arr)
        }
    }
    
    func clearAll(){
        var map = Array<[LGcell]>()
        for var i in 0...self.size+1 {
            var arr:Array<LGcell> = []
            for var j in 0...self.size+1 {
                arr.append(LGcell(s: false))
            }
            map.append(arr)
        }
        self.stage = map
    }
    
    func changeStep(map:Array<[LGcell]>){
        self.stage = map
    }
    
    func setNextStep(){
        var map = Array<[LGcell]>()
        for var i in 0...self.size+1 {
            var y = Array<LGcell>()
            for var j in 0...self.size+1 {
                var x = LGcell(s: false)
                var arr = [LGcell]()
                if i > 0 {
                    if j > 0 { arr.append(self.stage[i-1][j-1]) }
                        arr.append(self.stage[i-1][j])
                    if j < self.size-1{ arr.append(self.stage[i-1][j+1]) }
                }
                if j > 0 { arr.append(self.stage[i][j-1]) }
                if j < self.size-1{ arr.append(self.stage[i][j+1]) }
                if i < self.size-1 {
                    if j > 0 { arr.append(self.stage[i+1][j-1]) }
                    arr.append(self.stage[i+1][j])
                    if j < self.size-1{ arr.append(self.stage[i+1][j+1]) }
                }
                x.check(arr, s: self.stage[i][j].status)
                y.append(x)
            }
            map.append(y)
        }
        changeStep(map)
    }
    
    func setCell(x:Int, y:Int){
        if x < self.size && y < self.size{
            self.stage[y][x].inverseStatus()
        }
    }
    
    func getStatus(x:Int, y:Int) -> Bool{
        if x < self.size && y < self.size {
            return self.stage[y][x].status
        }else{
            return false
        }
    }
}

class LGcell {
    private var status:Bool
    
    init(s:Bool){
        self.status = s
    }
    
    func inverseStatus(){
        self.status = !self.status
    }
    
    func changeStatus(count:Int, s:Bool){
        if !s && count == 3 {
            self.status = true
        }else if s && (count >= 4 || count <= 1) {
            self.status = false
        }else if s && (count <= 2 || count >= 3) {
            self.status = true
        }
    }
    
    func check(arr:Array<LGcell>, s:Bool){
        var environment:Int = 0
        for var e in arr {
            if e.status {
                environment++
            }
        }
        changeStatus(environment, s: s)
    }
}