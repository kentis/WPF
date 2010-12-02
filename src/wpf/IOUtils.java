/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
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
