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

import javafx.async.RunnableFuture;

/**
 *
 * @author kent
 */
public class TimerTask implements RunnableFuture{

    public boolean finished = false;
    private FXListener listener;
    private long statTime;
    public  TimerTask(long startTime, FXListener listener){
        this.listener = listener;
        this.statTime = startTime;
    }

    @Override
    public void run() throws Exception {
        while(!finished){
            long diff = System.currentTimeMillis() - statTime;
            diff = diff /1000;
            long seconds = diff % 60;
            diff = diff / 60;
            long minutes = diff % 60;
            long hours = diff / 60;
            StringBuilder sb = new StringBuilder();

            if(hours < 10) sb.append("0");
            sb.append(hours).append(":");

            if(hours < 10) sb.append("0");
            sb.append(minutes).append(":");

            if(seconds < 10) sb.append("0");
            sb.append(seconds);

            listener.callback(sb.toString());
            Thread.sleep(100);
            
        }

    }



    public void stop(){
        finished = true;
    }
}
