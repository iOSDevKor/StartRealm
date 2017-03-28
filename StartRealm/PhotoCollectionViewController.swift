//
//  PhotoCollectionViewController.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 21/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var startRealm: Realm!
    var photolList: List<Photo>!
    var selectedAlbum: Album!

    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRealm = try! Realm()
        photolList = selectedAlbum.photos
        
        self.navigationItem.title = selectedAlbum.title
        //=====================================================//
        //             Realm Notification Token                //
        //====================================================//
        //        token = startRealm.addNotificationBlock({ (noti, startRealm) in
        //            self.collectionView?.reloadData()
        //        })
        token = photolList.addNotificationBlock({ (change: RealmCollectionChange<List<Photo>>) in
            self.collectionView?.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photolList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        if let image = UIImage(data: photolList[indexPath.item].image, scale: 0.1) {
            cell.imageView.image = image
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        alertToEditorDelete(selectedIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.size.width - 10)/3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    
    // MARK: 사진 추가
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.sourceType = .photoLibrary
        
        self.present(imagePickerView, animated: true) {
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let newImage = info[UIImagePickerControllerOriginalImage] as! UIImage?
        let newPhoto = Photo()
        newPhoto.image = UIImageJPEGRepresentation(newImage!, 0.01)!
        //=====================================================//
        //               Realm Write : 사진 저장                 //
        //====================================================//
        do {
            try startRealm.write {
                selectedAlbum?.photos.append(newPhoto)
            }
        } catch {
            print("\(error)")
        }
        picker.dismiss(animated: true, completion: {
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 사진 삭제/수정
    func alertToEditorDelete(selectedIndexPath: IndexPath) {
        let alertController = UIAlertController(title: "사진 삭제", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "삭제", style: UIAlertActionStyle.destructive) { (action) -> Void in
            //=====================================================//
            //               Realm Delete : 사진 삭제                //
            //====================================================//
            do {
                try self.startRealm.write {
                    self.startRealm.delete(self.photolList[selectedIndexPath.item])
                }
            } catch {
                print("\(error)")
            }
        })
        self.present(alertController, animated: true, completion: nil)
    }
}
