/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.menu;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import table.dishes.DishesDTO;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class MenuDAO implements Serializable {

    private List<MenuDTO> list;

    public MenuDAO() {
    }

    public List<MenuDTO> getList() {
        return list;
    }

    public int getTotalMenu(int categoryId, String name) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select count (*) from Menu where [status] = 1";
            if (name != null && !name.equals("")) {
                sql = sql + " and name = " + name;
            }
            if (categoryId != 0) {
                sql = sql + " and category_id = " + categoryId;
            }
            stm = cn.prepareStatement(sql);
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
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
        return 0;
    }

    public int getTotalMenu(int categoryId) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select * from Menu where [category_id] = ? and [status] = 1";
            stm = cn.prepareStatement(sql);
            stm.setInt(1, categoryId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
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
        return 0;
    }

    public void getMenuByCategoryId(int categoryId, int index) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MenuDTO menu;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [image], [description] "
                        + "from [dbo].[Menu] "
                        + "where [category_id] = ? and [status] = 1 "
                        + "Order By id "
                        + "OFFSET ? ROWS FETCH NEXT 20 ROWS ONLY";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, categoryId);
                stm.setInt(2, (index - 1) * 20);
                rs = stm.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    menu = new MenuDTO(id, name, categoryId, image, description, null);
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(menu);
                }
            }

        } catch (ClassNotFoundException | SQLException | NamingException e) {
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

    public void SearchMenuByName(String iname, int categoryId, int index) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MenuDTO menu;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [image], [description] "
                        + "from [dbo].[Menu] "
                        + "where [status] = 1";
                if (iname != null && !iname.equals("")) {
                    sql = sql + " and name like N'%" + iname +"%'";
                }
                if (categoryId != 0) {
                    sql = sql + " and category_id = " + categoryId;
                }
                sql = sql + "Order By id OFFSET ? ROWS FETCH NEXT 20 ROWS ONLY";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 20);
                rs = stm.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    menu = new MenuDTO(id, name, categoryId, image, description, null);
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(menu);
                }
            }

        } catch (ClassNotFoundException | SQLException | NamingException e) {
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

    public MenuDTO getMenuById(int id) throws SQLException {
        
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MenuDTO menu = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [category_id], [image], [description] "
                        + "from [Menu] "
                        + "where [id] = ?";

                stm = cn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    int categoryId = rs.getInt("category_id");
                    String description = rs.getString("description");
                    menu = new MenuDTO(id, name, categoryId, image, description, null);
                }
            }
        } catch (Exception e) {
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
        return menu;
    }

    public void getDayMenu(int day, MenuDTO menu) throws SQLException {
        if (menu == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int id = menu.getId();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT md.period, d.* FROM Menu_Details md INNER JOIN "
                        + "Dishes d ON md.dish_id = d.id "
                        + "WHERE menu_id = ? AND day_of_week = ?";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, id);
                stm.setInt(2, day);
                rs = stm.executeQuery();

                while (rs.next()) {
                    int period = rs.getInt("period");
                    int dish_id = rs.getInt("id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    int category_id = rs.getInt("category_id");
                    String image = rs.getString("image");
                    DishesDTO dish = new DishesDTO(dish_id, name, category_id, price, image,null);
                    
                    if (menu.getDetails() == null) {
                        menu.setDetails(new HashMap<>());
                    }
                    
                    HashMap<Integer, List<DishesDTO>> dayMenu =  menu.getDetails().get(day);
                    if (dayMenu == null) {
                        dayMenu = new HashMap();
                        menu.getDetails().put(day, dayMenu);
                    }
                    
                    List<DishesDTO> periodMenu = dayMenu.get(period);
                    if (periodMenu == null) {
                        periodMenu = new ArrayList();
                        dayMenu.put(period, periodMenu);
                    }
                    periodMenu.add(dish);   
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
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
    
    public boolean disableMenu(int menuId) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Menu SET status = 0 "
                        + "WHERE id = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, menuId);
                rs = ps.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }
    public boolean deleteDishFromMenu(int dishId, int menuId, int period, int day) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "DELETE FROM Menu_Details "
                        + "WHERE menu_id = ? AND day_of_week = ? AND period = ? AND dish_id = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, menuId);
                ps.setInt(2, day);
                ps.setInt(3, period);
                ps.setInt(4, dishId);
                rs = ps.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }
    
    public boolean addDishToMenu(int menuId, int day, int period, int dishId) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            cn = DBUtil.makeConnection();
            
            if (cn != null) {
                String sql = "INSERT INTO Menu_Details(menu_id, day_of_week, period, dish_id)"
                        + "VALUES(?,?,?,?)";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, menuId);
                ps.setInt(2, day);
                ps.setInt(3, period);
                ps.setInt(4, dishId);
                rs = ps.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }
    
    public List<MenuDTO> searchMenu(String searchCategoryId, String searchName, int index) throws SQLException {
        if (searchCategoryId != null && searchCategoryId.equals("-1")) {
            searchCategoryId = null;
        }
        if (searchCategoryId == "") {
            searchCategoryId = null;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<MenuDTO> list = new ArrayList();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [category_id], [image], [description], [status] "
                        + "from [dbo].[Menu] ";
                if (searchCategoryId != null && searchName != null) {
                    sql += " where [category_id] = '" + searchCategoryId + "' and [name] like N'%" + searchName + "%'";
                } else if (searchCategoryId != null && searchName == null) {
                    sql += " where [category_id] = '" + searchCategoryId + "'";
                } else if (searchCategoryId == null && searchName != null) {
                    sql += " where [name] like N'%" + searchName + "%'";
                }
                sql += " Order By id "
                        + "OFFSET ? ROWS FETCH NEXT 5 ROWS ONLY";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 5);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    int categoryId = rs.getInt("category_id");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    boolean status = rs.getBoolean("status");
                    MenuDTO menu = new MenuDTO(id, name, categoryId, image, description, status, null);
                    list.add(menu);
                }
            }

        } catch (ClassNotFoundException | SQLException | NamingException e) {
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
        return list;
    }
    
    public int getTotalOfSearchMenu(String searchCategoryId, String searchName, int index) throws SQLException {
        if (searchCategoryId != null && searchCategoryId.equals("-1")) {
            searchCategoryId = null;
        }
        if (searchCategoryId == "") {
            searchCategoryId = null;
        }
        Connection cn = null;
        Statement stm = null;
        ResultSet rs = null;
        List<MenuDTO> list = new ArrayList();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select count(*) from [dbo].[Menu] ";
                if (searchCategoryId != null && searchName != null) {
                    sql += " where [category_id] = '" + searchCategoryId + "' and [name] like N'%" + searchName + "%'";
                } else if (searchCategoryId != null && searchName == null) {
                    sql += " where [category_id] = '" + searchCategoryId + "'";
                } else if (searchCategoryId == null && searchName != null) {
                    sql += " where [name] like N'%" + searchName + "%'";
                }
                stm = cn.createStatement();
                rs = stm.executeQuery(sql);
                while (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (ClassNotFoundException | SQLException | NamingException e) {
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
        return 0;
    }
    
    public void updateMenuStatus(int menuId, boolean newStatus) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "update [dbo].[Menu]\n"
                        + "set [status] = ? where [id] = ?";
                stm = cn.prepareStatement(sql);
                stm.setBoolean(1, newStatus);
                stm.setInt(2, menuId);
                stm.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
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
 
    public static void main(String[] args) throws SQLException {
        MenuDAO menuDao = new MenuDAO();
        List<MenuDTO> list = menuDao.searchMenu("1", "Thực đơn", 1);
        for (MenuDTO menuDTO : list) {
            System.out.println(menuDTO.isStatus());
        }
    }

}
