package openAPI;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.SQLException;
import java.util.HashMap;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import com.google.gson.*;

import java.io.IOException;

public class ApiExplorer {

	private HashMap<String, Location> postMap = new HashMap<>();
	private static ApiExplorer instance = new ApiExplorer();

	public ApiExplorer() {}

	public static ApiExplorer getInstance() {
		return instance;
	}

	public int getLocation() throws IOException {
		int num = 0;

		for (int i = 0; i < 18; i++) {

			int start = i * 1000 + 1;
			int end = (i + 1) * 1000;
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088"); /* URL */
			urlBuilder.append("/" + URLEncoder.encode("4a5375534c617368343241584f6e79", "UTF-8")); /* 인증키 */
			urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8")); /* 요청파일타입 (xml,xmlf,xls,json) */
			urlBuilder.append("/" + URLEncoder.encode("TbPublicWifiInfo", "UTF-8")); /* 서비스명 (대소문자 구분 필수입니다.) */
			urlBuilder.append("/" + URLEncoder.encode(String.valueOf(start), "UTF-8")); /* 요청시작위치 */
			urlBuilder.append("/" + URLEncoder.encode(String.valueOf(end), "UTF-8")); /* 요청종료위치 */

			OkHttpClient client = new OkHttpClient();
			Request.Builder builder = new Request.Builder().url(urlBuilder.toString()).get();
			Request request = builder.build();
			Response response = client.newCall(request).execute();

			if (response.isSuccessful()) {
				try {
					String sql_url = "jdbc:mariadb://192.168.64.2:3306/wifi_db";
					String dbUserId = "wifi_user";
					String dbPassword = "zerobase";

					Class.forName("org.mariadb.jdbc.Driver");

					Connection connection = null;
					PreparedStatement preparedStatement = null;
					ResultSet rs = null;

					connection = DriverManager.getConnection(sql_url, dbUserId, dbPassword);

					JsonObject jsonObject = JsonParser.parseReader(response.body().charStream()).getAsJsonObject();

					JsonArray rows = jsonObject.get("TbPublicWifiInfo").getAsJsonObject().get("row").getAsJsonArray();

					for (JsonElement row : rows) {
						JsonObject jsonobject = row.getAsJsonObject();
						String mgrNo = jsonobject.get("X_SWIFI_MGR_NO").getAsString();
						String wrdofc = jsonobject.get("X_SWIFI_WRDOFC").getAsString();
						String maingNm = jsonobject.get("X_SWIFI_MAIN_NM").getAsString();
						String adreS1 = jsonobject.get("X_SWIFI_ADRES1").getAsString();
						String adreS2 = jsonobject.get("X_SWIFI_ADRES2").getAsString();
						String instlFl = jsonobject.get("X_SWIFI_INSTL_FLOOR").getAsString();
						String instlTy = jsonobject.get("X_SWIFI_INSTL_TY").getAsString();
						String instlMby = jsonobject.get("X_SWIFI_INSTL_MBY").getAsString();
						String svcSe = jsonobject.get("X_SWIFI_SVC_SE").getAsString();
						String cmcWr = jsonobject.get("X_SWIFI_CMCWR").getAsString();
						String cnstcYr = jsonobject.get("X_SWIFI_CNSTC_YEAR").getAsString();
						String inoutDoor = jsonobject.get("X_SWIFI_INOUT_DOOR").getAsString();
						String remarS3 = jsonobject.get("X_SWIFI_REMARS3").getAsString();
						String lat = jsonobject.get("LAT").getAsString();
						String lnt = jsonobject.get("LNT").getAsString();
						String dttm = jsonobject.get("WORK_DTTM").getAsString();

						String sql = "" + "INSERT INTO wifi_info " + "(" + "X_SWIFI_MGR_NO, " + "X_SWIFI_WRDOFC, "
								+ "X_SWIFI_MAIN_NM, " + "X_SWIFI_ADRES1, " + "X_SWIFI_ADRES2, "
								+ "X_SWIFI_INSTL_FLOOR, " + "X_SWIFI_INSTL_TY, " + "X_SWIFI_INSTL_MBY, "
								+ "X_SWIFI_SVC_SE, " + "X_SWIFI_CMCWR, " + "X_SWIFI_CNSTC_YEAR, "
								+ "X_SWIFI_INOUT_DOOR, " + "X_SWIFI_REMARS3, " + "LAT, " + "LNT, " + "WORK_DTTM " + ") "
								+ "VALUES " + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) " + "ON DUPLICATE KEY UPDATE "
								+ "X_SWIFI_WRDOFC=?, " + "X_SWIFI_MAIN_NM=?, " + "X_SWIFI_ADRES1=?, "
								+ "X_SWIFI_ADRES2=?, " + "X_SWIFI_INSTL_FLOOR=?, " + "X_SWIFI_INSTL_TY=?, "
								+ "X_SWIFI_INSTL_MBY=?, " + "X_SWIFI_SVC_SE=?, " + "X_SWIFI_CMCWR=?, "
								+ "X_SWIFI_CNSTC_YEAR=?, " + "X_SWIFI_INOUT_DOOR=?, " + "X_SWIFI_REMARS3=?, "
								+ "LAT=?, " + "LNT=?, " + "WORK_DTTM=?;";

						preparedStatement = connection.prepareStatement(sql);
						preparedStatement.setString(1, mgrNo);
						preparedStatement.setString(2, wrdofc);
						preparedStatement.setString(3, maingNm);
						preparedStatement.setString(4, adreS1);
						preparedStatement.setString(5, adreS2);
						preparedStatement.setString(6, instlFl);
						preparedStatement.setString(7, instlTy);
						preparedStatement.setString(8, instlMby);
						preparedStatement.setString(9, svcSe);
						preparedStatement.setString(10, cmcWr);
						preparedStatement.setString(11, cnstcYr);
						preparedStatement.setString(12, inoutDoor);
						preparedStatement.setString(13, remarS3);
						preparedStatement.setString(14, lat);
						preparedStatement.setString(15, lnt);
						preparedStatement.setString(16, dttm);

						preparedStatement.setString(17, wrdofc);
						preparedStatement.setString(18, maingNm);
						preparedStatement.setString(19, adreS1);
						preparedStatement.setString(20, adreS2);
						preparedStatement.setString(21, instlFl);
						preparedStatement.setString(22, instlTy);
						preparedStatement.setString(23, instlMby);
						preparedStatement.setString(24, svcSe);
						preparedStatement.setString(25, cmcWr);
						preparedStatement.setString(26, cnstcYr);
						preparedStatement.setString(27, inoutDoor);
						preparedStatement.setString(28, remarS3);
						preparedStatement.setString(29, lat);
						preparedStatement.setString(30, lnt);
						preparedStatement.setString(31, dttm);

						preparedStatement.executeUpdate();
					}
					String select_sql = "SELECT count(*) AS count FROM wifi_info;";
					preparedStatement = connection.prepareStatement(select_sql);
					rs = preparedStatement.executeQuery();

					while (rs.next()) {
						num = rs.getInt(1);
					}

					System.out.println("NUM: " + num);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return num;
	}
}