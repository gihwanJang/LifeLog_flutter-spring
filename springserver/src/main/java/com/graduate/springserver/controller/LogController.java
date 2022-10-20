package com.graduate.springserver.controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.graduate.springserver.model.log.Log;
import com.graduate.springserver.model.log.LogDao;

@RestController
public class LogController {
    @Autowired
    private LogDao logDao;

    @RequestMapping("/log/addlog")
    public Log userSignUp(@RequestBody Log log){
        try{
            logDao.addLog(log);
                return log;
        }
        catch(Exception e){
            return null;
        }
    }

    @RequestMapping(value = "/log/{userId}", method = RequestMethod.GET)
    public List<Log> getAllUserLogs(@PathVariable("userId") String id){
        try{
            return logDao.getAllUserLogs(id);
        }
        catch(Exception e){
            return null;
        }
    }

    @RequestMapping(value = "/log/{userId}/{start}/{end}", method = RequestMethod.GET)
    public List<Log> getMonthUserLogs(@PathVariable("userId") String id, @PathVariable("start") Timestamp start, @PathVariable("end") Timestamp end){
        try{
            return logDao.getMonthUserLogs(id, start, end);
        }
        catch(Exception e){
            return null;
        }
    }
}
