//
//  LGpattern.swift
//  LifeGame
//
//  Created by 山口将槻 on 2015/12/04.
//  Copyright © 2015年 山口将槻. All rights reserved.
//

import Foundation

class pattern {
    var size_x:Int = 0
    var size_y:Int = 0
    var shape:Array<[LGcell]> = []
    
    func search(map:Array<[LGcell]>){
    }
}

class block: pattern {
    
    override init() {
        super.init()
        self.size_x = 2
        self.size_y = 2
        self.shape = [[LGcell(s: true), LGcell(s: true)],[LGcell(s: true), LGcell(s: true)]]
    }
}

class beehive: pattern {
    
    override init() {
        super.init()
        self.size_x = 4
        self.size_y = 3
        self.shape = [[LGcell(s: false), LGcell(s: true), LGcell(s: true), LGcell(s: false)],
                      [LGcell(s: true), LGcell(s: false), LGcell(s: false), LGcell(s: true)],
                      [LGcell(s: false), LGcell(s: true), LGcell(s: true), LGcell(s: false)]]
    }
}

class boat: pattern {
    
    override init() {
        super.init()
        self.size_x = 3
        self.size_y = 3
        self.shape = [[LGcell(s: true), LGcell(s: true), LGcell(s: false)],
                      [LGcell(s: true), LGcell(s: false), LGcell(s: true)],
                      [LGcell(s: false), LGcell(s: true), LGcell(s: false)]]
    }
}