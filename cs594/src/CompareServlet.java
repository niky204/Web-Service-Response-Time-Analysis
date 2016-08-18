

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CompareServlet
 */
public class CompareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompareServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config); 
		ServletContext context = getServletContext();

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new ServletException(e);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Records> allData =new ArrayList<Records>();
		List <project> wsdlList=new ArrayList<project>();
		List <project> wsdlListfinal=new ArrayList<project>();
		//List<Integer> Total=new ArrayList<Integer>();
	//	List<Integer> TotalNumber=new ArrayList<Integer>();
		
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
			ResultSet rs1 = stmt
					.executeQuery("SELECT * FROM projects ");
			while (rs1.next()) {
				wsdlList.add(new project(rs1.getInt("id"), rs1.getString("name"), rs1.getString("url")));	
			}
//			for(int i=0;i<wsdlList.size();i++)
//			{
//				Total.set(i, 0);
//				TotalNumber.set(i, 0);
//			}
			ResultSet rs = stmt
					.executeQuery("SELECT * FROM records"
							);
			
			while (rs.next()) {
				
				allData.add(new Records(rs.getLong("id"), rs.getInt("wsdlId"),Integer.parseInt(rs.getString("time"))));
			
				//Total.set(mainid, Total.get(mainid)+Integer.parseInt(rs.getString("time")));
				//TotalNumber.set(mainid, TotalNumber.get(mainid)+1);
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
		String[] wsList = (String[]) context.getAttribute("wsList"); 
		for (String s : wsList) {
			for( project p: wsdlList )
			{
				if(p.getName().equals(s))
				{
					wsdlListfinal.add(p);
				}
			}
		}
		
		for(int i=0;i<wsdlListfinal.size();i++)
		{
			long total=0;
			int count=0;
			for(int j=0;j<allData.size();j++)
			{
				if(allData.get(j).getMainid()==wsdlListfinal.get(i).getId())
				{
					total=total+allData.get(j).getTime();
					count++;
				}
			}
			project p=wsdlListfinal.get(i);
			p.setAvg((int) (total/count));
			wsdlListfinal.set(i, p);
		}
		
		request.setAttribute("wsdlListfinal", wsdlListfinal);
		request.setAttribute("allData", allData);
		request.getRequestDispatcher("/ShowProject2.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
