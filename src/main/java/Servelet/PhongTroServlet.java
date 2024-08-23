package Servelet;

import DAO.PhongTroDAO;
import Model.PhongTro;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "PhongTroServlet", urlPatterns = {"/phong-tro/*"})
public class PhongTroServlet extends HttpServlet {
    private PhongTroDAO phongTroDAO;

    @Override
    public void init() {
        phongTroDAO = new PhongTroDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.equals("/")) {
            action = "";
        }
        switch (action) {
            case "insert":
                try {
                    insertPhongTro(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "delete":
                try {
                    deletePhongTro(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "add":
                showNewForm(request, response);
                break;
            default:
                try {
                    listPhongTro(request, response);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        doGet(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        try {
            insertPhongTro(request,response);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void listPhongTro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String searchQuery = request.getParameter("searchQuery");
        List<PhongTro> listPhongTro;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            listPhongTro = phongTroDAO.searchPhongTros(searchQuery);
        } else {
            listPhongTro = phongTroDAO.getAllPhongTros();
        }

        request.setAttribute("listPhongTro", listPhongTro);
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/list.jsp");
        dispatcher.forward(request, response);
    }


    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/add.jsp");
        dispatcher.forward(request, response);
    }

    private void insertPhongTro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
//        String maPhongTro = request.getParameter("maPhongTro");
        String tenNguoiThue = request.getParameter("tenNguoiThue");
        String soDienThoai = request.getParameter("soDienThoai");
        String ngayBatDau = request.getParameter("ngayBatDau");
        String hinhThucThanhToanId = request.getParameter("hinhThucThanhToanId");
        String ghiChu = request.getParameter("ghiChu");

        PhongTro newPhongTro = new PhongTro();
//        newPhongTro.setMaPhongTro(maPhongTro);
        newPhongTro.setTenNguoiThue(tenNguoiThue);
        newPhongTro.setSoDienThoai(soDienThoai);
        newPhongTro.setNgayBatDau(ngayBatDau);
        newPhongTro.setHinhThucThanhToanId(hinhThucThanhToanId);
        newPhongTro.setGhiChu(ghiChu);

        phongTroDAO.addPhongTro(newPhongTro);
        response.sendRedirect("phong-tro");
    }

    private void deletePhongTro(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        if (ids != null && ids.length > 0) {
            List<Integer> idList = Arrays.stream(ids)
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());

            phongTroDAO.deletePhongTros(idList);
        }
        response.sendRedirect("phong-tro");
    }
}
