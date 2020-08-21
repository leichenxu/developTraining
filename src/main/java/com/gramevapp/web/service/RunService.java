package com.gramevapp.web.service;

import com.gramevapp.web.model.*;
import com.gramevapp.web.repository.ExperimentRepository;
import com.gramevapp.web.repository.PropertiesRepository;
import com.gramevapp.web.repository.RunRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("runService")
public class  RunService {
    @Autowired
    RunRepository runRepository;

    @Autowired
    ExperimentRepository experimentRepository;

    @Autowired
    PropertiesRepository expPropertiesRepository;

    public Run saveRun(Run run){
        return runRepository.save(run);
    }

    public Run findByRunId(Long runId){
        return runRepository.findById(runId).get();
    }

    public List<Run> findAllByExperiment(Experiment exp){
        return runRepository.findAllByExperimentId(exp);
    }

    public Run findLastRunId(){
        return runRepository.findTop1ByOrderByIdDesc();
    }

    public void deleteRun(Run run){
        runRepository.delete(run);
    }

    public void updateRun(){
        runRepository.flush();
    }

    public void deleteExpProperties(ExpProperties expProperties){
        expPropertiesRepository.delete(expProperties);
    }


}
