//
//  FileSelectorView.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import UIKit

class FileSelectorView: UIViewController {

    @IBOutlet weak var bt_analyze: UIButton!
    @IBOutlet weak var table_view: UITableView!
    
    private var lastSelectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        // presenter.getData() --> lectura de los ficheros del folder raw, devuelve callback a view para refrescar tableview
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func configureView() {
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
        // presenter.executeAnalysis()
    }
}

extension FileSelectorView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != lastSelectedRow {
            deselectPreviousCell(indexPath)
            lastSelectedRow = indexPath.row
            selectCurrentCell(indexPath)
        }
    }
}

extension FileSelectorView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
        // return list.count --> total de ficheros que se han encontrado en el folder raw.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFileCell.TAG, for: indexPath) as? TextFileCell else {
            fatalError("The dequeued cell is not an instance of TextFileCell.")
        }
        
        cell.setCell(filename: "Nombre del fichero")
        
        return cell
    }
}

