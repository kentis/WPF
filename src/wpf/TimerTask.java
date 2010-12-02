/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
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
