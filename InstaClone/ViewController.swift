//
//  ViewController.swift
//  InstaClone
//
//  Created by DeviOS on 14/01/15.
//  Copyright (c) 2015 DeviOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate {

       @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var imagemSelecionada: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let secondViewController:ListaUsersTableViewController = ListaUsersTableViewController()
//        
//        self.presentViewController(secondViewController, animated: true, completion: nil)
        
        
        if PFUser.currentUser() == nil{
        
          let telaLogin = PFLogInViewController()
            telaLogin.delegate = self
            presentViewController(telaLogin, animated: true, completion: nil)
            telaLogin.delegate = self
            telaLogin.fields = PFLogInFields.Facebook
            telaLogin.signUpController.delegate = self
        

        }
        
//        let loginViewContoler = new PFLoginViewController()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
      
         var camposCompletos = true
        
        if (password.isEmpty || username.isEmpty){
        let alerta = UIAlertView(title:"Erro",message: "Preencha todos os campos",delegate:nil,cancelButtonTitle:"Fechar")
            alerta.show();
            
           camposCompletos = false
        }

        
        return camposCompletos
    }
    
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion:nil)
        
    }
    
    func  signUpViewController(signUpController: PFSignUpViewController!, shouldBeginSignUp info: [NSObject : AnyObject]!) -> Bool {

        let dados = info as NSDictionary
        
        var camposCompletos = true
        
        for(chave,valor) in dados {
            if let campo = dados.objectForKey(chave) as? NSString {
                if campo.length == 0 {
                    camposCompletos = false
                }
            }
        }
        
        
        if !camposCompletos{
            
            let alerta = UIAlertView(title:"Erro",message: "Preencha todos os campos",delegate:nil,cancelButtonTitle:"Fechar")
            alerta.show();
        }
    
        return camposCompletos
    }
    
    
    @IBAction func sendImg(sender: UIBarButtonItem) {
        println("click")
        super.didReceiveMemoryWarning()
        let imagePicker = UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }else{
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        imagePicker.allowsEditing = false
              imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
  
        
    }
    
    
    func  imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
        imagemSelecionada.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func uploadImagem(sender: UIButton) {
        let indicadorUp = UIActivityIndicatorView(frame: CGRect(x: 0, y:0 ,width: 60, height: 60))
            
            indicadorUp.startAnimating()
            indicadorUp.hidesWhenStopped = true
        
        
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let imgData = UIImagePNGRepresentation(self.imagemSelecionada!.image)
        let imagemParaUpload = PFFile (name: "imagem.png", data:imgData)
        let novoPost = PFObject(className: "posts")
        novoPost["caption"] = self.caption.text
        novoPost["usuario"] = PFUser.currentUser()
        novoPost["img"] = imagemParaUpload
        
        novoPost.saveInBackgroundWithBlock { (sucesso:Bool,erro:NSError!) -> Void in
            var texto = String()
            if sucesso {
                texto = "Imagem postada com sucesso!"
            }else{
                texto = erro.description
            }
            
            let alertaEnvio = UIAlertView(title:"Alerta",message:texto,delegate:nil,cancelButtonTitle:"Fechar")
            alertaEnvio.show()
            
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        }

    
  
}
}
