package main.java.com.bean;

public class MainVO {
	private Long id;
    private String username;
    private String password;
    private String useremail;
    private String userid;
    private String tableid;
    private String number_of_people;
    private String reservation_Time;
    private String delYN;
    private String cre_datetime;
    
    
    public String getTableid() {
		return tableid;
	}
	public void setTableid(String tableid) {
		this.tableid = tableid;
	}
	public String getNumber_of_people() {
		return number_of_people;
	}
	public void setNumber_of_people(String number_of_people) {
		this.number_of_people = number_of_people;
	}
	public String getReservation_Time() {
		return reservation_Time;
	}
	public void setReservation_Time(String reservation_Time) {
		this.reservation_Time = reservation_Time;
	}
	public String getDelYN() {
		return delYN;
	}
	public void setDelYN(String delYN) {
		this.delYN = delYN;
	}
	public String getCre_datetime() {
		return cre_datetime;
	}
	public void setCre_datetime(String cre_datetime) {
		this.cre_datetime = cre_datetime;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
    
    // 생성자, getter, setter 등의 코드는 필요에 따라 추가하십시오.
}