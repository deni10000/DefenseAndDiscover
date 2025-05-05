package backend.academy.apigateway.controller;

import backend.academy.apigateway.client.PromtClient;
import backend.academy.apigateway.dto.CheckAnswerDto;
import backend.academy.apigateway.dto.PostAnswerDto;
import backend.academy.apigateway.dto.QuestionDto;
import backend.academy.apigateway.dto.RequestPromtDto;
import backend.academy.apigateway.utils.ApiPaths;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Вопросы", description = "Операции с вопросами")
public class PromtController {

    private final PromtClient promtClient;

    @PostMapping(ApiPaths.BASE_API + "/getQuestion")
    @Operation(summary = "Сгенерировать вопрос")
    public ResponseEntity<List<QuestionDto>> getQuestion(@RequestBody RequestPromtDto requestPromtDto) {
        try {
            return ResponseEntity.ok(promtClient.getQuestion(requestPromtDto));
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }

    @Operation(summary = "Отправить ответ на вопрос")
    @PostMapping(ApiPaths.BASE_API + "/postAnswer")
    public ResponseEntity<CheckAnswerDto> postAnswer(@RequestBody PostAnswerDto postAnswerDto) {
        try {
            return ResponseEntity.ok(promtClient.postAnswer(postAnswerDto));
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }
}
