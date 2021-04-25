//
//  FileSelectorView.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import UIKit

protocol FileSelectorDelegate {
    func updateData()
}

class FileSelectorView: UIViewController {
    private let TAG = String(describing: self)
    private let SEGUE_TO_ANALYSIS_RESULT = "navigateToAnalysisResultView"
    
    private var presenter: FileSelectorPresenter?

    @IBOutlet weak var bt_analyze: UIButton!
    @IBOutlet weak var table_view: UITableView!
    
    private var lastSelectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FileSelectorPresenter(view: self)
        
        configureView()
        
        presenter!.getData()
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func configureView() {
        bt_analyze.isEnabled = false
        bt_analyze.clipsToBounds = true
        bt_analyze.layer.cornerRadius = 20.0
        
        table_view.delegate = self
        table_view.dataSource = self
        table_view.separatorStyle = .none
    }
    
    private func deselectPreviousCell(_ indexPath: IndexPath) {
        guard let row = lastSelectedRow else { return }
        
        if let cell = table_view.cellForRow(at: IndexPath(row: row, section: indexPath.section)) as? TextFileCell {
            cell.deselectRow()
        }
    }
    
    private func selectCurrentCell(_ indexPath: IndexPath) {
        if let cell = table_view.cellForRow(at: indexPath) as? TextFileCell {
            cell.selectRow()
        }
        
        activateButton()
    }
    
    private func activateButton() {
        bt_analyze.isEnabled = true
        bt_analyze.backgroundColor = .systemBlue
        bt_analyze.setTitleColor(.white, for: .normal)
    }
    
    // MARK: PUBLIC FUNCTIONS
    @IBAction func analyzeSelectedFile(_ sender: UIButton) {
        performSegue(withIdentifier: SEGUE_TO_ANALYSIS_RESULT, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_TO_ANALYSIS_RESULT {
            if let vc = segue.destination as? AnalysisResultView {
                vc.file = presenter!.getList()[lastSelectedRow!]
            }
        }
    }
}

// MARK: FILESELECTOR DELEGATE
extension FileSelectorView: FileSelectorDelegate {
    func updateData() {
        table_view.reloadData()
    }
}

// MARK: UITABLEVIEW DELEGATE
extension FileSelectorView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != lastSelectedRow {
            deselectPreviousCell(indexPath)
            lastSelectedRow = indexPath.row
            selectCurrentCell(indexPath)
        }
    }
}

// MARK: UITABLEVIEW DATASOURCE
extension FileSelectorView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFileCell.TAG, for: indexPath) as? TextFileCell else {
            fatalError("The dequeued cell is not an instance of TextFileCell.")
        }
        
        cell.setCell(presenter!.getList()[indexPath.row])
        return cell
    }
}

