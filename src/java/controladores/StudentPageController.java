/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Montessori.Assignment;
import Montessori.Category;
import Montessori.Classes;
import static Montessori.LoginVerification.SQLQuery;
import Montessori.Students;
import Montessori.User;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author nmohamed
 */
@Controller
public class StudentPageController {
  
     Connection cn;
      static Logger log = Logger.getLogger(AssignmentsController.class.getName());
      private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
      //get the id of the student and the id of the term chosen by user then loads the classes that the student is enrolled in
       @RequestMapping("/studentpage/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("studentpage");
        String studentid = hsr.getParameter("studentid");
        String termid = hsr.getParameter("termid");
    HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSourceAH",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
          String query ="select c.Name,r.ClassID FROM Roster as r inner join Classes as c on r.ClassID = c.ClassID where r.StudentID ='"+studentid+"' and r.Enrolled"+termid+" = 1";//this must change to get the term value from selected
         ResultSet rs = st.executeQuery(query);
         ArrayList<Classes> classes = new ArrayList<>();
        while(rs.next()){
            Classes enrolled = new Classes();
            enrolled.setName(rs.getString("Name"));
            enrolled.setId(rs.getInt("ClassID"));
            classes.add(enrolled);
        }
    mv.addObject("classlist",classes);
        return mv;
    }
 //load the assignments grades of the selected class
       @RequestMapping("/studentpage/loadgrades.htm")
    public ModelAndView loadgrades(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("studentpage");
        String studentid = hsr.getParameter("studentid");
        String termid = hsr.getParameter("termid");
        String classid = hsr.getParameter("classid");
    HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
          //query to get all categories under this class for a certain term
          String query ="select name,id from category where term_ids LIKE '%"+termid+"%' and id in (select cat_id from catg_class where class_id = '"+classid+"')";//this must change to get the term value from selected
         ResultSet rs = st.executeQuery(query);
         ArrayList<Category> categories = new ArrayList<>();
        while(rs.next()){
            Category category = new Category();
            category.setName(rs.getString("name"));
            String[] id = new String[1];
            id[0]=""+rs.getInt("id");
            category.setId(id);
            categories.add(category);
        }
        //get the assignments under this catgeory 
        
        for(Category c:categories){
             ArrayList<Assignment> assignments = new ArrayList<>();
            String[] id = c.getId();
            String consulta ="select name,id from assignments where catg_id ='"+id[0]+"'";
            ResultSet  rs1 = st.executeQuery(consulta);
            while(rs1.next()){
                Assignment task = new Assignment();
                String[] tid = new String[1];
                tid[0]=rs1.getString("id");
                task.setId(tid);
                task.setName("name");
               assignments.add(task);
            }
            c.setAssignments(assignments);
          //get the grades per assignment  
        }
        
        
    mv.addObject("categories",categories);
        return mv;
    }
}
