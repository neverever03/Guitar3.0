package dao;

public class dataAccess {

		private static String daoName = "sqliteDao";	//此处切换数据库
		public static GuitarDao createGuitarDao() {
			GuitarDao result = null;
			try {
				Object o = Class.forName(daoName + "." + "GuitarDaoImpl").newInstance();
				result = (GuitarDao)o;
			} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return result;
		}

}
