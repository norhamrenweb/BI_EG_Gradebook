/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Montessori;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author nmohamed
 */
public class Gradetype {
    private String name;//numeric or letters
    private String values;//comma separated

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValues() {
        return values;
    }

    public void setValues(String values) {
        this.values = values;
    }

    public List<String> fetchValues(int typeid,Connection cn) throws SQLException {
        List<String> values = null;
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select values from grading_types where id = "+typeid);
        while(rs.next())
        {
            String x = rs.getString("values");
            values=Arrays.asList(x.split("\\s*,\\s*"));
        }
       return values;
    }
    
}
