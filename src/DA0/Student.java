package DA0;



public class Student {
	private String id;
	private String name;
	private String passwd;
	private String sex;
	private String profession;
	public void setId(String id)
	{
		this.id=id;
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
	public void setProfession(String profession)
	{
		this.profession=profession;
	}

	public String getId()
	{
		return id;
	}
	public String getName()
	{
		return name;
	}
	public String getPasswd()
	{
		return passwd;
	}
	public String getSex()
	{
		return sex;
	}
	public String getProfession()
	{
		return profession;
	}

}
