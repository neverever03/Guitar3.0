package test;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.junit.Test;

import dao.GuitarDao;
import dao.dataAccess;
import model.Builder;
import model.Guitar;
import model.GuitarSpec;
import model.Inventory;
import model.Type;
import model.Wood;
import service.GuitarService;
import service.impl.GuitarServiceImpl;
import util.DBUtil;

public class GuitarTest {

	@Test
	public void delete() throws Exception
	{
		GuitarDao guitarDao=dataAccess.createGuitarDao();
	
		guitarDao.deleteg("11277");

	}
	@Test
	public void add()throws Exception{
		GuitarDao guitarDao=dataAccess.createGuitarDao();
		GuitarSpec spec= new GuitarSpec(Builder.COLLINGS, "CJ", Type.ACOUSTIC, Wood.INDIAN_ROSEWOOD, Wood.SITKA);
		Guitar g=new Guitar("11277", 3999.95,spec);
		guitarDao.addg(g);
		
	}
	@Test
	public void search()throws Exception{
		
		GuitarDao guitarDao=dataAccess.createGuitarDao();
		Inventory inventory=new Inventory(guitarDao.searchGuitar());
		    GuitarSpec whatErinLikes = 
		      new GuitarSpec(Builder.FENDER, "Stratocastor", 
		                     Type.ELECTRIC, Wood.ALDER, Wood.ALDER);
		    List matchingGuitars = inventory.search(whatErinLikes);
		    if (!matchingGuitars.isEmpty()) {
		      System.out.println("Erin, you might like these guitars:");
		      for (Iterator i = matchingGuitars.iterator(); i.hasNext(); ) {
		        Guitar guitar = (Guitar)i.next();
		        GuitarSpec spec = guitar.getSpec();
		        System.out.println("  We have a " +
		          spec.getBuilder() + " " + spec.getModel() + " " +
		          spec.getType() + " guitar:\n     " +
		          spec.getBackWood() + " back and sides,\n     " +
		          spec.getTopWood() + " top.\n  You can have it for only $" +
		          guitar.getPrice() + "!\n  ----");
		      }
		    } else {
		      System.out.println("Sorry, Erin, we have nothing for you.");
		    }
	}
	
}
