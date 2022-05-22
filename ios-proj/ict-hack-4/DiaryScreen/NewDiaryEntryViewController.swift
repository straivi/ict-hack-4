//
//  NewDiaryEntryViewController.swift
//  ict-hack-4
//
//  Created by Матвей Борисов on 21.05.2022.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
	let table = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registers()
		setupViews()
	}
	
	private func setupViews() {
		view.backgroundColor = AppColors.mainBackground
		table.backgroundColor = AppColors.mainBackground
		table.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
		table.separatorStyle = .none
		
		view.addSubview(table)
		table.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
		table.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor).isActive = true
	}
	
	private func registers() {
		table.dataSource = self
		table.delaysContentTouches = false
		table.register(NewNoteTableViewCell.self, forCellReuseIdentifier: String(describing: NewNoteTableViewCell.self))
		table.register(AdviceRateTableViewCell.self, forCellReuseIdentifier: String(describing: AdviceRateTableViewCell.self))
	}
}

extension NewDiaryEntryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let rawData = data[indexPath.item]
		
		if let dataModel = rawData as? Note {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewNoteTableViewCell.self), for: indexPath) as? NewNoteTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.configure(with: dataModel)
			return cell
			
		} else if let dataModel = rawData as? PsychologicalAdvice {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdviceTableViewCell.self), for: indexPath) as? AdviceTableViewCell else {
				return UITableViewCell()
			}
			cell.configure(with: dataModel)
			return cell
			
		} else if let dataModel = rawData as? AdviceRate {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdviceRateTableViewCell.self), for: indexPath) as? AdviceRateTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.configure(with: dataModel)
			return cell
			
		} else if let dataModel = rawData as? helpСenterRecommendation {
			
		} else if let dataModel = rawData as? PositiveAdvice {
			
		} else {
			return UITableViewCell()
		}
		return UITableViewCell()
	}
}

extension NewDiaryEntryViewController: NewNoteTableViewCellDelegate {
	func textChanged() {
		DispatchQueue.main.async { [weak table] in
			table?.beginUpdates()
			table?.endUpdates()
extension NewDiaryEntryViewController: AdviceRateTableViewCellDelegate {
	func adviceFeedback(with rate: Rate) {
		for (index, dataModel) in data.enumerated() {
			if var rateBlock = dataModel as? AdviceRate {
				rateBlock.rate = rate
				self.table.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
			}
		}
	}
}
