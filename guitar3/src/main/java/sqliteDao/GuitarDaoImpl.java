package sqliteDao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.GuitarDao;
import model.Builder;
import model.Guitar;
import model.GuitarSpec;
import model.Type;
import model.Wood;
import util.DBUtil;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class GuitarDaoImpl implements GuitarDao{
	private static final Object model = null;
	@Override
	public List<Guitar> searchGuitar() throws Exception{		
		Connection Conn = DBUtil.getSqliteConnection();
		String sql = "select * from Guitar";
		List<Guitar> guitarList = new ArrayList<Guitar>();
		PreparedStatement pstmt = Conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			GuitarSpec guitarSpec=new GuitarSpec(Builder.valueOf(rs.getString(3)),rs.getString(4),Type.valueOf(rs.getString(5)),Wood.valueOf(rs.getString(6)),Wood.valueOf(rs.getString(7)));
			Guitar guitar = new Guitar(rs.getString(1),rs.getDouble(2),guitarSpec);
			guitarList.add(guitar);
		}
		if(rs != null){
			rs.close();
		}
		
		pstmt.close();
		Conn.close();
		return guitarList;

}
	@Override
	public void addg(Guitar guitar) throws Exception{
		Connection Conn = DBUtil.getSqliteConnection();
		String sql = "INSERT INTO Guitar(serialNumber,price,builder,model,type,topWood,backWood) VALUES(?,?,?,?,?,?,?)";
		
		PreparedStatement stmt = Conn.prepareStatement(sql);	
		 GuitarSpec spec = guitar.getSpec();
	    stmt.setString(1, guitar.getSerialNumber());
		stmt.setDouble(2,guitar.getPrice());
		stmt.setString(3, spec.getBuilder().toString());
		stmt.setString(4, spec.getModel().toString());
		stmt.setString(5, spec.getType().toString());
		stmt.setString(6, spec.getBackWood().toString());
		stmt.setString(7, spec.getTopWood().toString());
		stmt.executeUpdate();	
		
		stmt.close();
		Conn.close();
		
	}
	@Override
	public void deleteg(String serialNumber)throws Exception {
		// TODO Auto-generated method stub
		Connection Conn = DBUtil.getSqliteConnection();	
		String sql = "DELETE FROM Guitar WHERE serialNumber=?";
		PreparedStatement stmt = Conn.prepareStatement(sql);	
	    stmt.setString(1,serialNumber);
		stmt.executeUpdate();	
		stmt.close();
		Conn.close();
	}
}
