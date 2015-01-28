//
//  FeedTableViewController.swift
//  InstaClone
//
//  Created by DeviOS on 26/01/15.
//  Copyright (c) 2015 DeviOS. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var listaDeImagens=[]
    
    
    func atualizarLista(){
        let posts = PFQuery(className:"posts")
        posts.includeKey("usuario")
        
        posts.findObjectsInBackgroundWithBlock{ (posts:[AnyObject]!, erro:NSError!) -> Void in
            
            self.listaDeImagens = NSArray(array:posts)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: "atualizarLista", forControlEvents: UIControlEvents.ValueChanged)
self.atualizarLista()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.listaDeImagens.count
    }

     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as FeedTableViewCell
        
        let umaFoto = self.listaDeImagens[indexPath.row] as PFObject
       
        var dateUpdated = umaFoto.updatedAt as NSDate
        var dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "DD/MM/YYYY h:mm a"
        cell.data.text = NSString(format: "%@", dateFormat.stringFromDate(dateUpdated))
        
        
        cell.caption.text =  umaFoto["caption"] as? String

        
        let usuario = umaFoto["usuario"] as PFUser
        cell.nome.text = usuario.username as String
        
        let imagem = umaFoto["img"] as PFFile
        imagem.getDataInBackgroundWithBlock { (imagemData: NSData!, erro: NSError!) -> Void in
            
            cell.img.image = UIImage(data: imagemData)
        }


        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
