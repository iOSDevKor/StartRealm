//
//  ListTableViewController.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 20/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController, UISearchBarDelegate {
    
    var albums: Results<Album>!
    var startRealm: Realm!
    var token: NotificationToken?
    var searchActive: Bool = false

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRealm = try! Realm()
        //=====================================================//
        //               Realm Sort : 앨범 최신 정렬              //
        //====================================================//
        albums = startRealm.objects(Album.self).sorted(byKeyPath: "createDate", ascending: true)
        
        //=====================================================//
        //             Realm Notification Token                //
        //====================================================//
        token = albums.addNotificationBlock({ (change: RealmCollectionChange<Results<Album>>) in
            self.tableView?.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! AlbumTableViewCell
        //=====================================================//
        //           Realm Sort : 앨범 내 사진 최신 정렬            //
        //====================================================//
        if let lastData = albums[indexPath.row].photos.sorted(byKeyPath: "createDate", ascending: false).first?.image {
            cell.thumnailView?.image = UIImage(data: lastData, scale: 0.1)
        } 
        cell.titleLabel?.text = albums[indexPath.row].title
        return cell
    }
    
    // MARK: - Table view delegate
    // 셀 슬라이드시 수정, 삭제
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "삭제") { (deleteAction, indexPath) -> Void in
            let albumToBeDeleted = self.albums[indexPath.row]
            //=====================================================//
            //                 Realm Delete : 앨범 삭제              //
            //====================================================//
            do {
                try self.startRealm.write {
                    self.startRealm.delete(albumToBeDeleted.photos)
                    self.startRealm.delete(albumToBeDeleted)
                }
            } catch {
                print("\(error)")
            }
        }
        
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "수정") { (editAction, indexPath) -> Void in
            let album = self.albums[indexPath.row]
            self.alertToAddNewList(albumToBeUpdated: album)
        }
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Photos", sender: self.albums[indexPath.row])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoViewController = segue.destination as! PhotoCollectionViewController
        photoViewController.selectedAlbum = sender as! Album
    }
    
    // MARK: - User action
    // 앨범명 입력받는 alert
    @IBAction func addNewList(_ sender: UIBarButtonItem) {
        alertToAddNewList(albumToBeUpdated: nil)
    }
    
    func alertToAddNewList(albumToBeUpdated: Album?) {
        let alertController = UIAlertController(title: "아무거나 앨범", message: "앨범명을 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "앨범명"
            if albumToBeUpdated != nil{
                textField.text = albumToBeUpdated?.title
            }
        }
        // 추가하면 텍스트 필드의 문구를 렘에 저장함
        let addAction = UIAlertAction(title: "완료", style: UIAlertActionStyle.default) { (action) -> Void in
            let listTitle = alertController.textFields?.first?.text
            if albumToBeUpdated != nil{
                //=====================================================//
                //               Realm Update : 앨범명 수정               //
                //====================================================//
                // primary-key 이용한 방식
//                let newAlbum = Album()
//                newAlbum.uuid = (albumToBeUpdated?.uuid)!
//                newAlbum.title = listTitle!
//                newAlbum.uuid = "mynameisMJ"
//                let newAlbum = ["uuid": albumToBeUpdated?.uuid, "title": listTitle]
                do {
                    try self.startRealm.write() {
//                        self.startRealm.create(Album.self, value: newList, update: true)
                        albumToBeUpdated?.title = listTitle!
                    }
                } catch {
                    print("\(error)")
                }
                
            } else {
                let newList = Album()
                newList.title = listTitle!
                //=====================================================//
                //               Realm Write : 새 앨범 생성               //
                //====================================================//
                do {
                    try self.startRealm.write() {
                        self.startRealm.add(newList)
                    }
                } catch {
                    print("\(error)")
                }
            }
        }
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //=====================================================//
        //             Realm Filter : 앨범명 검색                 //
        //====================================================//
        albums = startRealm.objects(Album.self).filter("title contains[c] %@", searchText)
        self.tableView.reloadData()
    }

}
