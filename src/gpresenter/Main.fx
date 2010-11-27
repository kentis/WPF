/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package gpresenter;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import java.awt.event.*;
import javax.swing.*;
import javafx.ext.swing.SwingComponent;
import java.lang.System;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.Group;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javax.swing.filechooser.FileFilter;

import java.io.File;
import java.lang.String;
/**
 * @author kent
 */
 var model = new PresenterModel();

var openHandler = ActionListener{

    public override function actionPerformed (arg0 : ActionEvent) : Void {
        var fc = new JFileChooser();
        var filter = FileFilter{
            override public function accept (arg0 : File) : Boolean {
                return arg0.toString().endsWith(".pdf");
            }

            override public function getDescription () : String {
                "pdf files"
            }


        }

        fc.setFileFilter(filter);
        var retval = fc.showOpenDialog(null);
        if(retval == JFileChooser.APPROVE_OPTION){
            model.setFile(fc.getSelectedFile());
            System.out.println(fc.getSelectedFile().toString());
        }

    }
}


var menuBar = new JMenuBar();
var menu = new JMenu("File");
//menu.setMnemonic(KeyEvent.VK_A);
menuBar.add(menu);


var menuItem = new JMenuItem("Open");
menuItem.addActionListener(openHandler);
menu.add(menuItem);

var fxMenuBar : SwingComponent = SwingComponent.wrap(menuBar);

//fxMenuBar.width = w;
fxMenuBar.layoutX=0;
fxMenuBar.layoutY=0;



var glassPanel: Rectangle = Rectangle {
        width: 10000
        height: 10000
        fill: Color.TRANSPARENT
}

var scene = Scene {
        width: 1024
        height: 600

        content: [
            Group{

            content: [

            fxMenuBar,
            Text {
                font: Font {
                    size: 16
                }
                x: 50
                y: 50
                content: bind if(model.maxFiles == -1) ""
                else "Slide {model.currentSlide +1} of {model.maxFiles}"
            },
            ImageView {
                image: bind if(model.currentImage == null) Image { }
                        else model.currentImage
                x:100
                y:100
            },
            ImageView {
                image: bind if(model.nextImage == null) Image { }
                        else model.nextImage
                x:600
                y:100
            },
            Text {
                font: Font {
                    size: 16
                }
                x: 50
                y: 500
                content: bind model.timer
            },
            glassPanel
           
        ]
        onMouseClicked:function(e) {
            model.next()
        }

        }

        ]
    }




Stage {
    title: "GPresenter"
    scene: scene
}