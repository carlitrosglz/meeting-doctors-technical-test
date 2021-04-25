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
    
    @IBOutlet weak var tv_title: UILabel!
    @IBOutlet weak var tv_total_words: UILabel!
    @IBOutlet weak var loading_view: UIActivityIndicatorView!
    
    @IBOutlet weak var stack_filter: UIStackView!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var bt_filter: UIButton!
    
    @IBOutlet weak var table_view: UITableView!
    @IBOutlet weak var bt_select_file: UIButton!
    
    private var presenter: AnalysisResultPresenter?
    
    var file: FileObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AnalysisResultPresenter(file!, view: self)
        
        configureView()
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
    }
    
    // MARK: PUBLIC FUNCTIONS
    @IBAction func selectFile(_ sender: UIButton) {
        // TODO: Implementar navigation controller
        self.navigationController?.popViewController(animated: true)
    }
}

extension AnalysisResultView: AnalysisResultDelegate {
    func updateData() {
        tv_total_words.isHidden = false
        loading_view.isHidden   = true
        stack_filter.isHidden   = false
        table_view.isHidden     = false
        bt_select_file.isHidden = false
        
        loading_view.stopAnimating()
        
        tv_title.text = "ANALYSIS COMPLETED"
        tv_total_words.text = "A total of \(presenter!.getList().count) words have been found."
        table_view.reloadData()
    }
}

extension AnalysisResultView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordCountCell.TAG, for: indexPath) as? WordCountCell else {
            fatalError("The dequeued cell is not an instance of WordCountCell.")
        }
        
        cell.setCell(
            word: presenter!.getList()[indexPath.row].getText(),
            count: presenter!.getList()[indexPath.row].getCount())
        
        cell.selectionStyle = .none
        
        return cell
    }
}
