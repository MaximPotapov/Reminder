//
//  TestCellHeader.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import Foundation
import UIKit

class ReminderCellHeader: UITableViewHeaderFooterView {
    // MARK: - Properties -
    static let identifier = "ReminderCellHeader"
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.font = UIFont.tekoBold28
        
        return label
    }()
    
    // MARK: - Service -
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleText)
        titleText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public Methods -
    func setTitle(month: String) {
        titleText.text = month
    }
}
