package com.example.entity;

import java.util.List;

import javax.persistence.*;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@Table(name="questions")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 1000)
    private String question;

    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;

    private String correctAnswer;

    // Difficulty (Easy / Medium / Hard)
    private String difficulty;

    // Course relation
    @ManyToOne
    @JoinColumn(name="course_id")
    private Course course;

    // Test relation
    @ManyToOne
    @JoinColumn(name="test_id")
    private Test test;

    // Student answers
    @OneToMany(mappedBy="question", cascade=CascadeType.ALL)
    private List<StudentAnswer> answers;

}