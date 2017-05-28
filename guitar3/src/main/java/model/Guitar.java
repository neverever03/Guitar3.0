package model;

public class Guitar {

  private String serialNumber;
  private double price;
  GuitarSpec spec;
private Builder builder;
private String model;
private Type type;
private Wood backWood;
private Wood topWood;

  public Guitar(String serialNumber, double price, GuitarSpec spec) {
    this.serialNumber = serialNumber;
    this.price = price;
    this.spec = spec;
  }
  public Guitar(String serialNumber, Double price, Builder builder, String model, Type type, Wood backWood, 
			Wood topWood) {
		super();
		this.serialNumber=serialNumber;
		this.price=price;
		this.builder = builder;
		this.model = model;
		this.type = type;
		this.backWood = backWood;
		this.topWood = topWood;
		this.spec=new GuitarSpec(builder,model,type,backWood,topWood);
	}

  public String getSerialNumber() {
    return serialNumber;
  }

  public double getPrice() {
    return price;
  }

  public void setPrice(double price) {
    this.price = price;
  }

  public GuitarSpec getSpec() {
    return spec;
  }

public void setSerialNumber(String serialNumber2) {
	// TODO Auto-generated method stub
	this.serialNumber=serialNumber;
}


public void setGuitarSpec(GuitarSpec guitarspec) {
	// TODO Auto-generated method stub
	this.spec=guitarspec;
}
}
