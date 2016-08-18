
public class Records {
	long id;
int mainid,time;
public Records(long id, int mainid, int time) {
	super();
	this.id = id;
	this.mainid = mainid;
	this.time = time;
}
public Records() {
	super();
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}
public int getMainid() {
	return mainid;
}
public void setMainid(int mainid) {
	this.mainid = mainid;
}
public int getTime() {
	return time;
}
public void setTime(int time) {
	this.time = time;
}



}
