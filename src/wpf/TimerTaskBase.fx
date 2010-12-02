/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package wpf;

import javafx.async.JavaTaskBase;
import java.lang.UnsupportedOperationException;
import javafx.async.RunnableFuture;
import javax.naming.ldap.StartTlsRequest;

/**
 * @author kent
 */

public class TimerTaskBase extends JavaTaskBase{

   public-init var listener: FXListener;
   public-init var startTime: Long;

    override protected function create () : RunnableFuture {
        new TimerTask(startTime, listener);
    }


}
