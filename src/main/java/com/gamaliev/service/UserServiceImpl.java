package com.gamaliev.service;

import com.gamaliev.dao.UserDao;
import com.gamaliev.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    private UserDao userDao;

    @Autowired
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    @Transactional
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    @Transactional
    public void add(User user) {
        userDao.add(user);
    }

    @Override
    @Transactional
    public void removeById(int id) {
        userDao.removeById(id);
    }

    @Override
    @Transactional
    public User getById(int id) {
        return userDao.getById(id);
    }

    @Override
    @Transactional
    public List<User> getSelected(int startPosition, int endPosition, String textFilter) {
        return userDao.getSelected(startPosition, endPosition, textFilter);
    }

    @Override
    @Transactional
    public int getCount() {
        return userDao.getCount();
    }

    @Override
    @Transactional
    public int getCountByFilter(String textFilter) {
        return userDao.getCountByFilter(textFilter);
    }
}
