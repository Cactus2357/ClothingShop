/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.cso.shop.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;

/**
 *
 * @author hi
 */
public class UserFilter implements Filter {

  private static final boolean debug = false;

  // The filter configuration object we are associated with.  If
  // this value is null, this filter instance is not currently
  // configured. 
  private FilterConfig filterConfig = null;

  public UserFilter() {
  }

  private void doBeforeProcessing(ServletRequest req, ServletResponse resp)
    throws IOException, ServletException {
    if (debug) {
      log("UserFilter:DoBeforeProcessing");
    }

    // Write code here to process the req and/or resp before
    // the rest of the filter chain is invoked.
    // For example, a logging filter might log items on the req object,
    // such as the parameters.
    /*
	for (Enumeration en = req.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = req.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
     */
  }

  private void doAfterProcessing(ServletRequest req, ServletResponse resp)
    throws IOException, ServletException {
    if (debug) {
      log("UserFilter:DoAfterProcessing");
    }

    // Write code here to process the req and/or resp after
    // the rest of the filter chain is invoked.
    // For example, a logging filter might log the attributes on the
    // req object after the req has been processed. 
    /*
	for (Enumeration en = req.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = req.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
     */
    // For example, a filter might append something to the resp.
    /*
	PrintWriter respOut = new PrintWriter(resp.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
     */
  }

  /**
   *
   * @param req The servlet req we are processing
   * @param resp The servlet resp we are creating
   * @param chain The filter chain we are processing
   *
   * @exception IOException if an input/output error occurs
   * @exception ServletException if a servlet error occurs
   */
  public void doFilter(ServletRequest req, ServletResponse resp,
    FilterChain chain)
    throws IOException, ServletException {

    if (debug) {
      log("UserFilter:doFilter()");
    }

    doBeforeProcessing(req, resp);

    Throwable problem = null;
    try {
      HttpServletRequest httpRequest = (HttpServletRequest) req;
      HttpServletResponse httpResponse = (HttpServletResponse) resp;
      HttpSession httpSession = httpRequest.getSession();

      if (httpSession.getAttribute("user") == null) {
        String originalURL = URLEncoder.encode(httpRequest.getRequestURI(), "UTF-8");
//          httpRequest.getRequestURI();
        String redirectURL = httpRequest.getContextPath() + "/signin?redirect=" + originalURL;
        httpResponse.sendRedirect(redirectURL);

        return;
      }

      chain.doFilter(req, resp);
    } catch (Throwable t) {
      // If an exception is thrown somewhere down the filter chain,
      // we still want to execute our after processing, and then
      // rethrow the problem after that.
      problem = t;
      t.printStackTrace();
    }

    doAfterProcessing(req, resp);

    // If there was a problem, we want to rethrow it if it is
    // a known type, otherwise log it.
    if (problem != null) {
      if (problem instanceof ServletException) {
        throw (ServletException) problem;
      }
      if (problem instanceof IOException) {
        throw (IOException) problem;
      }
      sendProcessingError(problem, resp);
    }
  }

  /**
   * Return the filter configuration object for this filter.
   */
  public FilterConfig getFilterConfig() {
    return (this.filterConfig);
  }

  /**
   * Set the filter configuration object for this filter.
   *
   * @param filterConfig The filter configuration object
   */
  public void setFilterConfig(FilterConfig filterConfig) {
    this.filterConfig = filterConfig;
  }

  /**
   * Destroy method for this filter
   */
  public void destroy() {
  }

  /**
   * Init method for this filter
   */
  public void init(FilterConfig filterConfig) {
    this.filterConfig = filterConfig;
    if (filterConfig != null) {
      if (debug) {
        log("UserFilter:Initializing filter");
      }
    }
  }

  /**
   * Return a String representation of this object.
   */
  @Override
  public String toString() {
    if (filterConfig == null) {
      return ("UserFilter()");
    }
    StringBuffer sb = new StringBuffer("UserFilter(");
    sb.append(filterConfig);
    sb.append(")");
    return (sb.toString());
  }

  private void sendProcessingError(Throwable t, ServletResponse resp) {
    String stackTrace = getStackTrace(t);

    if (stackTrace != null && !stackTrace.equals("")) {
      try {
        resp.setContentType("text/html");
        PrintStream ps = new PrintStream(resp.getOutputStream());
        PrintWriter pw = new PrintWriter(ps);
        pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

        // PENDING! Localize this for next official release
        pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
        pw.print(stackTrace);
        pw.print("</pre></body>\n</html>"); //NOI18N
        pw.close();
        ps.close();
        resp.getOutputStream().close();
      } catch (Exception ex) {
      }
    } else {
      try {
        PrintStream ps = new PrintStream(resp.getOutputStream());
        t.printStackTrace(ps);
        ps.close();
        resp.getOutputStream().close();
      } catch (Exception ex) {
      }
    }
  }

  public static String getStackTrace(Throwable t) {
    String stackTrace = null;
    try {
      StringWriter sw = new StringWriter();
      PrintWriter pw = new PrintWriter(sw);
      t.printStackTrace(pw);
      pw.close();
      sw.close();
      stackTrace = sw.getBuffer().toString();
    } catch (Exception ex) {
    }
    return stackTrace;
  }

  public void log(String msg) {
    filterConfig.getServletContext().log(msg);
  }

}
