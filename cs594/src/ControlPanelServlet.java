

import java.awt.BasicStroke;
import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.plot.PlotOrientation;

import eu.impact_project.iif.ws.generic.SoapInput;
import eu.impact_project.iif.ws.generic.SoapOperation;
import eu.impact_project.iif.ws.generic.SoapOutput;
import eu.impact_project.iif.ws.generic.SoapService;


public class ControlPanelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ControlPanelServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		
		super.init(config); 
List <project> wsdlList=new ArrayList<project>();
		ServletContext context = getServletContext();
		context.setAttribute("opDiv", false); 
		context.setAttribute("inputsDiv", false); 
		context.setAttribute("resultDiv", false);
		context.setAttribute("wsdlList", wsdlList);
		context.setAttribute("nameOfService", "nope");
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new ServletException(e);
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List <project> wsdlList=new ArrayList<project>();
		
		
		String mainurl = "";
		
		Connection c = null;
		try {
			String username = "root";
			String password = "";
			String host = "localhost";
			String port = "3306";
			String dbName = "cs594";
			
			String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName;

			c = DriverManager.getConnection(url, username, password);
			Statement stmt = c.createStatement();

			ResultSet rs = stmt
					.executeQuery("SELECT * FROM projects ");
			while (rs.next()) {
				
				wsdlList.add(new project(rs.getInt("id"), rs.getString("name"), rs.getString("url")));
				
				
			}
			//System.out.println(dataset.getRowCount());
			
		} catch (SQLException e) {
			throw new ServletException(e);
		} finally {
			try {
				if (c != null)
					c.close();
			} catch (SQLException e) {
				throw new ServletException(e);
			}
		}
	
		
		ServletContext context = getServletContext();
		if(request.getParameter("op")!=null){
			
			SoapService service = null;
			service = (SoapService) context.getAttribute("service");
			String operation = request.getParameter("op");
			SoapOperation op = service.getOperation(operation);
			List<SoapInput> allInputs = op.getInputs();
			for(int i=0; i<allInputs.size();i++){				
				System.out.println("input"+i+" "+allInputs.get(i).getName());
				System.out.println("Multivalued :"+ allInputs.get(i).isMultiValued());
				List<String> possible = allInputs.get(i).getPossibleValues();
				System.out.println("possible"+possible.size());			
			} 
			context.setAttribute("soap_operation", op); 
			
			context.setAttribute("allInputs", allInputs); 
			context.setAttribute("inputsDiv", true); 
			context.setAttribute("opDiv", true);  
			context.setAttribute("resultDiv", false);
		}
		if(request.getParameter("id")!=null)
		{
			Integer id=Integer.parseInt(request.getParameter("id"));
			
			for(int i=0;i<wsdlList.size();i++)
			{
				if(id==wsdlList.get(i).getId())
				{
					mainurl=wsdlList.get(i).getUrl();	
					context.setAttribute("nameOfService", wsdlList.get(i).getName());
					
				}
			}
			
			
			


			SoapService service = null;
			try{
			service = new SoapService(mainurl);
			}catch(Exception e){
			System.out.println(e); 
			} 
			List<SoapOperation> allOps = service.getOperations();  
//			context.setAttribute("wsurl", url);  
			context.setAttribute("service", service);
			context.setAttribute("operations", allOps); 
			System.out.println("All operations"+allOps);
			System.out.println("hii");

			context.setAttribute("WSDLID", id+""); 
			
			context.setAttribute("opDiv", true);
			context.setAttribute("inputsDiv", false); 
			context.setAttribute("resultDiv", false);
				
		}
		if(request.getParameter("flag7")!=null){
String flag7=request.getParameter("flag7");	
context.setAttribute("flag7", flag7);
		}
		context.setAttribute("wsdlList", wsdlList);
		request.getRequestDispatcher("/control_panel.jsp")
		.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext context = getServletContext();
	String action=request.getParameter("action");
 
		if (action.equals("Get Operations")){
			String url = request.getParameter("wsurl");
			
			SoapService service = null;
			try{
			service = new SoapService(url);
			}catch(Exception e){
			System.out.println(e); 
			} 
			List<SoapOperation> allOps = service.getOperations();  
//			context.setAttribute("wsurl", url);  
			context.setAttribute("service", service);
			context.setAttribute("operations", allOps); 
			
			context.setAttribute("opDiv", true);
			context.setAttribute("inputsDiv", false); 
			context.setAttribute("resultDiv", false);
//			response.sendRedirect("ControlPanelServlet"); 	
		}else if(action.equals("Invoke")){
		long Users=	Long.parseLong(request.getParameter("NoOfUsers"));
		List <Long> allData= new ArrayList<Long>();
		for(long k=0;k<Users;k++)
		{
			Date start=new Date();
			SoapOperation op = (SoapOperation) context.getAttribute("soap_operation");
			List<SoapInput> allInputs = op.getInputs();
			List<SoapOutput> outs = null;
			if(allInputs.size()==0){
				outs = op.execute("", "");
			}else{
				for(int i=0; i<allInputs.size();i++){
					allInputs.get(i).setValue(request.getParameter("ibox"+i)); 
				} 
				outs = op.execute("", "");
			}
			HashMap<String, String> result = new HashMap<String, String>(); 
			for (SoapOutput out : outs) {  
				result.put(out.getName(), out.getValue());
	            System.out.println(out.getName()); 
	            System.out.println(out.getValue());
			}
			context.setAttribute("result", result);
			context.setAttribute("resultDiv", true);
			Date end=new Date();
			long interval=end.getTime()-start.getTime();
			allData.add(interval);
		}
			
			

			Connection c = null;
			try {
				String username = "root";
				String password = "";
				String host = "localhost";
				String port = "3306";
				String dbName = "cs594";

				String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName;

				String sql = "insert into records ( time,  wsdlId ) values (? ,?)";
				int WSDLID=Integer.parseInt((String)context.getAttribute("WSDLID"));
				c = DriverManager.getConnection(url, username, password);
				PreparedStatement pstmt = c.prepareStatement(sql);
				
				
				pstmt.setInt(2,WSDLID);
				for(int  j=0;j<allData.size();j++)
				{
				pstmt.setString(1, allData.get(j)+"");		
				pstmt.executeUpdate();
				}
			
			} catch (SQLException e) {
				throw new ServletException(e);
			} finally {
				try {
					if (c != null)
						c.close();
				} catch (SQLException e) {
					throw new ServletException(e);
	}
			}
			
			
			
			
			
//			response.sendRedirect("ControlPanelServlet"); 	
		}else if(action.equals("compare")){
			String[] wsList = request.getParameterValues("comparelist");
					
			context.setAttribute("wsList", wsList);
		}
		else{
			System.out.println("name "+request.getParameter("projectName")+" url"
					+request.getParameter("Url"));

			Connection c = null;
			try {
				String username = "root";
				String password = "";
				String host = "localhost";
				String port = "3306";
				String dbName = "cs594";

				String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName;

				String sql = "insert into projects ( name, url ) values (? ,?)";

				c = DriverManager.getConnection(url, username, password);
				PreparedStatement pstmt = c.prepareStatement(sql);
				pstmt.setString(1, request.getParameter("projectName"));
				pstmt.setString(2, request.getParameter("Url"));
				
				
				pstmt.executeUpdate();
			
			} catch (SQLException e) {
				throw new ServletException(e);
			} finally {
				try {
					if (c != null)
						c.close();
				} catch (SQLException e) {
					throw new ServletException(e);
	}
			}
			
			
		}
		if(action.equals("compare"))
		{
			response.sendRedirect("CompareServlet"); 
		}
		else
		{
		response.sendRedirect("ControlPanelServlet"); 	
		}
		
	}
}
