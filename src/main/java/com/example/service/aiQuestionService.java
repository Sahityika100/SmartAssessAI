package com.example.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.entity.Course;
import com.example.entity.Question;
import com.example.entity.Test;
import com.example.repo.QuestionRepo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Service
public class aiQuestionService {

	@Autowired
	private QuestionRepo qr;

	@Value("${gemini.api.key}")
	private String apiKey;

	public List<Question> generateQuestions(int questionCount, Test test, Course c1) throws Exception {

		String prompt = "Generate " + questionCount + " MCQ questions for " + c1.getCourseName()
				+ ". Return ONLY valid JSON array with fields question, optionA, optionB, optionC, optionD, correctAnswer option like A .";

		String aiResponse = callAI(prompt);

		List<Question> questions = parseAIResponse(aiResponse, test, c1);

		return qr.saveAll(questions);
	}

	private String callAI(String prompt) throws JsonProcessingException {
		RestTemplate restTemplate = new RestTemplate();

		String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		// API KEY HEADER (IMPORTANT)
		headers.set("X-goog-api-key", apiKey);

		ObjectMapper mapper = new ObjectMapper();

		ObjectNode root = mapper.createObjectNode();
		ArrayNode contents = root.putArray("contents");

		ObjectNode content = contents.addObject();
		ArrayNode parts = content.putArray("parts");

		ObjectNode textNode = parts.addObject();
		textNode.put("text", prompt);

		String body;
		body = mapper.writeValueAsString(root);

		HttpEntity<String> request = new HttpEntity<>(body, headers);

		ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);

		return response.getBody();

	}

	public List<Question> parseAIResponse(String response, Test test, Course c1) throws Exception {

		ObjectMapper mapper = new ObjectMapper();

		JsonNode root = mapper.readTree(response);

		String text = root.get("candidates").get(0).get("content").get("parts").get(0).get("text").asText();

		List<Question> list = new ArrayList<>();

		JsonNode questions = mapper.readTree(text);

		for (JsonNode q : questions) {

			Question question = new Question();

			question.setQuestion(q.get("question").asText());
			question.setOptionA(q.get("optionA").asText());
			question.setOptionB(q.get("optionB").asText());
			question.setOptionC(q.get("optionC").asText());
			question.setOptionD(q.get("optionD").asText());
			question.setCorrectAnswer(q.get("correctAnswer").asText());
			question.setTest(test);
			question.setCourse(c1);
			list.add(question);
		}

		return list;
	}
}
