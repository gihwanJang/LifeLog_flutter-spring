package com.graduate.springserver.model.log;

import java.sql.Timestamp;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LogRepository extends CrudRepository<Log, String>{
    @Transactional
    @Query(value = "select * from log where log.id = :id", nativeQuery = true)
    List<Log> getAllUserLog(@Param("id") String id);

    @Transactional
    @Query(value = "select * from log where log.id = :id and log.datetime >= :start and log.datetime <= :end", nativeQuery = true)
    List<Log> getMonthUserLog(@Param("id") String id, @Param("start") Timestamp start, @Param("end") Timestamp end);
}
