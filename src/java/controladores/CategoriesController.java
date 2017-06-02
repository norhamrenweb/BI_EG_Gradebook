/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controladores;

import Montessori.*;
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
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;


/**
 *
 * @author nmohamed
 */
@Controller
public class CategoriesController {
    
    
      Connection cn;
      static Logger log = Logger.getLogger(AssignmentsController.class.getName());
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
        String[] classid = hsr.getParameterValues("ClassSelected");
        List<Category> categories = new ArrayList<>();  
        List<Term> terms = new ArrayList<>();
         try {
         DriverManagerDataSource dataSource;     
    // String classid = "474";//hsr.getParameter("classSelected");
     String termid = "3";
     String courseid = "164"; // based on the course setting
//     DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
//Date lessondate = format.parse(hsr.getParameter("seleccion5"));   
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
 // query for retrieving the catgeories names and their weights based on the class id
            Statement st = this.cn.createStatement(); 
            String consulta ="select id,weight,name,description,term_ids from category where id in(select cat_id from catg_class where class_id = "+classid[0]+")";
            ResultSet rs1 = st.executeQuery(consulta);
            while(rs1.next())
            {
                Category cat = new Category();
                cat.setDescription(rs1.getString("description"));
                cat.setName(rs1.getString("name"));
                String[] id = new String[1];
                id[0]=""+rs1.getInt("id");
                cat.setId(id);
                cat.setWeight(rs1.getDouble("weight"));
                cat.setTerm_ids(rs1.getString("term_ids"));
                categories.add(cat);   
            }
            //get the gradingtypes and values
            for(Category c:categories)
            {
                String[] id = new String[1];
                id = c.getId();
                String query = "select name,values from grading_types where id in (select type_id from criteria_catg where catg_id ='"+id[0]+"') ";//must add the criteria as well later, incase a category has more than one criteria
                  ResultSet rs2 = st.executeQuery(query);
                  
            while(rs2.next())
            {
                Gradetype gr = new Gradetype();
                gr.setName(rs2.getString("name"));
                gr.setValues(rs2.getString("values"));
                c.setGradetype(gr);
            }
            }
        // get the term names and ids
        consulta = "select id,name from terms order by id";
        ResultSet rs2 = st.executeQuery(consulta);
         while(rs2.next())
            {
               Term t = new Term();
               t.setId(""+rs2.getInt("id"));
               t.setName(rs2.getString("name"));
               terms.add(t);
            }
         } catch (SQLException ex) {
            StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
        }
        
         mv.addObject("categories", categories);
          mv.addObject("classid", classid[0]);
          mv.addObject("terms",terms);
        return mv;
        
    }
   
    @RequestMapping("/categories/newCategory.htm")
    public ModelAndView newCategory(@RequestBody Category category,HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
      String message = null;
        ModelAndView mv = new ModelAndView("categories");
        String[] classid = hsr.getParameterValues("classid");
           HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
         try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
         Statement st = this.cn.createStatement();
          String[] catgid = hsr.getParameterValues("classid");
          String consulta = "insert into category(name,description,weight,term_ids) values('"+category.getName()+"','"+category.getDescription()+"','"+category.getWeight()+"','";//pass,calc later after delivering to bedaya  
          st.executeUpdate(consulta,Statement.RETURN_GENERATED_KEYS);
        ResultSet rs = st.getGeneratedKeys();
       String catg_id = null;
        while(rs.next())
        {
        catg_id=""+rs.getInt(1);
        }
      
          consulta = "insert into catg_class(cat_id,class_id) values('"+catg_id+"','"+classid[0]+"')";
          st.executeUpdate(consulta);
          Gradetype gr = category.getGradetype();
          consulta = "insert into grading_types(name,values) values('"+gr.getName()+"','"+gr.getValues()+"')";
           st.executeUpdate(consulta,Statement.RETURN_GENERATED_KEYS);
           ResultSet rs1 = st.getGeneratedKeys();
            String type_id = null;
        while(rs1.next())
        {
        type_id=""+rs1.getInt(1);
        }
      
          consulta = "insert into criteria_catg(name,catg_id,type_id) values('criteria','"+catg_id+"','"+type_id+"')";//only for bedaya the category is created by default with 1 criteria with fixed name
          st.executeUpdate(consulta);
          ActivityLog.log(""+user.getId(), "add new category "+category.getName()+" under class_id ="+classid[0], cn);
           message = "Category successfully saved";
                  } catch (SQLException ex) {
           StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
        }
        return mv;
    }
    @RequestMapping("/categories/editCategory.htm")
    public ModelAndView editCategory(@RequestBody Category category,HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
      String message = null;
        ModelAndView mv = new ModelAndView("categories");
        String[] classid = hsr.getParameterValues("classid");
           HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
         try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
         Statement st = this.cn.createStatement();
          String[] catgid = hsr.getParameterValues("classid");
          String consulta = "update category set name = '"+category.getName()+"', description ='"+category.getDescription()+"',weight='"+category.getWeight()+"', decimal ='"+category.getDecimal()+"', term_ids = '"+category.getTerm_ids()+"' where id = '"+category.getId();//pass,calc later after delivering to bedaya 
          st.executeUpdate(consulta);
          //later must put an option for editing the criterias under category
          ActivityLog.log(""+user.getId(), "update category "+category.getName()+" under class_id ="+classid[0], cn);
          Gradetype gr = category.getGradetype();
          // here we need later to put the numeric equivalent of the symbols
          consulta = "update grading_types set name= '"+gr.getName()+"',values = '"+gr.getValues()+"' where id in(select type_id from criteria_catg where catg_id ='"+catgid[0]+"')"; 
          st.executeUpdate(consulta);
          message = "Category successfully saved";
                  } catch (SQLException ex) {
           StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
        }
        return mv;
    }
    
    @RequestMapping("/categories/delCategory.htm")
    public ModelAndView delCategory(@RequestBody Category category,HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
      String message = null;
        ModelAndView mv = new ModelAndView("categories");
        String[] classid = hsr.getParameterValues("classid");
           HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
         try {
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
         Statement st = this.cn.createStatement();
          String[] catgid = hsr.getParameterValues("classid");
          String consulta = "delete from category where id = '"+category.getId(); 
          st.executeUpdate(consulta);
          //later must put an option for editing the criterias under category
          ActivityLog.log(""+user.getId(), "delete category "+category.getName()+" under class_id ="+classid[0], cn);
          
          message = "Category successfully deleted";
          
                  } catch (SQLException ex) {
           StringWriter errors = new StringWriter();
            ex.printStackTrace(new PrintWriter(errors));
            log.error(ex+errors.toString());
            message = "Something went wrong";
        }
         mv.addObject("message",message);
        return mv;
    }
}
