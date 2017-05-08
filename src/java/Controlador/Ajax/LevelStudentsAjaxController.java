///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Controlador.Ajax;
//
////import Modelo.Asignatura;
//import Montessori.*;
////import Modelo.Subjects;
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
//public class LevelStudentsAjaxController implements Controller{
//
//    @Override
//    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        ModelAndView mv = new ModelAndView("levelStudentsAjax");       
//        int idLevel = Integer.parseInt(request.getParameter("idLevelStudents"));
//        String seleccionados=request.getParameter("TXTalumnosSeleccionados");
//        Students students = new Students();//request.getServletContext());
//        ArrayList<Students> listSeleccionados = students.getParseStudents(seleccionados);
//        
//        String stringStudents="";
//        
//        ArrayList<Students> aux = students.getStudentsForLevel(idLevel);
//        ArrayList<Students> listStudents = new ArrayList<>();
//        for(int i=0; i<aux.size();i++){
//            if(!aux.get(i).removeStudents(listSeleccionados)) listStudents.add(aux.get(i));
//        }
//        for (Students stu: listStudents){
//            stringStudents += "<img src=" + stu.getFoto() + "  class=\"elemento-movil img-circle\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=" + stu.getNombre_students() + " data-id=" + stu.getId_students() + " />";
//        }
//        mv.addObject("levelStudentsSelection",stringStudents);
//        
//        return mv;
//    }
//    
//}
