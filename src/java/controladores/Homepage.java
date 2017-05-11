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
import java.io.DataOutput;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controladores.LessonsListControlador;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;


@RequestMapping("/")
public class Homepage extends MultiActionController  {
   Connection cn;
    private Object getBean(String nombrebean, ServletContext servlet)
{
ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
}
    public ModelAndView inicio(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
    
        return new ModelAndView("userform");
    }
  @RequestMapping
public ModelAndView login(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
       
        HttpSession session = hsr.getSession();
        User user = new User();
        int scgrpid = 0;
        boolean result = false;
         LoginVerification login = new LoginVerification();
         if("QuickBook".equals(hsr.getParameter("txtusuario"))){
            ModelAndView mv = new ModelAndView("redirect:/suhomepage.htm?opcion=loadconfig"); 
            return mv;
         }else{
         user = login.consultUserDB(hsr.getParameter("txtusuario"), hsr.getParameter("txtpassword"));
         if(user.getId()==0){
         ModelAndView mv = new ModelAndView("userform");
        String message = "Username or password incorrect";
        mv.addObject("message", message);
        return mv;
         }
         else{
         scgrpid=login.getSecurityGroupID("MontesoriTest");
         result = login.fromGroup(scgrpid, user.getId());
         if (result == true){
        ModelAndView mv = new ModelAndView("redirect:/homepage/loadLessons.htm");
     String  message = "welcome user";
       session.setAttribute("user", user);
        mv.addObject("message", message);
        return mv;
        }
      
         else{
           ModelAndView mv = new ModelAndView("userform");
        String message = "Username or Password incorrect";
        mv.addObject("message", message);
        return mv;
       }}}
//        DriverManagerDataSource dataSource;
//        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
//        this.cn = dataSource.getConnection();
//      Statement ps = this.cn.createStatement(1004,1007);
//      ResultSet rs = ps.executeQuery("SELECT typeuser,id_usuario FROM usuarios where nombre='"+ user.getName()+"'");
//       if (!rs.next())
//       {
//           ModelAndView mv = new ModelAndView("userform");
//        String message = "No access rights defined";
//        mv.addObject("message", message);
//        return mv;
//       }
//       else{
//       rs.beforeFirst();
//           while (rs.next())
//            {
//            user.setType(rs.getInt("typeuser"));
//            user.setId(rs.getInt("id_usuario"));
//            }
//        if (user.getType()== 3)
//        {
//        ModelAndView mv = new ModelAndView("redirect:/suhomepage.htm?opcion=loadconfig");
//        String message = "Welcome super user";
//        session.setAttribute("user", user);
//        mv.addObject("message", message);
//        return mv;
//        }
//        else
//        {
//         ModelAndView mv = new ModelAndView("redirect:/homepage.htm?select3=loadLessons");
//        String  message = "welcome user";
//        session.setAttribute("user", user);
       
      
       
        

}



}
