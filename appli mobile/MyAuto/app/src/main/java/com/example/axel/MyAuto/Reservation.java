package com.example.axel.MyAuto;

/**
 * Created by iris-pc on 16/04/2018.
 */

public class Reservation {
    private String userName, userEmail, start, end, title;
    private int userId, id;

    public Reservation(String userName, String userEmail, String start, String end, String title, int userId, int id) {
        this.userName = userName;
        this.userEmail = userEmail;
        this.start = start;
        this.end = end;
        this.title = title;
        this.userId = userId;
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {

        return "ID cours : " + this.id + "\nDébut : " +this.start + "\nFin : "+this.end ;
    }
}
