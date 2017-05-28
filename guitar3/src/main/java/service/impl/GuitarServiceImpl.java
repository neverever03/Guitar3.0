package service.impl;

import java.util.List;

import dao.GuitarDao;
import model.Guitar;
import service.GuitarService;

public class GuitarServiceImpl implements GuitarService{
	private GuitarDao guitarDao;
	
	@Override
	public void setGuitarDao(GuitarDao guitarDao) {
		// TODO Auto-generated method stub
		this.guitarDao =guitarDao;
	}

	@Override
	public List<Guitar> searchGuitar() throws Exception {
		// TODO Auto-generated method stub
		 return guitarDao.searchGuitar();
	}

	@Override
	public void addg(Guitar guitar) throws Exception {
		// TODO Auto-generated method stub
		guitarDao.addg(guitar);
	}

	@Override
	public void deleteg(String serialNumber) throws Exception {
		// TODO Auto-generated method stub
		guitarDao.deleteg(serialNumber);
	}

}
