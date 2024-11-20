/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.dishcategories;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class DishCategoriesDAO {
    private List<DishCategoriesDTO> listDTO;

    public DishCategoriesDAO() {
    }

    

    public List<DishCategoriesDTO> getListDTO() {
        return listDTO;
    }
    
 
    public void getAllMenuCategories () throws SQLException {
        Connection cn = null;
        Statement stm = null ;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Select [id], [name] from Dish_Categories";
                stm = cn.createStatement();
                rs = stm.executeQuery(sql);
                
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    DishCategoriesDTO dto = new DishCategoriesDTO(id, name);
                    if(listDTO == null) {
                        listDTO = new ArrayList<>();
                    }
                    listDTO.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (cn != null) {
                cn.close();
            }  
    }
}
}
