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
 *  along with WPF.  If not, see <http://www.gnu.org/licenses/>.
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
