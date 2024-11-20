/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.orders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import utils.DBUtil;

/**
 *
 * @author Kim Nha
 */
public class BatchDAO {

    public List<BatchDTO> getAllBatch() throws SQLException {
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;
        List<BatchDTO> list = null;
        BatchDTO batchDTO = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [ship_city], [ship_district], count(id) as total_order\n"
                        + "from [dbo].[Orders] group by [ship_city], [ship_district]";
                st = cn.createStatement();
                rs = st.executeQuery(sql);
                if (rs != null) {
                    list = new ArrayList();
                    while (rs.next()) {
                        String city = rs.getString("ship_city");
                        String district = rs.getString("ship_district");
                        int totalOrder = rs.getInt("total_order");
                        batchDTO = new BatchDTO();
                        batchDTO.setCity(city);
                        batchDTO.setDistrict(district);
                        batchDTO.setTotalOrder(totalOrder);
                        list.add(batchDTO);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (st != null) {
                st.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return list;
    }
}
