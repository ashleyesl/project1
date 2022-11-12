package openAPI;

import java.util.Date;

public class Location {
	private String lat;
	private String lnt;
	private int id;
	private String searchDate;
	
	public Location() {}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLnt() {
		return lnt;
	}

	public void setLnt(String lnt) {
		this.lnt = lnt;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getSearchDate() {
		return searchDate;
	}
	
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
}
