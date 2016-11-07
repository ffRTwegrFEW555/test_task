package com.gamaliev.dao;

import com.gamaliev.model.User;

import java.util.List;

public interface UserDao {
    void update(User user);
    void add(User user);
    void removeById(int id);
    User getById(int id);
    List<User> getSelected(int startPosition, int endPosition, String textFilter);
    int getCount();
    int getCountByFilter(String textFilter);
}
