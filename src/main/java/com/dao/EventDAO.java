package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.model.Event;
import com.model.EventManager;

public class EventDAO {

	private Connection connection = null;

	public boolean saveEventDao(Event event) {

		connection = ConnectionManager.getConnection();

		String query = "INSERT INTO events (client_name, mobile_number, event_name, description, event_date, event_time, venue, capacity, manager_email) VALUES (?, ?, ?, ?, ?, ?, ?,?,?)";

		PreparedStatement statement = null;

		try {
			statement = connection.prepareStatement(query);
			statement.setString(1, event.getClientName());
			statement.setString(2, event.getMobileNumber());
			statement.setString(3, event.getEventName());
			statement.setString(4, event.getDescription());
			statement.setString(5, event.getEventDate());
			statement.setString(6, event.getEventTime());
			statement.setString(7, event.getVenue());
			statement.setInt(8, event.getCapacity());
			statement.setString(9, event.getManagerEmail());

			int count = statement.executeUpdate();

			if (count != 0) {
				return true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
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

	public List<Event> fetchAllEvents() {
		List<Event> eventList = new ArrayList<Event>();

		Connection connection = ConnectionManager.getConnection();
		String query = "select * from events";

		try {
			PreparedStatement statement = connection.prepareStatement(query);

			ResultSet set = statement.executeQuery();

			while (set.next()) {
				Event obj = new Event();
				obj.setEventId(set.getInt(1));
				obj.setClientName(set.getString(2));
				obj.setMobileNumber(set.getString(3));
				obj.setEventName(set.getString(4));
				obj.setDescription(set.getString(5));
				obj.setEventDate(set.getString(6));
				obj.setEventTime(set.getString(7));
				obj.setVenue(set.getString(8));
				obj.setCapacity(set.getInt(9));
				obj.setManagerEmail(set.getString(10));
				eventList.add(obj);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return eventList;

	}

	public List<Event> fetchManagerEvents(String managerEmail) {
		List<Event> eventList = new ArrayList<Event>();

		Connection connection = ConnectionManager.getConnection();
		String query = "select * from events where manager_email = ?";

		try {
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, managerEmail);

			ResultSet set = statement.executeQuery();

			while (set.next()) {
				Event obj = new Event();
				obj.setEventId(set.getInt(1));
				obj.setClientName(set.getString(2));
				obj.setMobileNumber(set.getString(3));
				obj.setEventName(set.getString(4));
				obj.setDescription(set.getString(5));
				obj.setEventDate(set.getString(6));
				obj.setEventTime(set.getString(7));
				obj.setVenue(set.getString(8));
				obj.setCapacity(set.getInt(9));
				obj.setManagerEmail(set.getString(10));
				eventList.add(obj);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return eventList;
	}

	public void editEvent(Event event) {

		connection = ConnectionManager.getConnection();

		String query = "UPDATE events SET event_name = ?, client_name= ?, mobile_number =?, description = ?, event_date = ?, event_time = ?, venue = ?, capacity = ?, manager_email = ? WHERE event_id = ?";

		PreparedStatement statement = null;

		try {
			statement = connection.prepareStatement(query);

			statement.setString(1, event.getEventName());
			statement.setString(2, event.getClientName());
			statement.setString(3, event.getMobileNumber());
			statement.setString(4, event.getDescription());
			statement.setString(5, event.getEventDate());
			statement.setString(6, event.getEventTime());
			statement.setString(7, event.getVenue());
			statement.setInt(8, event.getCapacity());
			statement.setString(9, event.getManagerEmail());
			statement.setInt(10, event.getEventId());

			statement.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean deleteEvent(int id) {

		connection = ConnectionManager.getConnection();

		String query = "delete from events where event_id =?";

		PreparedStatement statement = null;

		try {
			statement = connection.prepareStatement(query);
			statement.setInt(1, id);

			int count = statement.executeUpdate();

			if (count != 0) {
				return true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public boolean assignEvent(int eventId, int managerId) {

		connection = ConnectionManager.getConnection();

		PreparedStatement statement = null;

		String selectQuery = "SELECT em_email FROM event_managers WHERE em_id = ? AND user_role = 'manager'";

		String updateQuery = "UPDATE events SET manager_email = ? WHERE event_id = ?";

		try {

			statement = connection.prepareStatement(selectQuery);
			statement.setInt(1, managerId);

			ResultSet rs = statement.executeQuery();

			if (rs.next()) {

				String managerEmail = rs.getString("em_email");

				PreparedStatement updatestatement = connection.prepareStatement(updateQuery);

				updatestatement.setString(1, managerEmail);
				updatestatement.setInt(2, eventId);

				int result = updatestatement.executeUpdate();

				return result > 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public Event getEventById(int eventId) {

		Event obj = new Event();

		Connection connection = ConnectionManager.getConnection();
		String query = "select * from events where event_id = ?";

		try {
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setInt(1, eventId);

			ResultSet set = statement.executeQuery();

			while (set.next()) {

				obj.setEventId(set.getInt(1));
				obj.setClientName(set.getString(2));
				obj.setMobileNumber(set.getString(3));
				obj.setEventName(set.getString(4));
				obj.setDescription(set.getString(5));
				obj.setEventDate(set.getString(6));
				obj.setEventTime(set.getString(7));
				obj.setVenue(set.getString(8));
				obj.setCapacity(set.getInt(9));
				obj.setManagerEmail(set.getString(10));
				return obj;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

}
