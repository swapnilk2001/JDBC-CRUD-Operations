package com.jbk;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class CreateDB {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {

		Class.forName("com.mysql.cj.jdbc.Driver");
		String URL = "jdbc:mysql://localhost:3306/supertwentydaytwo";
		String USER = "root";
		String PASS = "swap@2001";

		System.out.println("connection is success");
		Connection conn = DriverManager.getConnection(URL, USER, PASS);

		Scanner sc = new Scanner(System.in);
		int choise;
		char ch;
		do {
			System.out.println("press 1 Q 1");
			System.out.println("press 2 Q 2");
			System.out.println("press 3 Q 3");
			System.out.println("press 4 Q 4");
			System.out.println("press 5 Q 5");
			System.out.println("press 6 Q 6");
			System.out.println("press 7 Q 7");
			System.out.println("press 8 Q 8");
			System.out.println("press 9 Q 9");
			System.out.println("press 10 Q 10");
			System.out.println("press 11 Q 11");
			System.out.println("press 12 Q 12");
			System.out.println("press 13 Q 13");
			System.out.println("press 14 Q 14");
			System.out.println("press 15 Q 15");
			System.out.println("press 16 Q 16");
			System.out.println("press 17 Q 17");
			System.out.println("press 18 Q 18");
			System.out.println("press 19 Q 19");
			System.out.println("press 20 Q 20");
			System.out.println("press 21 Q 21");
			System.out.println("press 22 Q 22");

			Date date = Date.valueOf("2024-06-12");

			choise = sc.nextInt();
			switch (choise) {
			case 1: {
				addAuthor(conn, "John", "Doe", "john@gmail.com", "1980-01-01");

				break;
			}

			case 2: {
				updateAuthorEmail(conn, 1, "swap@gmail.com");

				break;
			}
			case 3: {
				deleteAuthorbyId(conn, 1);
				break;
			}
			case 4: {
				addNewPost(conn, 1, "my post", "my description", "this is content", date);

				break;
			}

			case 5: {
			 getAllpostbyAuthor(conn, 1);
				

				break;
			}

			case 6: {

				updatePostTitleDesc(conn, 1, "New Title", "New Description");

				break;
			}
			case 7: {

				deletePostbyId(conn, 2);
				break;
			}

			case 8: {
				getAuthorsByPostDate(conn, "2024-06-12");

				break;
			}

			case 9: {
				printPostCountByAuthor(conn);

				break;
			}

			case 10: {

				printPostsByKeywordInTitle(conn, "third");
				break;
			}
			case 11: {

				listAuthorsAlphabetically(conn);

				break;
			}

			case 12: {
				RecentPost(conn);

				break;
			}
			case 13: {
				AuthorsWithNoPosts(conn);
				break;
			}
			case 14: {
				getPostsInDateRange(conn, "2024-01-01", "2024-06-11");

				break;
			}
			case 15: {
				getPostsTitleAuthors(conn);
				break;
			}
			case 16: {
				addMultipleAuthor(conn, "Ajay", "Rathod", "ajay@gmail.com", "2001-01-31");
				break;
			}
			case 17: {

				countPostsofEachAuthor(conn);
				break;
			}

			case 18: {

				calculateCountofPOst(conn);
				;
				break;
			}
			case 19: {
				oldestAuthor(conn);
				;
				break;
			}
			case 20: {

				calculateCountofPOst(conn);
				;
				break;
			}
			case 21: {

				calculateCountofPOst(conn);
				;
				break;
			}
			case 22: {

				limitedrecentPost(conn);
				;
				break;

			}

			default:
				System.out.println("invalid input");
				break;
			}

			System.out.println("Do you want to conutiune y/n");
			ch = sc.next().charAt(0);

		} while (ch == 'y' || ch == 'Y');
		{

		}

	}

	public static void addAuthor(Connection conn, String firstName, String lastName, String email, String birthdate) {
		String sql = "INSERT INTO authors (first_name, last_name, email, birthdate) VALUES (?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, firstName);
			pstmt.setString(2, lastName);
			pstmt.setString(3, email);
			pstmt.setString(4, birthdate);

			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("A new author was inserted successfully!");
			} else {
				System.out.println("Failed to insert the author.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void updateAuthorEmail(Connection conn, int aid, String email) {
		String sql = "UPDATE authors SET email = ? WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, aid);

			int rowsUpdated = pstmt.executeUpdate();
			if (rowsUpdated > 0) {
				System.out.println("Author email updated successfully!");
			} else {
				System.out.println("Failed to update author email.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void deleteAuthorbyId(Connection conn, int author_id) {
		String sql = "DELETE FROM authors  WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, author_id);

			int delete = pstmt.executeUpdate();
			if (delete > 0) {
				System.out.println("Author deleted  successfully!");
			} else {
				System.out.println("Failed to delete author ");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void addNewPost(Connection conn, int author_id, String title, String description, String content,
			Date date) {
		String sql = "INSERT INTO posts (author_id, title, description,content, date) VALUES (?, ?, ?, ?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, author_id);
			pstmt.setString(2, title);
			pstmt.setString(3, description);
			pstmt.setString(4, content);
			pstmt.setDate(5, date);

			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("A new posts added  successfully!");
			} else {
				System.out.println("Failed to addding new post");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void getAllpostbyAuthor(Connection conn, int aid) {

		String sql = "SELECT * FROM posts WHERE author_id = ?";
		try {

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, aid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int postId = rs.getInt("id");
				String title = rs.getString("title");
				String description = rs.getString("description");
				String content = rs.getString("content");
				Date date = rs.getDate("date");
				System.out.println();
				
				System.out.println("Post ID: " + postId);
				System.out.println("title: " + title);
				System.out.println("description: " + description);
				System.out.println("content: " + content);
				System.out.println("date: " + date);
				System.out.println();


			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

 

	}

	public static void updatePostTitleDesc(Connection conn, int Id, String Title, String Description) {
		String sql = "UPDATE posts SET title = ?, description = ? WHERE id = ?";
		try {

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Title);
			pstmt.setString(2, Description);
			pstmt.setInt(3, Id);

			int rowsUpdated = pstmt.executeUpdate();
			if (rowsUpdated > 0) {
				System.out.println("Post with ID " + Id + " updated successfully!");
			} else {
				System.out.println("Failed to update post with ID " + Id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void deletePostbyId(Connection conn, int id) {
		String sql = "DELETE FROM posts  WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			int delete = pstmt.executeUpdate();
			if (delete > 0) {
				System.out.println("Posts deleted  successfully!");
			} else {
				System.out.println("Failed to delete posts ");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public static void getAuthorsByPostDate(Connection conn, String string) {

		String sql = "SELECT DISTINCT a.* FROM authors a JOIN posts p ON a.id = p.author_id WHERE p.date = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, string);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int authorId = rs.getInt("id");
				String firstName = rs.getString("first_name");
				String lastName = rs.getString("last_name");
				String email = rs.getString("email");
				String birthDate = rs.getString("birthdate");

				System.out.println(
						"Author: " + firstName + " " + lastName + ", Email: " + email + ", Birthdate: " + birthDate);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void printPostCountByAuthor(Connection conn) {
		String sql = "SELECT a.*, COUNT(p.id) AS post_count FROM authors a LEFT JOIN posts p ON a.id = p.author_id GROUP BY a.id";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int authorId = rs.getInt("id");
				String firstName = rs.getString("first_name");
				String lastName = rs.getString("last_name");
				String email = rs.getString("email");
				String birthDate = rs.getString("birthdate");
				int postCount = rs.getInt("post_count");

				System.out.println("Author: " + firstName + " " + lastName + ", Email: " + email + ", Number of Posts: "
						+ postCount);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static Object printPostsByKeywordInTitle(Connection conn, String keyword) {
		String sql = "SELECT * FROM posts WHERE title LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				int postId = rs.getInt("id");
				int authorId = rs.getInt("author_id");
				String title = rs.getString("title");
				String description = rs.getString("description");
				String content = rs.getString("content");
				Date date = rs.getDate("date");

				System.out.println("Post ID: " + postId);
				System.out.println("Author ID: " + authorId);
				System.out.println("Title: " + title);
				System.out.println("Description: " + description);
				System.out.println("Content: " + content);
				System.out.println("Date: " + date);
				System.out.println();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sql;
	}

	public static void listAuthorsAlphabetically(Connection conn) {
		String sql = "SELECT * FROM authors ORDER BY last_name ASC";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				int authorId = rs.getInt("id");
				String firstName = rs.getString("first_name");
				String lastName = rs.getString("last_name");

				System.out.println("Author ID: " + authorId);
				System.out.println("First Name: " + firstName);
				System.out.println("Last Name: " + lastName);
				System.out.println();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void RecentPost(Connection conn) {
		String sql = "SELECT * FROM posts WHERE author_id = ? ORDER BY date  DESC LIMIT 1";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, 1);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				int postId = rs.getInt("id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp createdAt = rs.getTimestamp("date");

				System.out.println("Post ID: " + postId);
				System.out.println("Title: " + title);
				System.out.println("Content: " + content);
				System.out.println("Created At: " + createdAt);
			} else {
				System.out.println("No posts found for author ID 1");
			}
		} catch (SQLException e) {
			System.err.println("SQL Exception: " + e.getMessage());
		}
	}

	public static void AuthorsWithNoPosts(Connection conn) {
		String sql = "SELECT * FROM authors WHERE id NOT IN (SELECT DISTINCT author_id FROM posts)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("first_name");
				System.out.println("Author ID: " + id + ", Author Name: " + name);
			}
		} catch (SQLException e) {
			System.err.println("SQL Exception: " + e.getMessage());
		}
	}

	public static void getPostsInDateRange(Connection conn, String string, String string2) {
		String sql = "SELECT * FROM posts WHERE date BETWEEN ? AND ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setDate(1, Date.valueOf(string));
			pstmt.setDate(2, Date.valueOf(string2));

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				int postId = rs.getInt("id");
				int authorId = rs.getInt("author_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp createdAt = rs.getTimestamp("date");

				System.out.println("Post ID: " + postId);
				System.out.println("Author ID: " + authorId);
				System.out.println("Title: " + title);
				System.out.println("Content: " + content);
				System.out.println("Created At: " + createdAt);
				System.out.println();
			}
		} catch (SQLException e) {
			System.err.println("SQL Exception: " + e.getMessage());
		}
	}

	public static void getPostTitleAuthor(Connection conn) {

		String sql = "SELECT * FROM authors WHERE id NOT IN (SELECT DISTINCT author_id FROM posts)";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("id");
				String name = rs.getString("first_name");
				System.out.println("Author ID: " + id + ", Author Name: " + name);
			}
		} catch (SQLException e) {
			System.err.println("SQL Exception: " + e.getMessage());
		}

	}

	public static void getPostsTitleAuthors(Connection conn) {
		String sql = "SELECT p.title AS post_title, a.first_name AS author_name " + "FROM posts p "
				+ "INNER JOIN authors a ON p.author_id = a.id";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String title = rs.getString("post_title");
				String name = rs.getString("a.first_name");

				System.out.println("name: " + name);
				System.out.println("Title: " + title);
				System.out.println();
			}
		} catch (SQLException e) {
			System.err.println("SQL Exception: " + e.getMessage());
		}
	}

	public static void addMultipleAuthor(Connection conn, String firstName, String lastName, String email,
			String birthdate) {
		String sql = "INSERT INTO authors (first_name, last_name, email, birthdate) VALUES (?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, firstName);
			pstmt.setString(2, lastName);
			pstmt.setString(3, email);
			pstmt.setString(4, birthdate);

			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("A new author was inserted successfully!");
			} else {
				System.out.println("Failed to insert the author.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void countPostsofEachAuthor(Connection conn) {
		String sql = "SELECT a.first_name, a.last_name, COUNT(p.id) AS post_count " + "FROM authors a "
				+ "JOIN posts p ON a.id = p.author_id " + "GROUP BY a.first_name, a.last_name";
		;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String firstName = rs.getString("first_name");
				String lastName = rs.getString("last_name");
				String count = rs.getString("post_count");

				System.out.println("Author: " + firstName + " " + lastName + ", Post Count: " + count);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void calculateCountofPOst(Connection conn) {
		String sql = "select author_id,count(id)as post_count from posts group by author_id";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String author_id = rs.getString("author_id");
				String count = rs.getString("post_count");

				System.out.println("Author Id: " + author_id + "  Post Count: " + count);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void oldestAuthor(Connection conn) {
		String sql = "select * from authors order by birthdate ASC limit 1 ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				int authorId = rs.getInt("id");
				String authorName = rs.getString("name");
				Date authorBirthdate = rs.getDate("birthdate");

				System.out.println("Author ID: " + authorId);
				System.out.println("Name: " + authorName);
				System.out.println("Birthdate: " + authorBirthdate);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void limitedrecentPost(Connection conn) {
		String sql = "select * from posts order by date DESC limit 5 ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				int postId = rs.getInt("id");
				String postContent = rs.getString("content");
				Timestamp postDate = rs.getTimestamp("date");

				System.out.println("Post ID: " + postId);
				System.out.println("Content: " + postContent);
				System.out.println("Date: " + postDate);
				System.out.println();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
