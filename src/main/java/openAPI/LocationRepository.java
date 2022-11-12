package openAPI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import openAPI.LocationRepository;
import openAPI.Location;

public class LocationRepository {

	private HashMap<String, Location> postMap = new HashMap<>();
	private static LocationRepository instance = new LocationRepository();
	
	public LocationRepository() {}
	
	public static LocationRepository getInstance() {
		return instance;
	}
	
	public void getHistory() {
		
	}
	
	public void insertLocation(String lat, String lnt) {
		
		try {
			String url = "jdbc:mariadb://192.168.64.2:3306/wifi_db";
			String user = "wifi_user";
			String pass = "zerobase";
			
			Class.forName("org.mariadb.jdbc.Driver");
			
			Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet rs = null;
			
            connection = DriverManager.getConnection(url, user, pass);
            
            try{
    			String sql = "INSERT INTO history (x_pos, y_pos) "
    						+ "VALUES(?, ?)";
    			preparedStatement = connection.prepareStatement(sql);
    			preparedStatement.setString(1, lat);
    			preparedStatement.setString(2, lnt);
    			
    			preparedStatement.executeUpdate();
    		} catch(SQLException ex){
    			System.out.println("Update 실패<br>");
    			System.out.println("Error: " + ex.getMessage());
    		} finally{
    			if(preparedStatement != null)
    				preparedStatement.close();
    			if(connection != null)
    				connection.close();
    		}
            
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
