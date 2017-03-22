//
//  PhotoCollectionViewController.swift
//  StartRealm
//
//  Created by Mijeong Jeon on 21/03/2017.
//  Copyright © 2017 Jo Seong Gyu. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    var selectedAlbum: AlbumList!
    private var startRealm: Realm!
    private var photolList: List<PhotoList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startRealm = try! Realm()
        photolList = selectedAlbum.photoList
        
        self.navigationItem.title = selectedAlbum.title
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
        let itemWidth = (collectionView.frame.size.width - 20)/3
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
        let newPhotoList = PhotoList()
        newPhotoList.image = UIImageJPEGRepresentation(newImage!, 0.1)!
        //****************************************************//
        //                                                    //
        //                렘 사진 데이터 저장(리스트)                //
        //                                                    //
        //****************************************************//        
        do {
            try startRealm.write {
                selectedAlbum?.photoList.append(newPhotoList)
            }
        } catch {
            print("\(error)")
        }
        picker.dismiss(animated: true, completion: {
            self.collectionView?.reloadData()
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
        //****************************************************//
        //                                                    //
        //                   렘 사진 데이터 삭제                   //
        //                                                    //
        //****************************************************//
            do {
                try self.startRealm.write {
                    self.selectedAlbum?.photoList.remove(objectAtIndex: selectedIndexPath.item)
                    self.collectionView?.reloadData()
                }
            } catch {
                print("\(error)")
            }
        })
        self.present(alertController, animated: true, completion: nil)
    }
}
