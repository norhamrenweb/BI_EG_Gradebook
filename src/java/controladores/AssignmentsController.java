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
import atg.taglib.json.util.JSONObject;
import com.google.gson.Gson;
import java.io.PrintWriter;
import java.io.StringWriter;
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
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class AssignmentsController {
     Connection cn;
         static Logger log = Logger.getLogger(AssignmentsController.class.getName());
 
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
     String[] catgid = new String[1];
     catgid[0]= "1";
     String termid = "1";
     String courseid = "164"; // based on the course setting
//     DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
//Date lessondate = format.parse(hsr.getParameter("seleccion5"));
          Category cat = new Category();
          String tmp = cat.fetchName(Integer.parseInt(catgid[0]), hsr.getServletContext());
          cat.setName(tmp);
          cat.setId(catgid);
         mv.addObject("category",cat);
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
            consulta ="select * from assignments where catg_id = "+catgid[0];
            ResultSet rs1 = st2.executeQuery(consulta);
            while(rs1.next())
            {
                Assignment a = new Assignment();
                a.setDescription(rs1.getString("description"));
                a.setName(rs1.getString("name"));
                String[] id = new String[1];
                id[0]=""+rs1.getInt("id");
                a.setStart(rs1.getString("start"));
                a.setFinish(rs1.getString("finish"));
                a.setId(id);
               
                assignments.add(a);   
            }
            consulta ="select id,name from criteria_catg where catg_id ="+catgid[0];
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
                consulta ="select symbol from student_grades where student_id = " +s.getId_students()+"and assignmentid = "+id[0]+" and criteria_id = "+id2[0];
            ResultSet rs3 = st2.executeQuery(consulta);
            while(rs3.next())
            {
                grades[studentcount][assignmentcount][criteriacount]= ""+rs3.getString("symbol");
                        
            }
                 criteriacount = criteriacount+1;  
                 }
                assignmentcount = assignmentcount +1;
                }
                studentcount = studentcount +1;
            } }catch (SQLException ex) {
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
        }
        // assuming the criteria are the same for all assignements under the same category
         mv.addObject("students",students);
         mv.addObject("criterias", criterias);
          mv.addObject("assignments", assignments);
           mv.addObject("grades", grades);
         
        return mv;
        
    }
    @RequestMapping("/assignments/saveRecords.htm")
 public ModelAndView saveRecords(@RequestBody Grade[] grades, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
   ModelAndView mv = new ModelAndView("assignments");
   String message = null;
   try {
        HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
            
              for(Grade g:grades)
              {
                  String consulta = "SELECT type_id FROM criteria_catg where id = "+g.getIdCrit();
            ResultSet rs = st.executeQuery(consulta);
            String typeid = null;
            while(rs.next())
            {
            typeid =""+rs.getInt("type_id");
            }
                consulta ="select id from student_grades where student_id = "+g.getIdStudent()+" and criteria_id="+g.getIdCrit()+" and assignmentid= "+g.getAssignmentid();
               ResultSet rs1 = st.executeQuery(consulta);
               if(rs1.next()){
                       
                   if(g.getVal()!="" && g.getVal()!= null){//assuming that the grade symbol will be converted in the jsp page to its code
                   String grade = g.getSymbolGrade(typeid,g.getVal(),hsr.getServletContext());
                   consulta ="update student_grades set symbol ="+g.getVal()+",type_id= "+typeid+",grade = "+grade+" where student_id ="+g.getIdStudent()+" and criteria_id ="+g.getIdCrit()+" and assignmentid= "+g.getAssignmentid();
               st.executeUpdate(consulta);
               ActivityLog.log(""+user.getId(), g.getIdStudent(), "update grade to be "+g.getVal()+"where criteria_id ="+g.getIdCrit()+" and assignmentid= "+g.getAssignmentid(), cn);
                   }
                  else
                  {
                      consulta ="delete from student_grades where student_id = "+g.getIdStudent()+" and criteria_id="+g.getIdCrit()+"and assignmentid= "+g.getAssignmentid();
               st.executeUpdate(consulta);
               ActivityLog.log(""+user.getId(), g.getIdStudent(), "delete grade where criteria_id ="+g.getIdCrit()+" and assignmentid= "+g.getAssignmentid(), cn);
                  }
                   }
               else{
                  if(g.getVal()!="" && g.getVal()!= null){
                         String grade= g.getSymbolGrade(typeid,g.getVal(),hsr.getServletContext());
                    consulta ="insert into student_grades(symbol,type_id,grade,student_id,criteria_id,assignmentid) values('"+g.getVal()+"','"+typeid+"','"+grade+"','"+g.getIdStudent()+"','"+g.getIdCrit()+"','"+g.getAssignmentid()+"')";
               st.executeUpdate(consulta);
                 ActivityLog.log(""+user.getId(), g.getIdStudent(), "add grade "+g.getVal()+" where criteria_id ="+g.getIdCrit()+" and assignmentid= "+g.getAssignmentid(), cn);
                 }
                  
               }
              }
              message = "Grades successfully updated";
               }catch (SQLException ex) {
           StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
            message = "Something went wrong";
        }
   mv.addObject("message", message);
return mv;   
 }
 @RequestMapping("/assignments/saveAssign.htm")
public ModelAndView saveAssign(@RequestBody Assignment assignment, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
   String message = null;
    ModelAndView mv = new ModelAndView("redirect:/assignments/loadRecords.htm","message", message);
   HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
   try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
          String[] catgid = hsr.getParameterValues("catid");
          String consulta = "insert into assignments(name,description,start,finish,catg_id) values('"+assignment.getName()+"','"+assignment.getDescription()+"','"+assignment.getStart()+"','"+assignment.getFinish()+"','"+catgid[0]+"')";
          st.executeUpdate(consulta);
          ActivityLog.log(""+user.getId(), "add new assignment "+assignment.getName()+" under catg_id ="+catgid[0], cn);
           message = "Assignment successfully saved";
               }catch (SQLException ex) {
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
            message = "Something went wrong";
        }
   mv.addObject("message", message);
return mv;   
}
@RequestMapping("/assignments/editAssign.htm")
public ModelAndView editAssign(@RequestBody Assignment assignment, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
   String message = null;
    ModelAndView mv = new ModelAndView("redirect:/assignments/loadRecords.htm","message", message);
   HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
   try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
          String[] catgid = hsr.getParameterValues("catid");
          String consulta = "update assignments set name = '"+assignment.getName()+"', description = '"+assignment.getDescription()+"',start = '"+assignment.getStart()+"',finish = '"+assignment.getFinish()+"' where id = '"+assignment.getId()+"'";
          st.executeUpdate(consulta);
          ActivityLog.log(""+user.getId(), "update assignment "+assignment.getName()+" under catg_id ="+catgid[0], cn);
           message = "Assignment successfully updated";
               }catch (SQLException ex) {
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
            message = "Something went wrong";
        }
   mv.addObject("message", message);
return mv;   
}
@RequestMapping("/assignments/delAssign.htm")
// ask sergio how to do the delete
public ModelAndView delAssign(@RequestBody Assignment assignment, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
   String message = null;
    ModelAndView mv = new ModelAndView("redirect:/assignments/loadRecords.htm","message", message);
   HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
   try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
          String[] catgid = hsr.getParameterValues("catid");
          String consulta = "delete assignments where id = '"+assignment.getId()+"'";
          st.executeUpdate(consulta);
          ActivityLog.log(""+user.getId(), "delete assignment "+assignment.getName()+" under catg_id ="+catgid[0], cn);
           message = "Assignment successfully delete";
               }catch (SQLException ex) {
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
            message = "Something went wrong";
        }
   mv.addObject("message", message);
return mv;   
}
}
