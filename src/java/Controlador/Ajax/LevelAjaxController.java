///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Controlador.Ajax;
//
//import Modelo.Subjects;
//import java.util.ArrayList;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.Controller;
//
///**
// *
// * @author Jesus
// */
//public class LevelAjaxController implements Controller{
//
//    @Override
//    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        ModelAndView mv = new ModelAndView("levelAjax");       
//        int idLevel = Integer.parseInt(request.getParameter("idLevel")); 
//        String tag = request.getParameter("etiqSubject");
//
//        Subjects sub = new Subjects(request.getServletContext());
//        
//        
//        String stringSubject="<option value =\"0\">" + tag + "</option>";
//        ArrayList<Subjects> listSub = new ArrayList<>();
//        listSub = sub.getSubjects(idLevel);
//        for (Subjects subject: listSub){
//            stringSubject += "<option value=\""+ subject.getId()+"\" >" + subject.getNombre() + "</option>";
//        }
//        mv.addObject("levelSelection",stringSubject);
//        
//        return mv;
//    }
//    
//}
