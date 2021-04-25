//
//  AnalysisResultView.swift
//  FileAnalyzer
//
//  Created by Carlos Gonzalez on 24/4/21.
//

import UIKit

protocol AnalysisResultDelegate {
    func updateData()
}

class AnalysisResultView: UIViewController {
    private let TAG = String(describing: self)
    
    private let SEGUE_TO_FILE_SELECTOR = "navigateToFileSelectorView"
    
    @IBOutlet weak var tv_title: UILabel!
    @IBOutlet weak var tv_total_words: UILabel!
    @IBOutlet weak var loading_view: UIActivityIndicatorView!
    
    @IBOutlet weak var stack_filter: UIStackView!
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var bt_filter: UIButton!
    
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var bt_select_file: UIButton!
    
    private var presenter: AnalysisResultPresenter?
    
    var file: FileObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AnalysisResultPresenter(file!, view: self)
        
        configureView()
        
        presenter?.getData()
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func configureView() {
        bt_select_file.clipsToBounds = true
        bt_select_file.layer.cornerRadius = 20
        
        tv_total_words.isHidden = true
        loading_view.isHidden   = false
        stack_filter.isHidden   = true
        table_view.isHidden     = true
        bt_select_file.isHidden = true
        
        tv_title.text = "ANALYZING FILE..."
        
        loading_view.startAnimating()
        
        text_field_search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: PUBLIC FUNCTIONS
    @IBAction func selectFile(_ sender: UIButton) {
        // TODO: Implementar navigation controller. Se están stackeando demasiados VCs
        // self.navigationController?.popViewController(animated: true)
        performSegue(withIdentifier: SEGUE_TO_FILE_SELECTOR, sender: self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter!.filterList(text: textField.text!)
    }
}

extension AnalysisResultView: AnalysisResultDelegate {
    func updateData() {
        let totalWords = presenter!.isFilterActive() ?
            presenter!.getFilteredList().count : presenter!.getList().count
        
        tv_title.text = "ANALYSIS COMPLETED"
        tv_total_words.text = "A total of \(totalWords) words have been found."
        
        tv_total_words.isHidden = false
        loading_view.isHidden   = true
        stack_filter.isHidden   = false
        table_view.isHidden     = false
        bt_select_file.isHidden = false
        
        loading_view.stopAnimating()

        table_view.reloadData()
    }
}

extension AnalysisResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.isFilterActive() ?
            presenter!.getFilteredList().count : presenter!.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordCountCell.TAG, for: indexPath) as? WordCountCell else {
            fatalError("The dequeued cell is not an instance of WordCountCell.")
        }
        
        let word = presenter!.isFilterActive() ?
            presenter!.getFilteredList()[indexPath.row].getText() : presenter!.getList()[indexPath.row].getText()
        
        let count = presenter!.isFilterActive() ?
            presenter!.getFilteredList()[indexPath.row].getCount() : presenter!.getList()[indexPath.row].getCount()
        
        cell.setCell(
            word: word,
            count: count)
        
        cell.selectionStyle = .none
        
        return cell
    }
}
