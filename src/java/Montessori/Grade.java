/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import javax.servlet.ServletContext;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 *
 * @author nmohamed
 */
public class Grade{

    
    private String idStudent;
    private String idCrit;
    private String val;
    private String assignmentid;
        Connection cn;
    public String getAssignmentid() {
        return assignmentid;
    }

    public void setAssignmentid(String assignmentid) {
        this.assignmentid = assignmentid;
    }

   public String getIdStudent() {
        return idStudent;
    }

    public void setIdStudent(String idStudent) {
        this.idStudent = idStudent;
    }

    public String getIdCrit() {
        return idCrit;
    }

    public void setIdCrit(String idCrit) {
        this.idCrit = idCrit;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }
private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
    public String getSymbolGrade(String typeid,String symbol, ServletContext servlet) {
        String[] numvalues=null;
        int position = 100;
           try {
             DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",servlet);
        this.cn = dataSource.getConnection();
             Statement st = this.cn.createStatement();  
            String consulta = "SELECT values,numericvalues FROM grading_types where id = "+typeid;
            ResultSet rs1 = st.executeQuery(consulta);
            String[] values = null ;
            
            while(rs1.next())
            {
            numvalues = rs1.getString("numericvalues").split(",");
            values = rs1.getString("values").split(",");
            }
            position = Arrays.asList(values).indexOf(symbol);
             } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        }
         if(position != 100 && position != -1){
           return numvalues[position];
         }
         else
             return null;
    }
    
}
