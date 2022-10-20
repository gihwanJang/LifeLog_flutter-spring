package com.graduate.springserver.model.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserDao {
    @Autowired
    private UserRepository repository;
    
    public void addUser(User user){
        repository.save(user);
    }

    public User findUser(String id){
        return repository.findById(id).orElse(null);
    }
}
