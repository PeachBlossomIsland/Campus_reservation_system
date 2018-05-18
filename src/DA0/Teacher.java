package DA0;



public class Teacher {
	private String id;
	private String name;
	private String passwd;
	private String sex;
	private String department;
	private String prof;
	public void setId(String id)
	{
		this.id=id;
	}
	public void setprof(String prof)
	{
		this.prof=prof;
	}
	public void setName(String name)
	{
		this.name=name;
	}
	public void setPasswd(String passwd)
	{
		this.passwd=passwd;
	}
	public void setSex(String sex)
	{
		this.sex=sex;
	}
	public void setDepartment(String department)
	{
		this.department=department;
	}

	public String getId()
	{
		return id;
	}
	public String getName()
	{
		return name;
	}
	public String  getPasswd()
	{
		return passwd;
	}
	public String  getSex()
	{
		return sex;
	}
	public String getDepartment()
	{
		return department;
	}

	public String getprof()
	{
		return prof;
	}
}
