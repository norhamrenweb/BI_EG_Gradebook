///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Controlador.Ajax;
//
//import Modelo.Equipment;
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
//public class SubsectionAjaxController implements Controller{
//
//    @Override
//    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        ModelAndView mv = new ModelAndView("subsectionAjax");
//        int idSubject = Integer.parseInt(request.getParameter("idSubsec"));
//        String tag = request.getParameter("etiqEquipment");
//        Subsection subsection = new Subsection(request.getServletContext());
//        Equipment equipment = new Equipment(request.getServletContext());
//        
//        String stringEquipment="";
//        ArrayList<Equipment> listEquip = new ArrayList<>();
//        listEquip = equipment.getMaterialsFromSubsection(idSubject);
//        if(listEquip.isEmpty())stringEquipment="<option value =\"0\" selected>" + tag + "</option>";
//        else {
//            for (Equipment equip: listEquip){
//                stringEquipment += "<option value=\""+ equip.getId_activity_equipment() +"\" >" + equip.getNombre_activity_equipment() + "</option>";
//            }
//        }
//        mv.addObject("subsectionSelection",stringEquipment);
//        
//        return mv;
//        
//    }
//    
//}
