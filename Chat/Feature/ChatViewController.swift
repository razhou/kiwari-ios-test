//
//  ViewController.swift
//  Chat
//
//  Created by Jelajah Data Semesta on 10/03/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Kingfisher

class ChatViewController: JSQMessagesViewController {

    var messages = [JSQMessage]()
    var email: String? = "jarjit@mail.com"
    var avatrUrl: String? = ""
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()

    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if email == Constants.UserOne.email {
            senderId = Constants.UserOne.senderId
            senderDisplayName = Constants.UserOne.name
            
            title = Constants.UserTwo.name
            avatrUrl = Constants.UserTwo.avatar
        }else{
            senderId = Constants.UserTwo.senderId
            senderDisplayName = Constants.UserTwo.name
            
            title = Constants.UserOne.name
            avatrUrl = Constants.UserOne.avatar
        }
       
        self.toolbarView()
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero

        let query = Constants.refs.databaseChats.queryLimited(toLast: 10)

        _ = query.observe(.childAdded, with: { [weak self] snapshot in

            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                let date        = data["date"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, senderDisplayName: name, date: date.strToDate(withFormat: "yyyy-MM-dd HH:mm"), text:text )
                {
                    self?.messages.append(message)

                    self?.finishReceivingMessage()
                }
            }
        })
    }
    
    
    private func toolbarView(){
        
        self.imageUser()
        self.logout()
        navigationController?.navigationBar.isTranslucent = false

        inputToolbar.contentView.leftBarButtonItem = nil
    }

    private func imageUser() {
       let img = UIImageView(image: UIImage(named: "img_chat"))
       guard let url = avatrUrl, let urlimage = URL(string: url) else { return }

       img.kf.setImage(with: urlimage)
       let barButton = UIBarButtonItem(customView: img)
       self.navigationItem.leftBarButtonItem = barButton
       
     }
    
    private func logout(){
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
 
    
    @objc private func signOut(){
      let defaults = UserDefaults.standard
       
        if  let _ = defaults.string(forKey: "email"){
            
            defaults.removeObject(forKey: "email")
            let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
            UIApplication.shared.delegate?.window??.rootViewController = login
        }
        
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }


    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return  NSAttributedString(string:String(format: "%@ %@", messages[indexPath.item].senderDisplayName, messages[indexPath.item].date.string(withFormat: "yyyy-MM-dd HH:mm")))
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 15 : 15
    }
    
    

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.refs.databaseChats.childByAutoId()
        let strDate = date.string(withFormat: "yyyy-MM-dd HH:mm")

        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text, "date":strDate]

        ref.setValue(message)

        finishSendingMessage()
    }
}

