//
//  ListaUsersTableViewController.swift
//  InstaClone
//
//  Created by DeviOS on 19/01/15.
//  Copyright (c) 2015 DeviOS. All rights reserved.
//

import UIKit

class ListaUsersTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource{

    
    var listaDeUsuarios:Array<PFUser> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()
        
        query.findObjectsInBackgroundWithBlock{ (usuarios:[AnyObject]!, erro:NSError!) -> Void in
        
            for usuario in usuarios{
                
              
                println(usuario.username)
//                if (usuario!.username != PFUser.currentUser().username){
            self.listaDeUsuarios.append(usuario as PFUser)
//                }
            }
            
            self.tableView.reloadData()
        }
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
        
        
        
        return self.listaDeUsuarios.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celula", forIndexPath: indexPath) as UITableViewCell
 
        let usuario = self.listaDeUsuarios[indexPath.row] as PFUser
        cell.textLabel!.text = usuario.username
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let celula = self.tableView.cellForRowAtIndexPath(indexPath)!
        
        if celula.accessoryType == UITableViewCellAccessoryType.Checkmark{
         celula.accessoryType = UITableViewCellAccessoryType.None
            
            let query = PFQuery(className: "timeline")
            query.whereKey("usuarioOrigem", equalTo:PFUser.currentUser().username)
            query.whereKey("usuarioDestino", equalTo:celula.textLabel!.text)
 
            
                
                query.findObjectsInBackgroundWithBlock({ (usuarios:[AnyObject]!, erro:NSError!) -> Void in
                
                for usuario in usuarios {
                let teste = usuario["testeDestino"] as PFUser
              
                usuario.deleteInBackgroundWithBlock({ (Bool, NSError) -> Void in
                let alerta = UIAlertView(title: "Sucesso", message: "Deixou de seguir  "  , delegate: nil, cancelButtonTitle: "Fechar")
                alerta.show()
                })
                }
                })
                
        }else{
        celula.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            let novaEntrada = PFObject(className: "timeline")
            novaEntrada["usuarioOrigem"] = PFUser.currentUser().username
            novaEntrada["usuarioDestino"] = celula.textLabel!.text
            
            novaEntrada["testeOrigem"] = PFUser.currentUser()
            
            let usuario = self.listaDeUsuarios[indexPath.row] as PFUser
            
            novaEntrada["testeDestino"] = usuario
            
            novaEntrada.saveInBackgroundWithBlock({ (Bool, NSError) -> Void in
                let alerta = UIAlertView(title: "Sucesso", message: "Seguindo \(usuario.username)", delegate: nil, cancelButtonTitle: "Fechar")
                alerta.show()
            })
            
            
        }
        
        

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
