package action;

import java.io.IOException;
import net.sf.json.JSONArray;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import dao.GuitarDao;
import dao.dataAccess;
import model.Builder;
import model.Guitar;
import model.GuitarSpec;
import model.Inventory;
import model.Type;
import model.Wood;
import mysqlDao.GuitarDaoImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.GuitarService;
import service.impl.GuitarServiceImpl;

public class GuitarAction extends ActionSupport{
	private JSONObject jsonObject=new JSONObject();
	private Builder builder; 
	private String model;
	private Type type;
	private Wood backWood;
	private Wood topWood;
	private String serialNumber;
	private double price;
	
	private JSONArray jsonArray = new JSONArray();
	public JSONArray getJsonArray() {
		return jsonArray;
	}
	public void setJsonArray(JSONArray jsonArray) {
		this.jsonArray = jsonArray;
	}
	//
	public String addguitar(){
		GuitarDao guitarDao=dataAccess.createGuitarDao();
		GuitarService guitarService=new GuitarServiceImpl();	
		guitarService.setGuitarDao(guitarDao);
		jsonObject.put("status", "ok");
		GuitarSpec guitarspec=new GuitarSpec(builder, model, type, backWood, backWood);
		Guitar guitar=new Guitar(serialNumber, price, guitarspec);
		try{
			guitarspec.setBuider(builder);
			guitarspec.setModel(model);
			guitarspec.setType(type);
			guitarspec.setBackWood(backWood);
			guitarspec.setTopWood(topWood);
			guitar.setPrice(price);
			guitar.setSerialNumber(serialNumber);
			guitar.setGuitarSpec(guitarspec);
			guitarService.addg(guitar);
		}
		catch(Exception e){
			jsonObject.put("status", "nook");
		}
		return "jsonObject";
	}
	public String deleteguitar() throws Exception{
		GuitarDao guitarDao=dataAccess.createGuitarDao();
		GuitarService guitarService=new GuitarServiceImpl();	
		guitarService.setGuitarDao(guitarDao);
		jsonObject.put("status", "ok");
		try{
			guitarService.deleteg(serialNumber);
		}catch(Exception e){
			jsonObject.put("status", "nook");
		}
		return "jsonObject";
	}
	
	
	public String search() throws Exception{
		out();
		GuitarDao guitarDao=dataAccess.createGuitarDao();
		GuitarService guitarSearchService=new GuitarServiceImpl();		
		guitarSearchService.setGuitarDao(guitarDao);
		Inventory inventory=new Inventory(guitarSearchService.searchGuitar());
		GuitarSpec whatyoulike=new GuitarSpec(builder,model,type,backWood,topWood);
		List<Guitar> macthingGuitars=inventory.search(whatyoulike);		
		/*JSONArray array=new JSONArray();*/
		for(Guitar guitar:macthingGuitars){
			 JSONObject jo=new JSONObject();
			 jo.put("serialNumber",guitar.getSerialNumber());
			 jo.put("price",guitar.getPrice());
			 jo.put("builder",guitar.getSpec().getBuilder());
			 jo.put("model",guitar.getSpec().getModel());
			 jo.put("type",guitar.getSpec().getType());
			 jo.put("backWood",guitar.getSpec().getBackWood());
			 jo.put("topWood",guitar.getSpec().getTopWood());
			 jsonArray.add(jo);
		}
		return "jsonArray";
		/*out().print(array);
		out().flush(); 
		out().close();*/
	}
	public PrintWriter out()throws IOException{
		HttpServletResponse response=ServletActionContext.getResponse();  
        response.setContentType("text/html");  
        response.setContentType("text/plain; charset=utf-8");
        PrintWriter out= response.getWriter();
        return out;
	}
	public Builder getBuilder() {
		return builder;
	}
	public void setBuilder(Builder builder) {
		this.builder = builder;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
	public Wood getBackWood() {
		return backWood;
	}
	public void setBackWood(Wood backWood) {
		this.backWood = backWood;
	}
	public Wood getTopWood() {
		return topWood;
	}
	public void setTopWood(Wood topWood) {
		this.topWood = topWood;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public JSONObject getJsonObject() {
		return jsonObject;
	}
	public void setJsonObject(JSONObject jsonObject) {
		this.jsonObject = jsonObject;
	}
	
}
