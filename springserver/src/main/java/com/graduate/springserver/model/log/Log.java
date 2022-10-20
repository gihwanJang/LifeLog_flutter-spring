package com.graduate.springserver.model.log;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Log {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private int lognum;
    private String id;
    private String title;
    private String context;
    private Timestamp datetime;

    public int getLognum(){return lognum;}
    public void setLognum(int lognum){this.lognum = lognum;}

    public String getId(){return id;}
    public void setId(String id){this.id = id;}

    public String getTitle(){return title;}
    public void setTitle(String title){this.title = title;}

    public String getContext(){return context;}
    public void setContext(String context){this.context = context;}

    public Timestamp getDatetime(){return datetime;}
    public void setDatetime(Timestamp datetime){this.datetime = datetime;}

    @Override
    public String toString(){
        return "User{" +
            "lognum=" + lognum +
            ", id=" + id + '\'' +
            ", title='" + title + '\'' +
            ", context='" + context + '\'' +
            ", datetime='" + datetime + '\'' +
            '}';
    }
}
