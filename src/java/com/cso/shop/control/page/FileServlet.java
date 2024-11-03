/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cso.shop.control.page;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.nio.file.Files;

/**
 *
 * @author hi
 */
@WebServlet(name = "FileServlet", urlPatterns = {"/file/*"})
public class FileServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
    resp.setHeader("access-control-allow-headers", "content-type");
    resp.setHeader("access-control-allow-origin", "*");
    resp.setHeader("access-control-allow-methods", "get");

    resp.setHeader("cache-control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    resp.setHeader("pragma", "no-cache"); // HTTP 1.0
    resp.setDateHeader("expires", 0); // Proxies

    String filename = req.getPathInfo().substring(1);
    File file = new File(getServletContext().getInitParameter("file.location"), filename);
    if (!file.exists()) {
      resp.sendError(HttpServletResponse.SC_NOT_FOUND);
      return;
    }

    resp.setHeader("content-type", getServletContext().getMimeType(filename));
    resp.setHeader("content-length", String.valueOf(file.length()));
    resp.setHeader("content-disposition", "inline; filename=\"" + filename + "\"");
    Files.copy(file.toPath(), resp.getOutputStream());
  }

  @Override
  public String getServletInfo() {
    return "Short description";
  }

}
