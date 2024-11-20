/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import table.accounts.AccountDTO;
import table.customerplans.CustomerPlanDAO;
import table.customerplans.CustomerPlanDTO;

/**
 *
 * @author long
 */
public class ViewPersonalPlanServlet extends HttpServlet {

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
            AccountDTO account = (AccountDTO) request.getSession().getAttribute("LoginedAccount");
            CustomerPlanDAO planDao = new CustomerPlanDAO();
            List<Integer> listPlanId = planDao.getAllCustomerPlanId(account.getId());
            String txtId = request.getParameter("txtPlanId");
            if (listPlanId != null && !listPlanId.isEmpty()) {
                int planId;
                if (txtId == null) {
                    planId = listPlanId.get(0);
                } else {
                    try {
                        planId = Integer.parseInt(txtId);
                        if (!listPlanId.contains(planId)){
                            planId = listPlanId.get(0);
                        }
                    } catch (NumberFormatException e) {
                        planId = listPlanId.get(0);
                    }
                }
                String txtDay = request.getParameter("txtDay");
                if (txtDay == null || txtDay.isEmpty()) {
                    txtDay = "2";
                }
                int day;
                try {
                    day = Integer.parseInt(txtDay);
                    if (!(day >=2 && day<=7)) {
                        day = 2;
                    }
                } catch (NumberFormatException e) {
                    day = 2;
                }
                CustomerPlanDTO planDto = planDao.getCustomerPlanById(planId);
                planDao.getDayPlan(planDto, day);
                request.setAttribute("Plan", planDto);
                request.setAttribute("day", day);
                request.setAttribute("LIST_PLAN_ID", listPlanId);
            }
            request.getRequestDispatcher("personalplan.jsp").forward(request, response);
        } catch (SQLException | NamingException ex) {
            Logger.getLogger(ViewPersonalPlanServlet.class.getName()).log(Level.SEVERE, null, ex);
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
