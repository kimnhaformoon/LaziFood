/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import table.dishes.DishesDAO;
import table.menu.MenuDAO;

/**
 *
 * @author long
 */
public class AddDishToMenuServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String txtDishId = request.getParameter("txtDishId");
            String txtMenuId = request.getParameter("txtMenuId");
            String txtDay = request.getParameter("txtDay");
            String txtPeriod = request.getParameter("txtPeriod");
            if (txtDishId != null && txtMenuId != null && txtDay != null
                    && txtPeriod != null && !txtMenuId.isEmpty()
                    && !txtDay.isEmpty() && !txtPeriod.isEmpty()
                    && !txtDishId.isEmpty()) {
                int menuId = Integer.parseInt(txtMenuId);
                int day = Integer.parseInt(txtDay);
                int period = Integer.parseInt(txtPeriod);
                int dishId = Integer.parseInt(txtDishId);
                MenuDAO menuDao = new MenuDAO();
                menuDao.addDishToMenu(menuId, day, period, dishId);
                request.getRequestDispatcher("ViewMenuDetailServlet").forward(request, response);
            } else {
                if (txtMenuId != null && txtDay != null && txtPeriod != null
                        && !txtMenuId.isEmpty() && !txtDay.isEmpty()
                        && !txtPeriod.isEmpty()) {
                    String txtIndex = request.getParameter("txtIndex");
                    int index;
                    if (txtIndex == null || txtIndex.isEmpty()) {
                        txtIndex = "1";
                    }
                    try {
                        index = Integer.parseInt(txtIndex);
                    } catch (Exception e) {
                        index = 1;
                    }
                    DishesDAO dishDao = new DishesDAO();
                    int count = dishDao.getTotalDish();
                    int pageNum = count / 20;
                    if (count % 20 != 0) {
                        pageNum++;
                    }
                    request.setAttribute("index", index);
                    request.setAttribute("pageNum", pageNum);
                    dishDao.getAllDishes(index);
                    request.setAttribute("LIST_PRODUCT", dishDao.getList());
                    request.getRequestDispatcher("editmenuview.jsp").forward(request, response);
                } else {
                    response.sendRedirect("ViewMenuDetailServlet");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddDishToMenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
