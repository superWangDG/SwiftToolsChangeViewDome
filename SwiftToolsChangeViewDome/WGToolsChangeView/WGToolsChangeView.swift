//
//  WGToolsChangeView.swift
//  SwiftToolsChangeViewDome
//
//  Created by 98data on 2020/2/25.
//  Copyright © 2020 98data. All rights reserved.
//

import Foundation
import UIKit

class WGToolsChangeView:UIView {
    
    var itemValues = [String]() {
        didSet {
            var left:CGFloat = 0
            self.fontSumWidth = 0
            for index in 0 ..< self.itemValues.count {
                let rootView = UIButton(type: .custom)
                rootView.setTitle(self.itemValues[index], for: .normal)
                rootView.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                let sizeWidth = self.sizeWithText(text: NSString(string: self.itemValues[index]), font: UIFont.systemFont(ofSize: 15), size: CGSize(width: 100, height: self.mFrame.height))
                rootView.frame = CGRect(x: left, y: 0, width: sizeWidth.width * 2, height: self.mFrame.size.height)
                rootView.tag = self.mTag + index
                rootView.setTitleColor(UIColor.black, for: .normal)
                rootView.addTarget(self, action: #selector(changeAction), for: .touchUpInside)
                if index == 0 {
                    rootView.isSelected = true
                }
                self.mScrollView.addSubview(rootView)
                
                left += rootView.frame.size.width
            }
            self.fontSumWidth = left
            
            self.changeItemUISize()
            
            self.changeLineSize(index: 0)
        }
    }
    
    var currentIndex = 0
    
    /// 默认的字体颜色
    var noramlColor = UIColor() {
        didSet {
            self.setButtonColor(color: self.noramlColor, isSelect: false)
        }
    }
    
    /// 选中的字体颜色
    var selectedColor = UIColor() {
        didSet {
            self.setButtonColor(color: self.selectedColor, isSelect: true)
        }
    }
    
    
    /// 点击后的回调
    var itemBlock:((_ index:Int)->Void)?
    
    // 标志线
    fileprivate var lineView = UIView()
    
    fileprivate var mScrollView = UIScrollView()
    fileprivate var mFrame = CGRect()
    fileprivate let mTag = 99
    fileprivate var fontSumWidth:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mFrame = frame
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.mScrollView.frame = CGRect(x: 0, y: 0, width: self.mFrame.size.width, height: self.mFrame.size.height)
        self.mScrollView.showsHorizontalScrollIndicator = false
        self.mScrollView.showsVerticalScrollIndicator = false
        self.addSubview(self.mScrollView)
        
        // 初始化标志线的位置
        self.lineView.frame = CGRect(x: 0, y: self.mScrollView.frame.size.height - 3, width: 0, height: 3)
        self.lineView.backgroundColor = UIColor.black
        self.mScrollView.addSubview(self.lineView)
    }
    
    @objc func changeAction(button:UIButton) {
        self.changeLineSize(index: button.tag - self.mTag)
        
        self.currentIndex = button.tag - self.mTag
       // 改变选中的状态
        for i in 0 ..< self.itemValues.count {
             let buttonOld = self.mScrollView.viewWithTag(i + self.mTag) as! UIButton
            buttonOld.isSelected = false
        }
        
        button.isSelected = true
        
        if self.itemBlock != nil {
            self.itemBlock!(button.tag - self.mTag)
        }
    }
    
    func changeLineSize(index:Int) {
        let btnRoot = self.mScrollView.viewWithTag(index + self.mTag) as! UIButton
        let left = btnRoot.frame.origin.x + (btnRoot.frame.size.width / 2.0 -  btnRoot.frame.size.width / 4.0 )
        let lineRect = CGRect(x: left, y: self.lineView.frame.origin.y, width: btnRoot.frame.size.width / 2.0, height: self.lineView.frame.size.height)
        UIView.animate(withDuration: 0.25) {
            self.lineView.frame = lineRect
        }
    }
    
    // 判断容器 是否填满  如果没有填满的情况 等比例 填满容器
    func changeItemUISize() {
        let btnRoot = self.mScrollView.viewWithTag((self.itemValues.count - 1) + self.mTag) as! UIButton
        let right = (btnRoot.frame.origin.x + btnRoot.frame.size.width)
        self.mScrollView.contentSize = CGSize(width: right, height: self.mScrollView.frame.size.height)
        // 如果小于总容器 的宽度的时候 所有的 item 宽度 均等
        if right < self.mFrame.width {
            if self.mScrollView.frame.width <= self.fontSumWidth {
                for index in 0 ..< self.itemValues.count {
                    let button = self.mScrollView.viewWithTag(index + self.mTag) as! UIButton
                    let count = self.itemValues.count
                    let width = self.mScrollView.frame.size.width / CGFloat(count)
    //                button.frame.size.width = width
                    button.frame = CGRect(x: CGFloat(index) * width, y: button.frame.origin.y, width: width, height: button.frame.size.height)
                }
                
                self.mScrollView.contentSize = CGSize(width: self.mScrollView.frame.size.width, height: self.mScrollView.frame.size.height)
            } else {
                self.mScrollView.contentSize = CGSize(width: self.fontSumWidth, height: self.mScrollView.frame.size.height)
            }
        }
    }
    
    
    func setButtonColor(color:UIColor,isSelect:Bool) {
        for index in 0 ..< self.itemValues.count {
            let button = self.mScrollView.viewWithTag(index + self.mTag) as! UIButton
            button.setTitleColor(color, for: isSelect ? .selected : .normal)
        }
    }
    
    /**
    * 计算字符串长度
    */
    func sizeWithText(text: NSString, font: UIFont, size: CGSize) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
}


