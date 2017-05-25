/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;


import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.log4j.Logger;

/**
 *
 * @author nmohamed
 */
public class ActivityLog {
    static Logger log = Logger.getLogger(ActivityLog.class.getName());
    public static void log (String userid,String studentid,String action,Connection cn){
        try{
        Statement st = cn.createStatement();
       
        st.executeUpdate("insert into activitylog(user_id,student_id,action,timetsamp) values('"+userid+"','"+studentid+"','"+action+"',now())");
        
        }
        catch(SQLException ex) {
           StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
        }
    }
    //incase the action was not involving a tsudent record (ex adding actegory or assignment)
      public static void log (String userid,String action,Connection cn){
        try{
        Statement st = cn.createStatement();
       
        st.executeUpdate("insert into activitylog(user_id,action,timestamp) values('"+userid+"','"+action+"',now())");
        
        }
        catch(SQLException ex) {
           StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
        }
    }
    
}
