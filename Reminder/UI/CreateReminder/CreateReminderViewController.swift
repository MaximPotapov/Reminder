//
//  CreateReminderViewController.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import Foundation
import UIKit

class CreateReminderViewController: UIViewController {
    // MARK: - Properties -
    private var reminderType: ReminderType = .other
    private let viewModel: MyRemindersViewModel
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(dismissTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "save"), for: .normal)
        button.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.tekoRegular14
        label.text = "Type"
        
        return label
    }()
    
    private let repetYearlyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.tekoRegular14
        label.text = "Repeat Yearly"
        
        return label
    }()
    
    private let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.thumbTintColor = .gray
        
        return repeatSwitch
    }()
    
    private let birthdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Birthday", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(typeButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.tag = 0
        
        return button
    }()
    
    private let holidayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Holiday", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(typeButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.tag = 1
        
        return button
    }()
    
    private let otherButton: UIButton = {
        let button = UIButton()
        button.setTitle("Other", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(typeButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.tag = 2
        
        return button
    }()
    
    private let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Add an Event", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.tekoRegular24!
        ])
        textfield.textColor = .black
        textfield.font = UIFont.tekoRegular24
        
        return textfield
    }()
    
    private let dateTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Month / Day", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.tekoLight18!
        ])
        textfield.textColor = .black
        textfield.font = UIFont.tekoLight18
        
        return textfield
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        return toolbar
    }()
    
    // MARK: - Services -
    init(viewModel: MyRemindersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Life Cicle -
    override func viewDidLoad() {
        super.viewDidLoad()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.setDateTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
        setupLayout()
    }
    
    // MARK: - Private Methods -
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(dismissButton)
        view.addSubview(saveButton)
        view.addSubview(typeLabel)
        view.addSubview(birthdayButton)
        view.addSubview(holidayButton)
        view.addSubview(otherButton)
        view.addSubview(nameTextField)
        view.addSubview(dateTextField)
        view.addSubview(repetYearlyLabel)
        view.addSubview(repeatSwitch)
        
        dismissButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalToSuperview().offset(9)
            make.top.equalToSuperview().offset(36)
        }
        
        saveButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(36)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(dismissButton.snp.bottom).offset(20)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(32)
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(typeLabel.snp.bottom).offset(14)
        }
        
        holidayButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(32)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(20)
            make.top.equalTo(typeLabel.snp.bottom).offset(14)
        }
        
        otherButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(32)
            make.leading.equalTo(holidayButton.snp.trailing).offset(20)
            make.top.equalTo(typeLabel.snp.bottom).offset(14)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().inset(17)
            make.height.equalTo(28)
            make.top.equalTo(otherButton.snp.bottom).offset(56)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(31)
            make.top.equalTo(nameTextField.snp.bottom).offset(32)
        }
        
        repetYearlyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(31)
            make.top.equalTo(dateTextField.snp.bottom).offset(58)
        }
        
        repeatSwitch.snp.makeConstraints { make in
            make.leading.equalTo(repetYearlyLabel.snp.trailing).offset(30)
            make.centerY.equalTo(repetYearlyLabel)
            make.height.equalTo(24)
            make.width.equalTo(36)
        }
    }
    
    private func setSelect(button: UIButton) {
        button.backgroundColor = UIColor.clickablesColor
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setDefault(button: UIButton) {
        button.backgroundColor = UIColor.white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Objc Methods -
    @objc func typeButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.setSelect(button: birthdayButton)
            self.setDefault(button: holidayButton)
            self.setDefault(button: otherButton)
            self.reminderType = .birthday
            self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Add an Birthday", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.tekoRegular24!
            ])
            print("BR")
        case 1:
            self.setSelect(button: holidayButton)
            self.setDefault(button: birthdayButton)
            self.setDefault(button: otherButton)
            self.reminderType = .holiday
            self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Add an Holiday", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.tekoRegular24!
            ])
            print("HL")
        case 2:
            self.setSelect(button: otherButton)
            self.setDefault(button: holidayButton)
            self.setDefault(button: birthdayButton)
            self.reminderType = .other
            self.nameTextField.attributedPlaceholder = NSAttributedString(string: "Add an Event", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.tekoRegular24!
            ])
            print("OT")
        default:
            print("none")
        }
    }
    
    @objc func dismissTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let date = dateTextField.text else { return }
        
        if viewModel.reminderType == .noType || name.isEmpty || date.isEmpty {
            print("empty")
        } else {
            DispatchQueue.main.async { [weak self] in
                
                self?.viewModel.addReminder(name: name,
                                            date: date,
                                            emoji: "🥶",
                                            repeatYearly: false,
                                            type: self?.reminderType ?? .other) {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: nil)
                    
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func setDateTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}

