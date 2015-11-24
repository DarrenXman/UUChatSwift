//
//  LeftMessageCell.swift
//  UUChatTableViewSwift
//
//  Created by XcodeYang on 8/13/15.
//  Copyright © 2015 XcodeYang. All rights reserved.
//

import UIKit

@objc(UUChatLeftMessageCell)



class UUChatLeftMessageCell: UITableViewCell {

    internal var dateLabel: UILabel!
    internal var headImageView: UIButton!
    internal var nameLabel: UILabel!
    internal var contentButton: UIButton!
    
    internal var contentLabel: UILabel!
    
    var imageHeightConstraint: NSLayoutConstraint!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None

        // 日期
        dateLabel = UILabel()
        contentView.addSubview(dateLabel)
        dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(4)
            make.centerX.equalTo(contentView)
        }
        
        // 头像
        headImageView = UIButton()
        contentView.addSubview(headImageView)
        headImageView.layer.borderWidth = 4
        headImageView.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5).CGColor
        headImageView.layer.cornerRadius = 25
        headImageView.clipsToBounds = true
        headImageView.setImage(UIImage(named: "headImage"), forState: UIControlState.Normal)
        headImageView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.leading.equalTo(10)
            make.top.equalTo(dateLabel).offset(20)
        }
        
        // 内容frame辅助
        contentLabel = UILabel()
        contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.grayColor()
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(90)
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.6)
            make.top.equalTo(headImageView).offset(10)
            make.bottom.equalTo(-20).priorityLow()
        }
        
        // 内容视图
        contentButton = UIButton()
        contentView.insertSubview(contentButton, belowSubview: contentLabel)
        contentButton.clipsToBounds = true
        contentButton.setBackgroundImage(UIImage(named: "left_message_back"), forState: UIControlState.Normal)
        contentButton.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView).offset(70)
            make.trailing.equalTo(contentLabel.snp_trailing).offset(10)
            make.top.equalTo(headImageView)
            make.bottom.equalTo(contentLabel.snp_bottom).offset(10)
        }
        
        // temporary method
        imageHeightConstraint = NSLayoutConstraint(
            item: contentButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.LessThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: 1000
        )
        imageHeightConstraint.priority = UILayoutPriorityRequired
        contentButton.addConstraint(imageHeightConstraint)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configUIWithModel(model: UUChatModel){
        dateLabel.text = model.time
        switch model.messageType {
        case UUChatMessageType.Text:
            self.contentLabel.text = model.text
            break
        case .Image:
            self.contentLabel.text = ""
            self.contentButton.setBackgroundImage(model.image, forState: .Normal)
            self.imageHeightConstraint.constant = UIScreen.mainScreen().bounds.size.width*0.6
            break
        case .Voice:
            break
        default:
            break
        }
    }
}
