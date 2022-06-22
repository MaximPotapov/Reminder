//
//  TestCell.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import Foundation
import UIKit

class ReminderCell: UITableViewCell {
    // MARK: - Properties -
    static let identifier = "ReminderCell"
    
    private let cellContentView: UIView = UIView()
    
    private let iconLabel: UILabel = {
        let label = UILabel()
        label.text = "😵‍💫"
        
        return label
    }()
    
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 25

        return view
    }()
    
    private let reminderName: UILabel = {
        let label = UILabel()
        label.font = UIFont.tekoSemiBold14
        label.textColor = UIColor.black
        label.text = "Dog show"
        
        return label
    }()
    
    private let reminderDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.tekoRegular12
        label.textColor = UIColor.black
        label.text = "January 05"
        
        return label
    }()
    
    // MARK: - Service -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Private Methods -
    private func setupLayout() {
        contentView.addSubview(cellContentView)
        cellContentView.addSubview(iconBackgroundView)
        cellContentView.addSubview(iconLabel)
        cellContentView.addSubview(reminderDate)
        cellContentView.addSubview(reminderName)
    
        cellContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(73)
            make.bottom.equalToSuperview().inset(11)
        }
        
        iconBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(49)
            make.centerY.equalTo(cellContentView)
            make.leading.equalTo(cellContentView).offset(12)
        }
        
        iconLabel.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.center.equalTo(iconBackgroundView)
        }
        
        reminderName.snp.makeConstraints { make in
            make.top.equalTo(cellContentView).inset(19)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(12)
        }
        
        reminderDate.snp.makeConstraints { make in
            make.bottom.equalTo(cellContentView).inset(19)
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(12)
        }
    }
    
    // MARK: - Public Methods -
    func getReminderData(emoji: String, name: String, date: Int) {
        self.iconLabel.text = emoji
        self.reminderName.text = name
        self.reminderDate.text = "\(date)"
    }
    
    func updateCellColor() {
        self.cellContentView.backgroundColor = .clickablesColor
    }
}
