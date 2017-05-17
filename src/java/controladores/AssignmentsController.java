/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

/**
 *
 * @author nmohamed
 */
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


@Controller
public class AssignmentsController {
     Connection cn;
      
//      private ServletContext servlet;
    
    private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
   
    @RequestMapping("/assignments/loadRecords.htm")
    public ModelAndView loadRecords(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("assignments");
         List<Students> students = new ArrayList<>();
        List<Assignment> assignments = new ArrayList<>();
        List<Criteria> criterias = new ArrayList<>();
        String[][][] grades = null;
        
         try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSourceAH",hsr.getServletContext());
        this.cn = dataSource.getConnection();
     String classid = "474";//hsr.getParameter("classSelected");
     String catgid = "1";
     String termid = "1";
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
            consulta ="select id,name,description from assignments where catg_id = "+catgid;
            ResultSet rs1 = st2.executeQuery(consulta);
            while(rs1.next())
            {
                Assignment a = new Assignment();
                a.setDescription(rs1.getString("description"));
                a.setName(rs1.getString("name"));
                String[] id = new String[1];
                id[0]=""+rs1.getInt("id");
                a.setId(id);
               
                assignments.add(a);   
            }
            consulta ="select id,name from criteria_catg where catg_id ="+catgid;
            ResultSet rs2 = st2.executeQuery(consulta);
            while(rs2.next())
            {
                Criteria c = new Criteria();
              
                c.setName(rs2.getString("name"));
                String[] id = new String[1];
                id[0]=""+rs2.getInt("id");
               c.setId(id);
               
                criterias.add(c);   
            }
            int studentcount = 0;
            grades = new String[students.size()][assignments.size()][criterias.size()];
            //looping through students then thorugh assignements and criterias to fill the grades
            for(Students s:students)
            {
                   int assignmentcount = 0;
                for(Assignment a:assignments){
                       String[] id = new String[1];
                      id = a.getId();
                      int criteriacount = 0;
                 for(Criteria x:criterias){ 
                     String[] id2 = new String[1];
                      id2 =x.getId();
                consulta ="select grade from student_grades where student_id = " +s.getId_students()+"and assignmentid = "+id[0]+" and criteria_id = "+id2[0];
            ResultSet rs3 = st2.executeQuery(consulta);
            while(rs3.next())
            {
                grades[studentcount][assignmentcount][criteriacount]= ""+rs3.getDouble("grade");
                        
            }
                 criteriacount = criteriacount+1;  
                 }
                assignmentcount = assignmentcount +1;
                }
                studentcount = studentcount +1;
            } }catch (SQLException ex) {
            System.out.println("Error: " + ex);
        }
        // assuming the criteria are the same for all assignements under the same category
         mv.addObject("students",students);
         mv.addObject("criterias", criterias);
          mv.addObject("assignments", assignments);
           mv.addObject("grades", grades);
         
        return mv;
        
    }
}
