/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.dishes;

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
import product.Product;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class DishesDAO {

    private List<DishesDTO> list;

    public DishesDAO() {
    }

    public List<DishesDTO> getList() {
        return list;
    }

    public int getTotalDish() throws SQLException {
        Connection cn = null;
        Statement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select count (*) from Dishes where [status] = 1";
            stm = cn.createStatement();
            rs = stm.executeQuery(sql);
            while (rs.next()) {
                return rs.getInt(1);
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

    public int getTotalDish(int categoryId) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select count (*) from Dishes where [category_id] = ? and [status] = 1";
            stm = cn.prepareStatement(sql);
            stm.setInt(1, categoryId);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
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

    public void getDishesByCategoryId(int categoryId, int index) throws NamingException, SQLException, ClassNotFoundException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DishesDTO dish;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [price], [image] "
                        + "from [dbo].[Dishes] "
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
                    BigDecimal price = rs.getBigDecimal("price");
                    String image = rs.getString("image");
                    dish = new DishesDTO(id, name, categoryId, price, image,null);
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(dish);
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

    public DishesDTO getDishById(int id) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DishesDTO dish = null;
        try {
            cn = DBUtil.makeConnection();
            String sql = "Select id, name, price, category_id, image "
                    + "from Dishes where [id] = ? and [status] = 1";
            stm = cn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {

                String name = rs.getString("name");
                BigDecimal price = rs.getBigDecimal("price");
                String image = rs.getString("image");
                int categoryId = rs.getInt("category_id");
                dish = new DishesDTO(id, name, categoryId, price, image, null);
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
        return dish;
    }

    public int countOrderOfProduct(DishesDTO dish) throws SQLException {
        if (dish == null) {
            return 0;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int id = dish.getId();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Select COALESCE(SUM(quantity), 0) "
                        + "From Order_Dishes Where dish_id = ?";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
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

    public void getRecipeOfDish(DishesDTO dish) throws SQLException {
        if (dish == null) {
            System.out.println("NULL DISH");
            return;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int id = dish.getId();
        HashMap<String, String> recipe = dish.getRecipe();
        if (recipe == null) {
            recipe = new HashMap<>();
        }
        try {
            System.out.println("mở connection");
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select i.name as name, r.ingredient_quantity as quantity "
                        + "from Recipe_Ingredients r JOIN Ingredients i "
                        + "ON i.id = r.ingredient_id Where r.dish_id = ?";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("name");
                    String quantity = rs.getString("quantity");
                    recipe.put(name, quantity);
                }
                System.out.println("hết vòng lặp");
                dish.setRecipe(recipe);
                System.out.println("Set xong công thức");
            }
            
        } catch (ClassNotFoundException | SQLException | NamingException e) {
        } finally {
            if (rs != null) {
                System.out.println("đóng");
                rs.close();
            }
            if (stm != null) {
                System.out.println("đóng");
                stm.close();
            }
            if (cn != null) {
                System.out.println("đóng");
                cn.close();
            }
        }
    }

    public void getAllDishes (int index) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DishesDTO dish;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [category_id], [price], [image] "
                        + "from [dbo].[Dishes] "
                        + "where [status] = 1 "
                        + "Order By id "
                        + "OFFSET ? ROWS FETCH NEXT 20 ROWS ONLY";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 20);

                rs = stm.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    String image = rs.getString("image");
                    int categoryId = rs.getInt("category_id");
                    dish = new DishesDTO(id, name, categoryId, price, image,null);
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(dish);
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
    
    public List<DishesDTO> searchDish(String searchCategoryId, String searchName, int index) throws SQLException {
        if (searchCategoryId != null && searchCategoryId.equals("-1")) {
            searchCategoryId = null;
        }
        if (searchCategoryId == "") {
            searchCategoryId = null;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<DishesDTO> list = new ArrayList();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [price], [category_id], [status], [image] "
                        + "from [dbo].[Dishes] ";
                if (searchCategoryId != null && searchName != null) {
                    sql += " where [category_id] = '" + searchCategoryId + "' and [name] like N'%" + searchName + "%'";
                } else if (searchCategoryId != null && searchName == null) {
                    sql += " where [category_id] = '" + searchCategoryId + "'";
                } else if (searchCategoryId == null && searchName != null) {
                    sql += " where [name] like N'%" + searchName + "%'";
                }
                sql += " Order By id "
                        + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 10);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    int categoryId = rs.getInt("category_id");
                    String image = rs.getString("image");
                    boolean status = rs.getBoolean("status");
                    DishesDTO dish = new DishesDTO(id, name, categoryId, price, image, status, null);
                    getRecipeOfDish(dish);
                    list.add(dish);
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

    public void updateDishStatus(int dishId, boolean newStatus) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DishesDTO dish = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "update [dbo].[Dishes]\n"
                        + "set [status] = ? where [id] = ?";

                stm = cn.prepareStatement(sql);
                stm.setBoolean(1, newStatus);
                stm.setInt(2, dishId);
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

    public int getTotalOfDish(String searchCategoryId, String searchName, int index) throws SQLException {
        if (searchCategoryId != null && searchCategoryId.equals("-1")) {
            searchCategoryId = null;
        }
        if (searchCategoryId == "") {
            searchCategoryId = null;
        }
        Connection cn = null;
        Statement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select count (*) from Dishes";
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
}
