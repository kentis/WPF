/*
 *  Copyright (C) 2010 Kent Inge F. Simonsen.
 *  This file is part of Windowed Presentation Frame (WPF).
 *
 *  WPF is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  WPF is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 */
package wpf;

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
var openHandler = ActionListener {
            public override function actionPerformed(arg0: ActionEvent): Void {
                var fc = new JFileChooser();
                var filter = FileFilter {
                            override public function accept(arg0: File): Boolean {
                                return arg0.toString().endsWith(".pdf");
                            }

                            override public function getDescription(): String {
                                "pdf files"
                            }
                        }

                fc.setFileFilter(filter);
                var retval = fc.showOpenDialog(null);
                if (retval == JFileChooser.APPROVE_OPTION) {
                    model.setFile(fc.getSelectedFile());
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
var fxMenuBar: SwingComponent = SwingComponent.wrap(menuBar);

//fxMenuBar.width = w;
fxMenuBar.layoutX = 0;
fxMenuBar.layoutY = 0;

var glassPanel: Rectangle = Rectangle {
            width: 10000
            height: 10000
            fill: Color.TRANSPARENT

            onKeyPressed: function(e) {
                //System.out.println("KEY PRESSED")
                if (e.code == e.code.VK_RIGHT or e.code == e.code.VK_SPACE)
                    model.next() else if (e.code == e.code.VK_LEFT)
                    model.previous()
            }
        }
var full_width: Number;
var full_height: Number;

class SizeBoundingScene extends Scene {

    public var w = bind width on replace {
                //println("Now w {w}");
                full_width = w;
            };
    public var h = bind height on replace {
                //println("Now h {h}");
                full_height = h;
            };
}
var scene = SizeBoundingScene {
            width: 1024
            height: 600

            content: [
                Group {
                    content: [

                        fxMenuBar,
                        Text {
                            font: Font {
                                size: 16
                            }
                            x: 50
                            y: 50
                            content: bind if (model.maxFiles == -1) "" else "Slide {model.currentSlide + 1} of {model.maxFiles}"
                        },
                        ImageView {
                            fitWidth: bind (full_width * 0.6)
                            fitHeight: bind (((full_width * 0.6) / 4) * 3)
                            image: bind if (model.currentImage == null) Image {} else model.currentImage
                            x: 50
                            y: 50
                        },
                        ImageView {
                            image: bind if (model.nextImage == null) Image {} else model.nextImage
                            x: bind ((full_width * 0.6) + 75)
                            y: 50
                        // fitWidth: bind ((full_width * 0.4) - 150)
                        // fitHeight: bind ((full_width * 0.4) - 150)
                        },
                        Text {
                            font: Font {
                                size: 18
                            }
                            x: 50
                            y: bind (full_height - 20)
                            content: bind model.timer
                        },
                        glassPanel
                    ]

                    onMouseClicked: function(e) {
                        if (e.button == e.button.PRIMARY)
                            model.next() else if (e.button == e.button.SECONDARY)
                            model.previous() else {
                            System.out.println(e.wheelRotation)
                        }

                    }
                }
            ]
        }

Stage {
    title: "GPresenter"
    scene: scene
    onClose: function() {
        model.close();
    }
}

glassPanel.requestFocus();
