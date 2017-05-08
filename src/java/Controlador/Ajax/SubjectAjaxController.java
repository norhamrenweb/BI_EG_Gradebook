///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Controlador.Ajax;
//
//import Modelo.Subsection;
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
//public class SubjectAjaxController implements Controller{
//
//    @Override
//    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        ModelAndView mv = new ModelAndView("subjectAjax");
//        int idSubject = Integer.parseInt(request.getParameter("idSubject"));
//        String tag = request.getParameter("etiqSubsection");
//        Subsection subsection = new Subsection(request.getServletContext());
//        
//        String stringSubSection="<option value =\"0\">" + tag + "</option>";
//        ArrayList<Subsection> listSubsec = new ArrayList<>();
//        listSubsec = subsection.getSubsections(idSubject);
//        for (Subsection subsec: listSubsec){
//            stringSubSection += "<option value=\""+ subsec.getId_subsection()+"\" >" + subsec.getNombre_sub_section() + "</option>";
//        }
//        mv.addObject("subjectSelection",stringSubSection);
//        
//        return mv;
//    }
//    
//}
