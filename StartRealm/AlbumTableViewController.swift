//
//  AlbumTableViewController.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 20/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //=====================================================//
        //                      Realm Init                    //
        //====================================================//
        
        
        //=====================================================//
        //               Realm Sort : 앨범 최신 정렬              //
        //====================================================//
        
        
        //=====================================================//
        //             Realm Notification Token                //
        //====================================================//

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumTableViewCell
        //=====================================================//
        //           Realm Sort : 앨범 내 사진 최신 정렬            //
        //====================================================//
        
        
        return cell
    }
    
    // MARK: - Table view delegate
    // 셀 슬라이드시 수정, 삭제
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "삭제") { (deleteAction, indexPath) -> Void in
            //=====================================================//
            //              Realm Delete : 앨범 삭제                 //
            //====================================================//

        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "수정") { (editAction, indexPath) -> Void in
        }
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: - User action
    // 앨범명 입력받는 alert
    @IBAction func addNewList(_ sender: UIBarButtonItem) {
        //=====================================================//
        //             Realm Write : 앨범명 입력                 //
        //====================================================//
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //=====================================================//
        //             Realm Filter : 앨범명 검색                //
        //====================================================//
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
