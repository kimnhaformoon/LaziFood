/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package table.accounts;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import utils.DBUtil;

/**
 *
 * @author long
 */
public class AccountDAO implements Serializable {
    
    public ArrayList<AccountDTO> getAccountsByName(String searchValue) throws SQLException {
        ArrayList<AccountDTO> list = new ArrayList();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [username], [full_name], [phone], [email], [address], \n"
                        + "[city], [district], [role], [status]\n"
                        + "from [dbo].[Accounts] where [full_name] like ?";
                ps = cn.prepareStatement(sql);
                ps.setString(1, "%" + searchValue + "%");
                rs = ps.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String username = rs.getString("username");
                        String fullname = rs.getString("full_name");
                        String phone = rs.getString("phone");
                        String email = rs.getString("email");
                        String address = rs.getString("address");
                        String city = rs.getString("city");
                        String district = rs.getString("district");
                        boolean role = rs.getBoolean("role");
                        boolean status = rs.getBoolean("status");
                        AccountDTO a = new AccountDTO();
                        a.setId(id);
                        a.setUsername(username);
                        a.setFullname(fullname);
                        a.setPhone(phone);
                        a.setEmail(email);
                        a.setAddress(address);
                        a.setCity(city);
                        a.setDistrict(district);
                        a.setRole(role);
                        a.setStatus(status);
                        list.add(a);
                    }
                }
            }
        } catch (Exception e) {
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
        return list;
    }
    
    public ArrayList<AccountDTO> getAllAccounts() throws SQLException {
        ArrayList<AccountDTO> list = new ArrayList();
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "select [id], [username], [full_name], [phone], [email], [address], \n"
                        + "[city], [district], [role], [status] \n"
                        + "from [dbo].[Accounts]";
                st = cn.createStatement();
                rs = st.executeQuery(sql);
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String username = rs.getString("username");
                        String fullname = rs.getString("full_name");
                        String phone = rs.getString("phone");
                        String email = rs.getString("email");
                        String address = rs.getString("address");
                        String city = rs.getString("city");
                        String district = rs.getString("district");
                        boolean role = rs.getBoolean("role");
                        boolean status = rs.getBoolean("status");
                        AccountDTO a = new AccountDTO();
                        a.setUsername(username);
                        a.setFullname(fullname);
                        a.setPhone(phone);
                        a.setEmail(email);
                        a.setAddress(address);
                        a.setCity(city);
                        a.setDistrict(district);
                        a.setRole(role);
                        a.setStatus(status);
                        list.add(a);
                    }
                }
            }
        } catch (Exception e) {
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

    public AccountDTO getAccountByUsernamePassword(String username, String password) throws SQLException {
        Connection cn = null;
        AccountDTO acc = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Select [id], [username], [full_name], [phone], [email], "
                        + "[address], [city], [district], [role], [status] "
                        + "from Accounts where [username] = ? and [password] = ? COLLATE SQL_Latin1_General_CP1_CS_AS";
                ps = cn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();
                if (rs.next()) { 
                    int id = rs.getInt("id");
                    String fullname = rs.getString("full_name");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String city = rs.getString("city");
                    String district = rs.getString("district");
                    boolean role = rs.getBoolean("role");
                    boolean status = rs.getBoolean("status");
                    acc = new AccountDTO(id, username, fullname, phone, email, address, city, district, role, status);
                }
            }
        } catch (Exception e) {
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
        return acc;
    }

    public boolean
            insertAccount(String userName, String passWord, String fullName, String email, String phone) throws SQLException {
        Connection cn = null;
        PreparedStatement stm = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Insert into [dbo].[Accounts]([username], "
                        + "[password], [full_name], [phone], [email]) "
                        + "Values(?, ?, ?, ?, ?)";
                stm = cn.prepareStatement(sql);
                stm.setString(1, userName);
                stm.setString(2, passWord);
                stm.setString(3, fullName);
                stm.setString(4, phone);
                stm.setString(5, email);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return false;
    }
    
            
        public boolean checkExistAccount(String username) throws SQLException {
        Connection cn = null;
        AccountDTO acc = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "Select [id] "
                        + "from Accounts where [username] = ?";
                ps = cn.prepareStatement(sql);
                ps.setString(1, username);
                rs = ps.executeQuery();
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
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
        return false;
    }
     
    public void updateRoleAccount(int accId, boolean newRole) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "update [dbo].[Accounts] \n"
                        + "set [role] = ?\n"
                        + "where [id] = ?";
                ps = cn.prepareStatement(sql);
                ps.setBoolean(1, newRole);
                ps.setInt(2, accId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }
    
    public void updateStatusAccount(String username, boolean newStatus) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = DBUtil.makeConnection();
            if (cn != null) {
                String sql = "update [dbo].[Accounts] \n"
                        + "set [status] = ?\n"
                        + "where [username] = ?";
                ps = cn.prepareStatement(sql);
                ps.setBoolean(1, newStatus);
                ps.setString(2, username);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
    }
}
