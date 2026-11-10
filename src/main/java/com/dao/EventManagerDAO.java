package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.EventManager;

public class EventManagerDAO {
	private Connection connection = null;

	public boolean saveManager(EventManager manager) {

		connection = ConnectionManager.getConnection();

		String query = "INSERT INTO event_managers (em_name, em_email, em_mobile, em_password) VALUES (?, ?, ?, ?)";

		PreparedStatement statement = null;

		try {

			statement = connection.prepareStatement(query);

			statement.setString(1, manager.getName());
			statement.setString(2, manager.getEmail());
			statement.setString(3, manager.getMobile());
			statement.setString(4, manager.getPassword());

			int count = statement.executeUpdate();

			return count > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;

	}

	public List<EventManager> fetchAllManagers() {
		List<EventManager> managerList = new ArrayList<EventManager>();

		Connection connection = ConnectionManager.getConnection();
		String query = "select * from event_managers";

		try {
			PreparedStatement statement = connection.prepareStatement(query);

			ResultSet set = statement.executeQuery();

			while (set.next()) {
				EventManager obj = new EventManager();
				obj.setId(set.getInt(1));
				obj.setName(set.getString(2));
				obj.setEmail(set.getString(3));
				obj.setMobile(set.getString(4));
				managerList.add(obj);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return managerList;
	}

	public void commit() {
		try {
			connection.commit();
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void rollback() {

		try {
			connection.rollback();
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public EventManager loginUser(String email, String password) {

		EventManager manager = null;

		String query = "SELECT em_id, em_name, em_email, em_password, user_role FROM event_managers WHERE em_email = ? AND em_password = ?";
		Connection connection = ConnectionManager.getConnection();

		PreparedStatement statement = null;

		try {
			statement = connection.prepareStatement(query);
			statement.setString(1, email);
			statement.setString(2, password);

			ResultSet rs = statement.executeQuery();

			if (rs.next()) {

				manager = new EventManager();

				manager.setId(rs.getInt(1));
				manager.setName(rs.getString(2));
				manager.setEmail(rs.getString(3));
				manager.setMobile(rs.getString(4));
				manager.setUserRole(rs.getString(5));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return manager;

	}

	public void removeManager(int id) {

		connection = ConnectionManager.getConnection();
		PreparedStatement statement = null;

		String query = "DELETE FROM event_managers " + "WHERE em_id = ? "
				+ "AND em_email != 'rahamtullawork@gmail.com'";

		try {

			statement = connection.prepareStatement(query);

			statement.setInt(1, id);

			int result = statement.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

	public EventManager getManagerById(int id) {
		EventManager m = new EventManager();
		String query = "SELECT * FROM event_managers WHERE em_id = ?";

		connection = ConnectionManager.getConnection();
		PreparedStatement statement = null;

		try {

			statement = connection.prepareStatement(query);

			statement.setInt(1, id);

			ResultSet rs = statement.executeQuery();

			if (rs.next()) {

				m.setId(rs.getInt("em_id"));
				m.setName(rs.getString("em_name"));
				m.setEmail(rs.getString("em_email"));
				m.setMobile(rs.getString("em_mobile"));

				return m;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

	public boolean updateManagerDetails(int id, String name, String email, String mobile) {

		String query = "UPDATE event_managers SET em_name = ?, " + "em_email = ?, em_mobile = ? "
				+ "WHERE em_id = ? AND user_role = 'manager'";

		connection = ConnectionManager.getConnection();
		PreparedStatement statement = null;

		try {

			statement = connection.prepareStatement(query);

			statement.setString(1, name);
			statement.setString(2, email);
			statement.setString(3, mobile);
			statement.setInt(4, id);

			int result = statement.executeUpdate();
			
			return result > 0;

		} catch (Exception e) {

			e.printStackTrace();

		}

		return false;
	}

}
