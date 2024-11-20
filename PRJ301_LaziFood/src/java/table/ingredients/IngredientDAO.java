/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.ingredients;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import product.Product;
import table.dishes.DishesDTO;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class IngredientDAO implements Serializable {

    private List<IngredientDTO> list;

    public IngredientDAO() {
    }

    public List<IngredientDTO> getList() {
        return list;
    }

    public int getTotalIngredient() {
        Connection cn = null;
        Statement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select count (*) from Ingredients where [status] = 1";
            stm = cn.createStatement();
            rs = stm.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getTotalIngredient(int categoryId) {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            cn = DBUtil.makeConnection();
            String sql = "Select count (id) as countcol "
                    + "from Ingredients where [category_id] = ? and [status] = 1";
            stm = cn.prepareStatement(sql);
            stm.setInt(1, categoryId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("countcol");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public void getIngredientsByCategoryId(int categoryId, int index)
            throws NamingException, SQLException, ClassNotFoundException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        IngredientDTO ingredient = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [unit], [price], [image] "
                        + "from [dbo].[Ingredients] "
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
                    String unit = rs.getString("unit");
                    BigDecimal price = rs.getBigDecimal("price");
                    String image = rs.getString("image");
                    ingredient = new IngredientDTO(id, name, categoryId, price, unit, image);
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(ingredient);
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

    public IngredientDTO getIngredientById(int id) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        IngredientDTO ingredient = null;
        try {
            cn = DBUtil.makeConnection();
            String sql = "Select id, name, unit, price, category_id, image "
                    + "from Ingredients where [id] = ? and [status] = 1";
            stm = cn.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {

                String name = rs.getString("name");
                BigDecimal price = rs.getBigDecimal("price");
                String image = rs.getString("image");
                String unit = rs.getString("unit");

                int categoryId = rs.getInt("category_id");
                ingredient = new IngredientDTO(id, name, categoryId, price, unit, image);
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
        return ingredient;
    }

    public void getRelatedProduct(IngredientDTO ingredient) throws SQLException {
        if (ingredient == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int categoryId = ingredient.getCategory_id();
        int id = ingredient.getId();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select top 4 [id], [name], [unit], [price], [image] "
                        + "from [dbo].[Ingredients] "
                        + "where [category_id] = ? and [status] = 1 and id != ? "
                        + "Order By id DESC";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, categoryId);
                stm.setInt(2, id);
                rs = stm.executeQuery();

                while (rs.next()) {
                    int pId = rs.getInt("id");
                    String name = rs.getString("name");
                    String unit = rs.getString("unit");
                    BigDecimal price = rs.getBigDecimal("price");
                    String image = rs.getString("image");
                    ingredient = new IngredientDTO(pId, name, categoryId, price, unit, image);
                    if (list == null) {
                        list = new ArrayList<>();
                    }
                    list.add(ingredient);
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

    public int countOrderOfProduct(IngredientDTO ingredient) throws SQLException {
        if (ingredient == null) {
            return 0;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int id = ingredient.getId();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Select COALESCE(SUM(quantity), 0) "
                        + "From Order_Ingredients Where [ingredient_id] = ?";
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

    public void getIngredientsOfDish(DishesDTO dish) throws SQLException {
        if (dish == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        IngredientDTO ingredient;
        int id = dish.getId();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Select [ingredient_id] "
                        + "from  [dbo].[Recipe_Ingredients] "
                        + "where dish_id = ?";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                int ingredientId;
                StringBuilder sqlBuilder = new StringBuilder("Select * "
                        + "from Ingredients WHERE id IN (");
                boolean isFirst = true;
                while (rs.next()) {
                    if (!isFirst) {
                        sqlBuilder.append(", ");
                    }
                    ingredientId = rs.getInt("ingredient_id");
                    sqlBuilder.append(ingredientId);
                    isFirst = false;
                }
                sqlBuilder.append(")");
                if (!isFirst) {
                    sql = sqlBuilder.toString();
                    Statement statement = cn.createStatement();
                    rs = statement.executeQuery(sql);
                    while (rs.next()) {
                        int pId = rs.getInt("id");
                        String name = rs.getString("name");
                        String unit = rs.getString("unit");
                        BigDecimal price = rs.getBigDecimal("price");
                        int categoryId = rs.getInt("category_id");
                        String image = rs.getString("image");

                        ingredient = new IngredientDTO(pId, name, categoryId, price, unit, image);
                        if (list == null) {
                            list = new ArrayList<>();
                        }
                        list.add(ingredient);
                    }
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
    
    public int getTotalOfIngre(String searchCategoryId, String searchName, int index) throws SQLException {
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
            String sql = "Select count (*) from Ingredients";
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
    
    public List<IngredientDTO> searchIngre(String searchCategoryId, String searchName, int index) throws SQLException {
        if (searchCategoryId != null && searchCategoryId.equals("-1")) {
            searchCategoryId = null;
        }
        if (searchCategoryId == "") {
            searchCategoryId = null;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<IngredientDTO> list = new ArrayList();
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [name], [unit], [price], [category_id], [status], [image] "
                        + "from [dbo].[Ingredients] ";
                if (searchCategoryId != null && searchName != null) {
                    sql += " where [category_id] = '" + searchCategoryId + "' and [name] like N'%" + searchName + "%'";
                } else if (searchCategoryId != null && searchName == null) {
                    sql += " where [category_id] = '" + searchCategoryId + "'";
                } else if (searchCategoryId == null && searchName != null) {
                    sql += " where [name] like N'%" + searchName + "%'";
                }
                sql += " Order By id "
                        + "OFFSET ? ROWS FETCH NEXT 15 ROWS ONLY";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, (index - 1) * 15);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String unit = rs.getString("unit");
                    BigDecimal price = rs.getBigDecimal("price");
                    int categoryId = rs.getInt("category_id");
                    String image = rs.getString("image");
                    boolean status = rs.getBoolean("status");
                    IngredientDTO ingre = new IngredientDTO(id, name, categoryId, price, unit, image, status);
                    list.add(ingre);
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
    
    public void updateIngreStatus(int ingreId, boolean newStatus) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "update [dbo].[Ingredients]\n"
                        + "set [status] = ? where [id] = ?";

                stm = cn.prepareStatement(sql);
                stm.setBoolean(1, newStatus);
                stm.setInt(2, ingreId);
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
    public int insertIngredient(String name, BigDecimal price, String unit, String image, int categoryId) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        int result = 0;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "insert into [dbo].[Ingredients]([name], [price], [unit], [image], [category_id])\n" +
                            "values(?, ?, ?, ?, ?)";
                stm = cn.prepareStatement(sql);
                stm.setString(1, name);
                stm.setBigDecimal(2, price);
                stm.setString(3, unit);
                stm.setString(4, image);
                stm.setInt(5, categoryId);
                result = stm.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return result;
    }

}
