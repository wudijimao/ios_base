//
//  UNBaseGameCell.swift
//  uneed
//
//  Created by wudijimao on 2016/11/30.
//  Copyright © 2016年 wudijimao. All rights reserved.
//

import Foundation


public class UNBaseGameCell : UNBaseTableViewCell {
    var iconView: UIImageView!
    var btn1: UIButton!
    var btn2: UIButton!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        self.iconView = UIImageView(frame: CGRect(x: CGFloat(10), y: CGFloat(10), width: CGFloat(130), height: CGFloat(130)))
        self.btn1 = UIButton(frame: CGRect(x: CGFloat(150), y: CGFloat(30), width: CGFloat(120), height: CGFloat(90)))
        btn1.setTitleColor(UIColor.darkGray, for: .normal)
        self.btn2 = UIButton(frame: CGRect(x: CGFloat(270), y: CGFloat(30), width: CGFloat(120), height: CGFloat(90)))
        btn2.setTitleColor(UIColor.darkGray, for: .normal)
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(btn1)
        self.contentView.addSubview(btn2)
        btn1.addTarget(self, action: #selector(self.click), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(self.click), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var info : UNDataGameCellInfo?;
    
    override public class func preferedHeightFor(data: UNDataBaseObject?,cellInfo: UNTableViewCellExtraInfo?,width: CGFloat) -> CGFloat {
        return 200;
    }
    
    func click() {
        _ = self.delegate?.tableViewCell?(self, action: UNTableViewCellActionType.openH5Game, userInfo: info?.gameInfo.url)
    }
    
    override public func update(_ data: UNDataBaseObject?, cellInfo info: UNTableViewCellExtraInfo?) {
        if (data != nil) && (data! is UNDataGameCellInfo) {
            self.info = (data as! UNDataGameCellInfo)
            iconView.sd_setImage(with: URL(string: (self.info?.gameInfo?.icon)!));
            btn1.setTitle(self.info?.gameInfo.name, for: .normal)
            btn2.setTitle(self.info?.gameInfo.online_mode_name, for: .normal)
        }
    }
    
}
