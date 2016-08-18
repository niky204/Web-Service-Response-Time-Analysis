

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
 * Servlet implementation class ShowProject
 */
public class ShowProject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowProject() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
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
		int mainid=Integer.parseInt((String)request.getParameter("id"));
		List<Records> allData =new ArrayList<Records>();
		List <project> wsdlList=new ArrayList<project>();
		
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
		for(int i=0;i<wsdlList.size();i++)
		{
			long total=0;
			int count=0;
			for(int j=0;j<allData.size();j++)
			{
				if(allData.get(j).getMainid()==wsdlList.get(i).getId())
				{
					total=total+allData.get(j).getTime();
					count++;
				}
			}
			project p=wsdlList.get(i);
			p.setAvg((int) (total/count));
			wsdlList.set(i, p);
		}
		request.setAttribute("mainid", mainid);
		request.setAttribute("wsdlList", wsdlList);
		request.setAttribute("allData", allData);
		request.getRequestDispatcher("/ShowProject.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
