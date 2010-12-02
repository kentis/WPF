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

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kent
 */
public class IOUtils {

    public static String readLine(InputStream is, String id){
        String retval = null;
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            String str = reader.readLine();
            while(str != null){

                //TODO: filter ut rett windowID
                if(str.contains(id)){
                    retval = str.substring(8,17);
                }
                str = reader.readLine();
            }
        } catch (IOException ex) {
            Logger.getLogger(IOUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        return retval;
    }
}
