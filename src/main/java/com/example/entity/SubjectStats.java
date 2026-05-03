package com.example.entity;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Component
@Getter
@Setter
@NoArgsConstructor
public class SubjectStats {

    private String name;
    private long count;

    public SubjectStats(String name, long count) {
        this.name = name;
        this.count = count;
    }

}