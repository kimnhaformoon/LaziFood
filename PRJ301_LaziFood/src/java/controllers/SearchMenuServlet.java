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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import table.menu.MenuDAO;
import table.menu.MenuDTO;

/**
 *
 * @author Kim Nha
 */
public class SearchMenuServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String categoryId = (String) request.getAttribute("categoryId");
            String searchName = (String) request.getAttribute("searchName");
            if (categoryId == null) {
                categoryId = request.getParameter("categoryId");
                request.setAttribute("categoryId", categoryId);
            }
            if (searchName == null) {
                searchName = request.getParameter("txtSearchName");
                request.setAttribute("searchName", searchName);
            }
            String index = request.getParameter("index");
            if (index == null) {
                index = "1";
            }
            MenuDAO menuDao = new MenuDAO();
            int totalSize = menuDao.getTotalOfSearchMenu(categoryId, searchName, Integer.parseInt(index.trim()));
            List<MenuDTO> list = menuDao.searchMenu(categoryId, searchName, Integer.parseInt(index.trim()));
            int pageNum = totalSize / 5;
            if (totalSize % 5 != 0) {
                pageNum++;
            }
            request.setAttribute("index", index);
            request.setAttribute("pageNum", pageNum);
            request.setAttribute("LIST_MENU", list);
            request.getRequestDispatcher("manageMenu.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SearchMenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SearchMenuServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
