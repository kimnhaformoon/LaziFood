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
import table.accounts.AccountDTO;
import table.customerplans.CustomerPlanDAO;
import table.dishes.DishesDAO;

/**
 *
 * @author long
 */
public class AddDishToPlanServlet extends HttpServlet {

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
            String txtPlanId = request.getParameter("txtPlanId");
            String txtDay = request.getParameter("txtDay");
            String txtPeriod = request.getParameter("txtPeriod");
            if (txtDishId != null && txtPlanId != null && txtDay != null 
                    && txtPeriod != null && !txtPlanId.isEmpty() 
                    && !txtDay.isEmpty() && !txtPeriod.isEmpty() 
                    && !txtDishId.isEmpty()) {
                int planId = Integer.parseInt(txtPlanId);
                int day = Integer.parseInt(txtDay);
                int period = Integer.parseInt(txtPeriod);
                int dishId = Integer.parseInt(txtDishId);
                CustomerPlanDAO planDao = new CustomerPlanDAO();
                planDao.addDishToPlan(planId, day, period, dishId);
                request.getRequestDispatcher("ViewPersonalPlanServlet").forward(request, response);
            } else {
                if (txtPlanId != null && txtDay != null && txtPeriod != null 
                        && !txtPlanId.isEmpty() && !txtDay.isEmpty() 
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
                    request.getRequestDispatcher("editplanview.jsp").forward(request, response);
                } else {
                    response.sendRedirect("personalPlanPage");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AddDishToPlanServlet.class.getName()).log(Level.SEVERE, null, ex);
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
