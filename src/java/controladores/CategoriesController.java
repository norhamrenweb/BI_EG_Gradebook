/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Montessori.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 *
 * @author nmohamed
 */
@Controller
public class CategoriesController {
    
    
      Connection cn;
      
//      private ServletContext servlet;
    
    private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
   
    @RequestMapping("/categories/loadCategories.htm")
    public ModelAndView loadCategories(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("categories");
        List<Students> students = new ArrayList<>();
        List<Category> categories = new ArrayList<>();
        String[][] grades = null;
        
         try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSourceAH",hsr.getServletContext());
        this.cn = dataSource.getConnection();
     String classid = "474";//hsr.getParameter("classSelected");
     String termid = "3";
     String courseid = "164"; // based on the course setting
//     DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
//Date lessondate = format.parse(hsr.getParameter("seleccion5"));
        
         Statement st = this.cn.createStatement();

//Query for retrieving students enrolled in the sleected class in the term selected(Enrolled# says the term)
           String consulta = "SELECT r.StudentID , p.FirstName, p.LastName FROM Roster r , Person p where r.Enrolled"+termid+" = 1 and r.StudentID = p.PersonID and r.ClassID ="+classid;
            ResultSet rs = st.executeQuery(consulta);
        Classes lesson = new Classes();
            while (rs.next())
            {
                Students s = new Students();
                s.setId_students(rs.getInt("StudentID"));
                s.setNombre_students(rs.getString("FirstName")+rs.getString("LastName"));
                students.add(s);
            }
            cn.close();
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
 // query for retrieving the catgeories names and their weights based on the class id
            Statement st2 = this.cn.createStatement(); 
            consulta ="select id,weight,name,description from category where t"+termid+" = true and id in(select cat_id from catg_class where class_id = "+classid+")";
            ResultSet rs1 = st2.executeQuery(consulta);
            while(rs1.next())
            {
                Category cat = new Category();
                cat.setDescription(rs1.getString("description"));
                cat.setName(rs1.getString("name"));
                String[] id = new String[1];
                id[0]=""+rs1.getInt("id");
                cat.setId(id);
                cat.setWeight(rs1.getDouble("weight"));
                categories.add(cat);   
            }
            
 //query for retrieving the students grades for all assignments under the category for all criterias and adding them
 //first get the no. of criterias for the equivalent course
//        consulta = "select count(id) from criteria_class where course_id ="+courseid+" group by course_id";
//        ResultSet rs2 = st2.executeQuery(consulta);
//        int critcount = 0;
//        while(rs2.next())
//        {
//        critcount = rs2.getInt("count");
//        }
  // this the table grid
   grades = new String[students.size()][categories.size()];
    int categorycount = 0;
    
  // second getting the assignment ids under the catgeory      
  for(Category c: categories){
      String[] id = new String[1];
      id = c.getId();
        consulta = "select id from criteria_catg where catg_id ="+id[0];
        ResultSet rs2 = st2.executeQuery(consulta);
        int critcount = 0;
       List<Integer> crit_ids = new ArrayList<>();
        while(rs2.next())
        {
          crit_ids.add(rs2.getInt("id"));
        critcount = critcount+1;
        }
     int studentcounter =0;
//      c.setCrit_ids(crit_ids);
     consulta = "select id from assignments where catg_id ="+id[0];
        ResultSet rs3 = st2.executeQuery(consulta);
        ArrayList<String> assignments = new ArrayList<>();
        while(rs3.next())
        {
            assignments.add(""+rs3.getInt("id"));
        }
  
        for(Students s: students)
        {   
           double total = 0;
           for(int i =0;i<critcount;i++){
               double crittotal = 0;
         //   for(int z=0;z<assignments.size();z++){ // not sure if needed
            
        consulta = "select grade from student_grades where student_id ="+s.getId_students()+" and criteria_id = "+crit_ids.get(i);
        ResultSet rs4 = st2.executeQuery(consulta);
        while(rs4.next())
        {
        crittotal = crittotal + rs4.getDouble("grade");
            }
            
          total = total +(crittotal/assignments.size());  
        }
           grades[studentcounter][categorycount]=""+total;//based on the decimal setting the garde should be painted,notdone yet
         studentcounter = studentcounter +1;  
        }  
        categorycount = categorycount +1;
  }
         } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        }
         mv.addObject("grades",grades);
         mv.addObject("students", students);
         mv.addObject("categories", categories);
        return mv;
        
    }
    
    
}
