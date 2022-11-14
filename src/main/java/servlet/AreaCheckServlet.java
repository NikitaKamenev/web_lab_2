package servlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import model.Point;
import model.PointsBean;

import java.io.IOException;
import java.io.PrintWriter;


public class AreaCheckServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Double x = null;
        Double y = null;
        Double r = null;

        PointsBean pointsBean = (PointsBean) request.getSession().getAttribute("PointsBean");
        if(pointsBean == null){
            pointsBean = new PointsBean();
        }

        try {
            x = Double.parseDouble(request.getParameter("x").trim());
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("/controller").forward(request, response);
        }

        try {
            y = Double.parseDouble(request.getParameter("y").trim().replaceAll(",", "."));
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("/controller").forward(request, response);
        }
        try {
            r = Double.parseDouble(request.getParameter("r").trim().replaceAll(",", "."));
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("/controller").forward(request, response);
        }
        try (PrintWriter out = response.getWriter()) {
            if (x != null && y != null && r != null) {


                Point point = new Point(pointsBean.getTotalPoints()+1, x, y, r);
                pointsBean.add(point);
                request.getSession().setAttribute("PointsBean", pointsBean);

                out.println(point.toJSON());
            }
        }
    }
}
