package dao;

import java.util.List;

import model.Guitar;
import model.Inventory;

public interface GuitarDao {
	public List<Guitar> searchGuitar()throws Exception;
	public void addg(Guitar guitar) throws Exception;
	public void deleteg (String serialNumber)throws Exception;
}
