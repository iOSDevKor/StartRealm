//
//  ListTableViewController.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 20/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController {
    
    private var albumList: Results<AlbumList>!
    private var startRealm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRealm = try! Realm()
        albumList = startRealm.objects(AlbumList.self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        //****************************************************//
        //                                                    //
        //                   렘 데이터 정렬                       //
        //                                                    //
        //****************************************************//
        if let lastData = albumList[indexPath.row].photoList.sorted(byKeyPath: "createDate", ascending: false).first?.image {
            cell.imageView?.image = UIImage(data: lastData, scale: 0.2)
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        cell.textLabel?.text = albumList[indexPath.row].title
        return cell
    }
    
    // MARK: - Table view delegate
    // 셀 슬라이드시 삭제
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "삭제") { (deleteAction, indexPath) -> Void in
            let listToBeDeleted = self.albumList[indexPath.row]
            //****************************************************//
            //                                                    //
            //                   렘 데이터 삭제                       //
            //                                                    //
            //****************************************************//
            do {
                try self.startRealm.write {
                    self.startRealm.delete(listToBeDeleted)
                }
            } catch {
                print("\(error)")
            }
            self.tableView.reloadData()
        }
        
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "수정") { (editAction, indexPath) -> Void in
            
            let listToBeUpdated = self.albumList[indexPath.row]
            self.alertToAddNewList(listToBeUpdated: listToBeUpdated)
            
        }
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "PhotoList", sender: self.albumList[indexPath.row])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoViewController = segue.destination as! PhotoCollectionViewController
        photoViewController.selectedAlbum = sender as! AlbumList
    }
    
    // MARK: - User action
    // 앨범명 입력받는 alert
    @IBAction func addNewList(_ sender: UIBarButtonItem) {
        alertToAddNewList(listToBeUpdated: nil)
    }
    
    func alertToAddNewList(listToBeUpdated: AlbumList?) {
        let alertController = UIAlertController(title: "아무거나 앨범", message: "앨범을 추가해보세요.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "앨범명"
            if listToBeUpdated != nil{
                textField.text = listToBeUpdated?.title
            }
        }
        // 추가하면 텍스트 필드의 문구를 렘에 저장함
        let addAction = UIAlertAction(title: "완료", style: UIAlertActionStyle.default) { (action) -> Void in
            let listTitle = alertController.textFields?.first?.text
            if listToBeUpdated != nil{
                //****************************************************//
                //                                                    //
                //                   렘 데이터 업데이트                    //
                //                                                    //
                //****************************************************//
                do {
                    try self.startRealm.write() {
                        listToBeUpdated?.title = listTitle!
                    }
                } catch {
                    print("\(error)")
                }
                
            } else {
                let newList = AlbumList()
                newList.title = listTitle!
                //****************************************************//
                //                                                    //
                //                   렘 데이터 추가.                      //
                //                                                    //
                //****************************************************//
                do {
                    try self.startRealm.write() {
                        self.startRealm.add(newList)
                    }
                } catch {
                    print("\(error)")
                }
            }
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
