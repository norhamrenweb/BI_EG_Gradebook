/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

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
public class ParentPageController {
  
     Connection cn;
      static Logger log = Logger.getLogger(AssignmentsController.class.getName());
      private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
       @RequestMapping("/parentpage/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        ModelAndView mv = new ModelAndView("parentpage");
    HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSourceAH",hsr.getServletContext());
        this.cn = dataSource.getConnection();
          Statement st = this.cn.createStatement();
          String query ="SELECT s.FirstName,s.LastName,s.GradeLevel,f.ParentID,ps.StudentID FROM Students as s inner join Parent_Student as ps on ps.StudentID = s.StudentID inner join Family as f on f.ParentID = ps.ParentID where f.PersonID = '"+user.getId()+"'";
         ResultSet rs = st.executeQuery(query);
         ArrayList<Students> children = new ArrayList<>();
        while(rs.next()){
            Students child = new Students();
            child.setId_students(rs.getInt("StudentID"));
            child.setLevel_id(rs.getString("GradeLevel"));
            child.setNombre_students(rs.getString("FirstName")+" "+rs.getString("LastName"));
            children.add(child);
        }
    mv.addObject("children",children);
        return mv;
    }
}
