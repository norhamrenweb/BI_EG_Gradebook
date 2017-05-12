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
public class GradeBookController {
    
    
      Connection cn;
      
//      private ServletContext servlet;
    
    private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
   
    @RequestMapping("/gradebook/loadRecords.htm")
    public ModelAndView loadRecords(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("gradebook");
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
        consulta = "select count(id) from criteria_class where course_id ="+courseid+" group by course_id";
        ResultSet rs2 = st2.executeQuery(consulta);
        int critcount = 0;
        while(rs2.next())
        {
        critcount = rs2.getInt("count");
        }
  // this the table grid
   grades = new String[students.size()][categories.size()];
    int categorycount = 0;
    
  // second getting the assignment ids under the catgeory      
  for(Category c: categories){
     int studentcounter =0;
      String[] id = new String[1];
      id = c.getId();
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
           for(int i =1;i<=critcount;i++){
               double crittotal = 0;
            for(int z=0;z<assignments.size();z++){
            
        consulta = "select criteria"+i+" from student_grades where student_id ="+s.getId_students()+" and assignmentid = "+assignments.get(z);
        ResultSet rs4 = st2.executeQuery(consulta);
        while(rs4.next())
        {
        crittotal = crittotal + rs4.getDouble("criteria"+i);
            }
            }
          total = total +(crittotal/assignments.size());  
        }
           grades[studentcounter][categorycount]=""+total;
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
    
    
    public List<Progress> getRecords(Classes lesson,ServletContext servlet) throws SQLException
    {
        
        List<Progress> records = new ArrayList<>();
         try {
       
        
        
            
             Statement st = this.cn.createStatement();
           
          
            String consulta = "SELECT * FROM public.lesson_stud_att where lesson_id ="+lesson.getId();
            ResultSet rs = st.executeQuery(consulta);
          
            while (rs.next())
            {
                Progress att = new Progress();
             
                att.setStudentid(rs.getInt("student_id"));
                att.setAttendancecode(rs.getString("attendance"));
                records.add(att);
            }
             for(Progress record : records)
            {
                String[] ids = new String[1];
                ids = lesson.getObjective().getId();
            consulta = "SELECT rating.name as ratingname,progress_report.comment FROM progress_report  INNER JOIN rating on progress_report.rating_id = rating.id where lesson_id ="+lesson.getId()+" AND student_id = '"+record.getStudentid()+"' ";
            ResultSet rs3 = st.executeQuery(consulta);
            while (rs3.next())
            {
              record.setRating(rs3.getString("ratingname"));
              record.setComment(rs3.getString("comment"));
              record.setComment_date("comment_date");
            }
            }
            cn.close();
             DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSourceAH",servlet);
        this.cn = dataSource.getConnection();
        st = this.cn.createStatement();
            for(Progress record : records)
            {
            consulta = "SELECT FirstName,LastName FROM AH_ZAF.dbo.Students where StudentID = '"+record.getStudentid()+"'";
            ResultSet rs2 = st.executeQuery(consulta);
            while (rs2.next())
            {
              record.setStudentname(rs2.getString("FirstName")+","+rs2.getString("LastName"));
            }
            }
        
            
        } catch (SQLException ex) {
            System.out.println("Error  " + ex);
        }
    
    return records;
    }
    @RequestMapping("/lessonprogress/saveRecords.htm")
    public ModelAndView saveRecords(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        String message="Records successfully saved"; 
        String[]lessonid=hsr.getParameterValues("TXTlessonid");
        ModelAndView mv = new ModelAndView("redirect:/lessonprogress/loadRecords.htm?LessonsSelected="+lessonid[0],"message",message);
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
        String[] objectiveid = hsr.getParameterValues("TXTobjectiveid");
        String[] comments = hsr.getParameterValues("TXTcomment");
        String[] ratings= hsr.getParameterValues("TXTrating");
        String[] studentids= hsr.getParameterValues("TXTstudentid");
        String[] att= hsr.getParameterValues("TXTattendance");
        String[] teacher= hsr.getParameterValues("TXTinstructor");

    Statement st = this.cn.createStatement();
        if(!teacher[0].isEmpty())
        {
        st.executeUpdate("update lessons set presentedby = "+teacher[0]+" where id = "+lessonid[0]);
        } 
    for(int i=0;i<studentids.length;i++)
    {  // if the teacher did not fill the attendance no update will be done to avoid null pointer exception
        if(!att[i].isEmpty())
    { String test = "update lesson_stud_att set attendance = '"+att[i]+"',timestamp= now() where lesson_id = "+lessonid[0]+" AND student_id = '"+studentids[i]+"'";
    st.executeUpdate(test);
    }
    }
   
     for(int i=0;i<studentids.length;i++)
         
    {   
        if(!ratings[i].isEmpty()){ 
        ResultSet rs1 = st.executeQuery("select id from rating where name = '"+ratings[i]+"'");
                int ratingid = 0;
                
                while(rs1.next())
                {
               ratingid = rs1.getInt("id");
                }
                //check if there is already progress records for this lesson, if yes then will do update instead of insert
              ResultSet rs = st.executeQuery("select * from progress_report where lesson_id ="+lessonid[0]+" AND student_id = '"+studentids[i]+"'");
              if(!rs.next()){
                st.executeUpdate("insert into progress_report(comment_date,comment,rating_id,lesson_id,student_id,objective_id,generalcomment) values (now(),'"+comments[i]+"','"+ratingid+"','"+lessonid[0]+"','"+studentids[i]+"','"+objectiveid[0]+"',false)");
              }
              else{
                st.executeUpdate("update progress_report set comment_date = now(),comment = '"+comments[i]+"',rating_id ='"+ratingid+"' ,lesson_id = '"+lessonid[0]+"',student_id = '"+studentids[i]+"',objective_id ='"+objectiveid[0]+"',generalcomment = false where lesson_id = "+lessonid[0]+" AND student_id = '"+studentids[i]+"'");

              }
    }
    } 
     
//     mv.addObject("message",message);
        return mv;
        
    }
}
