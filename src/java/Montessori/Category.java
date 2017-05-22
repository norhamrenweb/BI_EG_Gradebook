/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletContext;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 *
 * @author nmohamed
 */
public class Category {
    private String[] id;
     private int[] crit_ids;
    private String name;
    private double weight;
 Connection cn;

    public int[] getCrit_ids() {
        return crit_ids;
    }

    public void setCrit_ids(int[] crit_ids) {
        this.crit_ids = crit_ids;
    }

    public String getDescription() {
        return description;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    private ServletContext servlet;
    private String description;
      
//      private ServletContext servlet;
    
    private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
    public String[] getId() {
        return id;
    }

    public void setId(String[] id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
 public String fetchName(int id, ServletContext servlet)
    { String subName = null ;
        try {
             DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",servlet);
        this.cn = dataSource.getConnection();
             Statement st = this.cn.createStatement();
             
            String consulta = "SELECT name FROM category where id = "+id;
            ResultSet rs = st.executeQuery(consulta);
          
            while (rs.next())
            {
                subName = rs.getString("name");
                
            }
            //this.finalize();
            
        } catch (SQLException ex) {
            System.out.println("Error reading objectives: " + ex);
        }
       
        return subName;
    
    }   
}
