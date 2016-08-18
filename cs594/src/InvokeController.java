

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.javafx.collections.MappingChange.Map;

import eu.impact_project.iif.ws.generic.SoapInput;
import eu.impact_project.iif.ws.generic.SoapOperation;
import eu.impact_project.iif.ws.generic.SoapOutput;

/**
 * Servlet implementation class InvokeController
 */
public class InvokeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public InvokeController() {
        super();
        // TODO Auto-generated constructor stub
    }


	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		ServletContext context = getServletContext();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext context = getServletContext(); 
		
		
		
	}
}
