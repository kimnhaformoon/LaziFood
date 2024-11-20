/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.customerplans;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import table.dishes.DishesDTO;
import table.menu.MenuDAO;
import table.menu.MenuDTO;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class CustomerPlanDAO {

    public CustomerPlanDAO() {
    }

    public CustomerPlanDTO getCustomerPlanById(int id) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        CustomerPlanDTO plan = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT [account_id], [name] "
                        + "FROM Customer_Plan "
                        + "WHERE id = ? AND status = 1";

                stm = cn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int accountId = rs.getInt("account_id");
                    String name = rs.getString("name");
                    plan = new CustomerPlanDTO(id, accountId, name, null);
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
        return plan;
    }

    public List<Integer> getAllCustomerPlanId(int accountId) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List listPlanId = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT id FROM Customer_Plan "
                        + "WHERE account_id = ? AND status = 1"
                        + "ORDER BY id";
                stm = cn.prepareStatement(sql);
                stm.setInt(1, accountId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int planId = rs.getInt("id");
                    if (listPlanId == null) {
                        listPlanId = new ArrayList();
                    }
                    listPlanId.add(planId);
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
        return listPlanId;
    }

    public void getDayPlan(CustomerPlanDTO plan, int day) throws NamingException, SQLException {
        if (plan == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int id = plan.getId();

        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "SELECT cpd.period, d.* "
                        + "FROM Customer_Plan_Details cpd INNER JOIN Dishes d "
                        + "ON cpd.dish_id = d.id "
                        + "WHERE cpd.customer_plan_id = ? AND day_of_week = ?";
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
                    DishesDTO dish = new DishesDTO(dish_id, name, category_id, price, image, null);

                    if (plan.getDetails() == null) {
                        plan.setDetails(new HashMap<>());
                    }

                    HashMap<Integer, List<DishesDTO>> dayPlan = plan.getDetails().get(day);
                    if (dayPlan == null) {
                        dayPlan = new HashMap();
                        plan.getDetails().put(day, dayPlan);
                    }

                    List<DishesDTO> periodPlan = dayPlan.get(period);
                    if (periodPlan == null) {
                        periodPlan = new ArrayList();
                        dayPlan.put(period, periodPlan);
                    }
                    periodPlan.add(dish);
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

    public int createPlan(int account_id, String name) throws SQLException {

        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int planId = -1;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Customer_Plan(account_id, name) VALUES (?,?)";
                ps = cn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setInt(1, account_id);
                ps.setString(2, name);
                int row = ps.executeUpdate();
                if (row > 0) {
                    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            planId = generatedKeys.getInt(1);
                        } else {
                            throw new SQLException("Creating order failed, no ID obtained.");
                        }
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
        return planId;
    }

    public void addMenuToPlan(MenuDTO menu, int planId) throws SQLException {
        if (menu == null) {
            return;
        }
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "INSERT INTO Customer_Plan_Details(customer_plan_id, day_of_week, period, dish_id)"
                        + "VALUES(?,?,?,?)";

                ps = cn.prepareStatement(sql);
                cn.setAutoCommit(false);
                HashMap<Integer, HashMap<Integer, List<DishesDTO>>> details = menu.getDetails();
                if (details != null && !details.isEmpty()) {
                    for (Integer day : details.keySet()) {
                        HashMap<Integer, List<DishesDTO>> dayPlan = details.get(day);
                        if (dayPlan != null && !dayPlan.isEmpty()) {
                            for (Integer period : dayPlan.keySet()) {
                                List<DishesDTO> listDish = dayPlan.get(period);
                                for (DishesDTO dish : listDish) {
                                    ps.setInt(1, planId);
                                    ps.setInt(2, day);
                                    ps.setInt(3, period);
                                    ps.setInt(4, dish.getId());
                                    ps.addBatch();
                                }
                            }
                        }
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

    public boolean disablePlan(int accountId, int planId) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "UPDATE Customer_Plan SET status = 0 "
                        + "WHERE account_id = ? AND id = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, accountId);
                ps.setInt(2, planId);
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

    public boolean deleteDishFromPlan(int dishId, int planId, int period, int day) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "DELETE FROM Customer_Plan_Details "
                        + "WHERE customer_plan_id = ? AND day_of_week = ? AND period = ? AND dish_id = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, planId);
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

    public boolean addDishToPlan(int planId, int day, int period, int dishId) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int rs = 0;
        try {
            cn = DBUtil.makeConnection();
            
            if (cn != null) {
                String sql = "INSERT INTO Customer_Plan_Details(customer_plan_id, day_of_week, period, dish_id)"
                        + "VALUES(?,?,?,?)";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, planId);
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

    public static void main(String[] args) throws SQLException, NamingException {
        CustomerPlanDAO dao = new CustomerPlanDAO();
        boolean check = dao.addDishToPlan(21, 2, 1, 1);
        System.out.println(check);
    }

}
