/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.orders;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import table.dishes.DishesDTO;
import table.ingredients.IngredientDTO;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class OrderDAO {

    public OrderDAO() {
    }

    public int insertOrder(String accountId, String fullName, String phone,
            BigDecimal totalPrice, String shipAddress, String shipCity,
            String shipDistrict) throws SQLException {
        int accId = Integer.parseInt(accountId);
        int orderId = -1;
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Orders"
                        + "(account_id, full_name, phone, ship_address, ship_city, "
                        + "ship_district, total_price) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = cn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setInt(1, accId);
                ps.setString(2, fullName);
                ps.setString(3, phone);
                ps.setString(4, shipAddress);
                ps.setString(5, shipCity);
                ps.setString(6, shipDistrict);
                ps.setBigDecimal(7, totalPrice);
                int row = ps.executeUpdate();
                if (row > 0) {
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            orderId = generatedKeys.getInt(1);
                        } else {
                            throw new SQLException("Creating order failed, no ID obtained.");
                        }
                    }
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
        return orderId;
    }

    public void addIngredientToOrder(int orderId, HashMap<IngredientDTO, Integer> listIngredient)
            throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Order_Ingredients"
                        + "(order_id, ingredient_id, quantity, price_per_unit) "
                        + "VALUES (?, ?, ?, ?)";

                ps = cn.prepareStatement(sql);
                cn.setAutoCommit(false);
                if (listIngredient != null && !listIngredient.isEmpty()) {
                    for (IngredientDTO ingredientDTO : listIngredient.keySet()) {
                        ps.setInt(1, orderId);
                        ps.setInt(2, ingredientDTO.getId());
                        ps.setInt(3, listIngredient.get(ingredientDTO));
                        ps.setBigDecimal(4, ingredientDTO.getPrice());
                        ps.addBatch();
                    }
                }
                ps.executeBatch();

                cn.commit();
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }

    public void addDishToOrder(int orderId, HashMap<DishesDTO, Integer> listDish)
            throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Order_Dishes"
                        + "(order_id, dish_id, quantity, price_per_unit) "
                        + "VALUES (?, ?, ?, ?)";

                ps = cn.prepareStatement(sql);
                cn.setAutoCommit(false);
                if (listDish != null && !listDish.isEmpty()) {
                    for (DishesDTO dish : listDish.keySet()) {
                        ps.setInt(1, orderId);
                        ps.setInt(2, dish.getId());
                        ps.setInt(3, listDish.get(dish));
                        ps.setBigDecimal(4, dish.getPrice());
                        ps.executeUpdate();
                    }
                }

                cn.commit();
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }

    private List<OrderDTO> listOrder;

    public List<OrderDTO> getListOrder() {
        return listOrder;
    }

    public void getAllOrder(int account_id) throws SQLException {
        
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        OrderDTO orderDTO;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT [id], [full_name], [phone], [order_date], "
                        + "[ship_date], [ship_address], [ship_city], "
                        + "[ship_district], [total_price], [status] "
                        + "FROM Orders WHERE account_id = ? ORDER BY [id] DESC";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, account_id);
                rs = ps.executeQuery();
                while (rs.next()) {
                    orderDTO = new OrderDTO();
                    orderDTO.setId(rs.getInt("id"));
                    orderDTO.setAccountId(account_id);
                    orderDTO.setFullname(rs.getString("full_name"));
                    orderDTO.setPhone(rs.getString("phone"));
                    orderDTO.setOrderDate(rs.getDate("order_date"));
                    orderDTO.setShipDate(rs.getDate("ship_date"));
                    orderDTO.setAddress(rs.getString("ship_address"));
                    orderDTO.setCity(rs.getString("ship_city"));
                    orderDTO.setDistrict(rs.getString("ship_district"));
                    orderDTO.setTotalPrice(rs.getBigDecimal("total_price"));
                    orderDTO.setStatus(rs.getInt("status"));
                    
                    if (listOrder == null) {
                        listOrder = new ArrayList<>();
                    }
                    listOrder.add(orderDTO);
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }

    public void getIngredientsOfOrders() throws SQLException {
        if (this.listOrder == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        IngredientDTO ingredient;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT i.*, oi.quantity, oi.price_per_unit FROM "
                        + "Order_Ingredients oi INNER JOIN Ingredients i "
                        + "ON oi.ingredient_id = i.id WHERE oi.order_id = ?";
                ps = cn.prepareStatement(sql);
                for (OrderDTO orderDTO : listOrder) {
                    ps.setInt(1, orderDTO.getId());
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String unit = rs.getString("unit");
                        BigDecimal price = rs.getBigDecimal("price_per_unit");
                        int quantity = rs.getInt("quantity");
                        String image = rs.getString("image");
                        int categoryId = rs.getInt("category_id");
                        ingredient = new IngredientDTO(id, name, categoryId, price, unit, image);
                        if (orderDTO.getListIngredient() == null) {
                            orderDTO.setListIngredient(new HashMap<>());
                        }
                        orderDTO.getListIngredient().put(ingredient, quantity);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }

    }

    public void getDishesOfOrders() throws SQLException {
        if (this.listOrder == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        DishesDTO dish = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                for (OrderDTO orderDTO : listOrder) {
                    String sql = "SELECT d.*, od.quantity, od.price_per_unit "
                            + "FROM Order_Dishes od INNER JOIN Dishes d "
                            + "ON od.dish_id = d.id WHERE od.order_id = ?";
                    ps = cn.prepareStatement(sql);
                    ps.setInt(1, orderDTO.getId());
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        BigDecimal price = rs.getBigDecimal("price_per_unit");
                        int quantity = rs.getInt("quantity");
                        String image = rs.getString("image");
                        int categoryId = rs.getInt("category_id");
                        dish = new DishesDTO(id, name, categoryId, price, image,null);
                        if (orderDTO.getListDish() == null) {
                            orderDTO.setListDish(new HashMap<>());
                        }
                        orderDTO.getListDish().put(dish, quantity);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }

    public boolean changeOrderStatus(int orderId, int status) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Orders SET status = ? WHERE id = ?"; 
                ps = cn.prepareStatement(sql);
                ps.setInt(1, status);
                ps.setInt(2, orderId);
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

    public void getOrderByBatch(BatchDTO batchDTO, String status, String phone, String date) throws SQLException {
        if (batchDTO == null) {
            return;
        }
        if (status != null) {
            if (status.equals("-1")) {
                status = null;
            }
        }
        String city = batchDTO.getCity();
        String district = batchDTO.getDistrict();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        OrderDTO orderDTO = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [full_name], [phone], [order_date], [ship_date], \n"
                        + "[ship_address], [ship_city], [ship_district], [total_price], [status]\n"
                        + "from [dbo].[Orders] where [ship_city] = ? and [ship_district] = ?";

                if (status != null) {
                    sql += " and status = " + status;
                }
                if (phone != null) {
                    sql += " and phone like '%" + phone + "%'";
                }
                if (date != null) {
                    try {
                        DateTimeFormatter originalFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                        DateTimeFormatter targetFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        LocalDate format_date = LocalDate.parse(date, originalFormatter);
                        String formattedDate = format_date.format(targetFormatter);
                        sql += " and order_date = '" + formattedDate + "'";
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                ps = cn.prepareStatement(sql);
                ps.setString(1, city);
                ps.setString(2, district);
                rs = ps.executeQuery();
                while (rs.next()) {
                    orderDTO = new OrderDTO();
                    orderDTO.setId(rs.getInt("id"));
                    orderDTO.setFullname(rs.getString("full_name"));
                    orderDTO.setPhone(rs.getString("phone"));
                    orderDTO.setOrderDate(rs.getDate("order_date"));
                    orderDTO.setShipDate(rs.getDate("ship_date"));
                    orderDTO.setAddress(rs.getString("ship_address"));
                    orderDTO.setCity(rs.getString("ship_city"));
                    orderDTO.setDistrict(rs.getString("ship_district"));
                    orderDTO.setTotalPrice(rs.getBigDecimal("total_price"));
                    orderDTO.setStatus(rs.getInt("status"));
                    getDishesOfOrders(orderDTO);
                    getIngredientsOfOrders(orderDTO);
                    if (batchDTO.getListOrder() == null) {
                        batchDTO.setListOrder(new ArrayList());
                    }
                    batchDTO.getListOrder().add(orderDTO);
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }

    public void getIngredientsOfOrders(OrderDTO orderDTO) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        IngredientDTO ingredient;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT i.*, oi.quantity, oi.price_per_unit FROM "
                        + "Order_Ingredients oi INNER JOIN Ingredients i "
                        + "ON oi.ingredient_id = i.id WHERE oi.order_id = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, orderDTO.getId());
                rs = ps.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String unit = rs.getString("unit");
                    BigDecimal price = rs.getBigDecimal("price_per_unit");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    int categoryId = rs.getInt("category_id");
                    ingredient = new IngredientDTO(id, name, categoryId, price, unit, image);
                    if (orderDTO.getListIngredient() == null) {
                        orderDTO.setListIngredient(new HashMap<>());
                    }
                    orderDTO.getListIngredient().put(ingredient, quantity);
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }

    public void getDishesOfOrders(OrderDTO orderDTO) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        DishesDTO dish = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT d.*, od.quantity, od.price_per_unit "
                        + "FROM Order_Dishes od INNER JOIN Dishes d "
                        + "ON od.dish_id = d.id WHERE od.order_id = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, orderDTO.getId());
                rs = ps.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price_per_unit");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    int categoryId = rs.getInt("category_id");
                    dish = new DishesDTO(id, name, categoryId, price, image, null);
                    if (orderDTO.getListDish() == null) {
                        orderDTO.setListDish(new HashMap<>());
                    }
                    orderDTO.getListDish().put(dish, quantity);
                }
            }
        } catch (ClassNotFoundException | SQLException | NamingException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }
}
