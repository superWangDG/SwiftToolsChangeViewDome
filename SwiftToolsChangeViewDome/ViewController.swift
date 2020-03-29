//
//  ViewController.swift
//  SwiftToolsChangeViewDome
//
//  Created by 98data on 2020/2/25.
//  Copyright © 2020 98data. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vo = WGToolsChangeView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 60))
        vo.backgroundColor = UIColor.lightGray
        vo.noramlColor = UIColor.green
        vo.itemValues = ["测试1","测试2","测试3","测试4","测试5","测试6","测试7","测试8","测试9","测试10","测试11","测试12","测试13","测试14"]
        self.view.addSubview(vo)
        
    }


}

