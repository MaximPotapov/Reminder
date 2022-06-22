//
//  MyRemindersViewController.swift
//  Reminder
//
//  Created by Maksym Potapov on 19.06.2022.
//

import Foundation
import UIKit

class MyRemindersViewController: UIViewController {
    // MARK: - Properties -
    private let viewModel = MyRemindersViewModel()
    
    private lazy var remindersTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(ReminderCell.self, forCellReuseIdentifier: ReminderCell.identifier)
        table.register(ReminderCellHeader.self, forHeaderFooterViewReuseIdentifier: ReminderCellHeader.identifier)
        table.separatorStyle = .none
        
        return table
    }()
    
    private var addReminderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.addTarget(self, action: #selector(addTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTableView), name: NSNotification.Name(rawValue: "reloadData"), object: nil)
        setupLayout()
    }
    
    // MARK: - Provatge Methods -
    private func setupLayout() {
        view.backgroundColor = .white
        setupNavigationBar()
        
        view.addSubview(remindersTableView)
        view.addSubview(addReminderButton)
        
        remindersTableView.snp.makeConstraints { make in
            make.size.equalToSuperview().offset(5)
        }
        
        addReminderButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(34)
            make.bottom.equalToSuperview().inset(41)
            make.size.equalTo(56)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "My Reminders"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.tekoRegular16!]
    }
    
    // MARK: - Objc Methods -
    @objc func reloadTableView() {

        self.remindersTableView.reloadData()

    }
    
    @objc func addTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.addReminderButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.addReminderButton.transform = CGAffineTransform.identity
            }
        })
        
            let viewController = CreateReminderViewController(viewModel: self.viewModel)
            viewController.isModalInPresentation = true
            self.navigationController?.modalPresentationStyle = .formSheet
            self.navigationController?.present(viewController, animated: true, completion: nil)

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -
extension MyRemindersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.dataSource.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Reminders count: \(viewModel.dataSource)")
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.identifier, for: indexPath) as? ReminderCell else { return UITableViewCell() }
        
//        if let item = viewModel.dataSource[indexPath.section]?[indexPath.row] {
//            cell.getReminderData(emoji: item.emoji, name: item.name, date: item.date)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView (withIdentifier: ReminderCellHeader.identifier) as? ReminderCellHeader
        header?.setTitle(month: viewModel.months[section])
        return header ?? UITableViewHeaderFooterView()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            self.viewModel.dataSource.remove(at: [indexPath.section])
            self.reloadTableView()
        }

        let share = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // TO DO: Open Edit View
        }

        share.backgroundColor = UIColor.gray
        delete.backgroundColor = UIColor.red

        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
