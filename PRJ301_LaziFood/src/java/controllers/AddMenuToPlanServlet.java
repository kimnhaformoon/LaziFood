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
import table.menu.MenuDAO;
import table.menu.MenuDTO;

/**
 *
 * @author long
 */
public class AddMenuToPlanServlet extends HttpServlet {

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
            AccountDTO account = 
                    (AccountDTO) request.getSession().getAttribute("LoginedAccount");
            String txtMenuId = request.getParameter("txtMenuId");
            if (txtMenuId == null || txtMenuId.isEmpty()) {
                response.sendRedirect("personalPlanPage");
            }
            int menuId = 0;
            try {
                menuId = Integer.parseInt(txtMenuId);
            } catch (Exception e) {
                response.sendRedirect("personalPlanPage");
            }

            MenuDAO menuDao = new MenuDAO();
            MenuDTO menuDto = menuDao.getMenuById(menuId);
            for (int i = 2; i <= 7; i++) {
                menuDao.getDayMenu(i, menuDto);
            }

            CustomerPlanDAO planDao = new CustomerPlanDAO();
            int planId = planDao.createPlan(account.getId(), menuDto.getName());
            planDao.addMenuToPlan(menuDto, planId);
            request.getRequestDispatcher("ViewPersonalPlanServlet?txtPlanId="+planId).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AddMenuToPlanServlet.class.getName()).log(Level.SEVERE, null, ex);
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
