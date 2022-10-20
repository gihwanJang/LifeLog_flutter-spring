package com.graduate.springserver.model.log;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LogDao {
    @Autowired
    private LogRepository repository;
    
    public void addLog(Log log){
        repository.save(log);
    }

    public List<Log> getAllUserLogs(String id){
        return repository.getAllUserLog(id);
    }

    public List<Log> getMonthUserLogs(String id, Timestamp start, Timestamp end){
        return repository.getMonthUserLog(id, start, end);
    }
}
