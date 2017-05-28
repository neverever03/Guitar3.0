package service;

import java.util.List;

import dao.GuitarDao;
import model.Guitar;

public interface GuitarService {
	public void setGuitarDao(GuitarDao guitarDao);

	public List<Guitar> searchGuitar() throws Exception;
	public void addg(Guitar guitar) throws Exception;
	public void deleteg(String serialNumber)throws Exception;
}
