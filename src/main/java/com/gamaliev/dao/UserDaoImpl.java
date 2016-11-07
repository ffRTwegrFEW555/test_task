package com.gamaliev.dao;

import com.gamaliev.helper.UserHelper;
import com.gamaliev.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.List;
import java.util.logging.Logger;

@Repository
public class UserDaoImpl implements UserDao {
    private static final Logger logger = Logger.getLogger(UserDaoImpl.class.getName());

    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void update(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);
        session.flush();
        session.refresh(user);
        logger.info("User successfully updated. User details: " + user);
    }

    @Override
    public void add(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(user);
        logger.info("User successfully added. User details: " + user);
    }

    @Override
    public void removeById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = session.load(User.class, id);
        session.remove(user);
        logger.info("User successfully removed. User details: " + user);
    }

    @Override
    public User getById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = session.get(User.class, id);
        logger.info("User successfully loaded. User details: " + user);
        return user;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> getSelected(int startPosition, int endPosition, String textFilter) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = null;

        if (textFilter == null || textFilter.trim().equals("")) {
            query = session.createQuery("from User")
                    .setFirstResult(startPosition)
                    .setMaxResults(endPosition - startPosition);
        } else {
            query = session.createQuery(
                    UserHelper.getQueryFindAllFields("select u from User u ", textFilter).toString())
                    .setFirstResult(startPosition)
                    .setMaxResults(endPosition - startPosition);
        }

        List<User> userList = query.list();

        logger.info("User list (Selected): ");
        for (User user : userList) {
            logger.info(user.toString());
        }
        return userList;
    }

    @Override
    public int getCount() {
        Session session = this.sessionFactory.getCurrentSession();
        return ((BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM user;")
                .list()
                .get(0))
                .intValue();
    }

    @Override
    public int getCountByFilter(String textFilter) {
        if (textFilter == null || textFilter.trim().equals("")) {
            return getCount();
        }

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                UserHelper.getQueryFindAllFields("select count(*) from User u ", textFilter).toString());

        return ((Long) query.uniqueResult()).intValue();
    }
}
