
public class project {
int id,Avg;
String name,url;

public project() {
	super();
}
public project(int id, String name, String url) {
	super();
	this.id = id;
	this.name = name;
	this.url = url;
}

public int getAvg() {
	return Avg;
}
public void setAvg(int avg) {
	Avg = avg;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}

}
