package common;

public class Person {
	private String UserID;
	private String AdminID;
	
	public Person() {}

	public String getUserID() {
		return UserID;
	}

	public void setUserID(String userID) {
		UserID = userID;
	}

	public String getAdminID() {
		return AdminID;
	}

	public void setAdminID(String adminID) {
		AdminID = adminID;
	}

	public Person(String userID, String adminID) {
		super();
		UserID = userID;
		AdminID = adminID;
	}

}
