package backend.academy.modelservice.service.impl;

import backend.academy.modelservice.dto.QuestionDto;
import backend.academy.modelservice.exception.QuestionDoesntExists;
import backend.academy.modelservice.mapper.QuestionMapper;
import backend.academy.modelservice.model.Question;
import backend.academy.modelservice.repository.QuestionRepository;
import backend.academy.modelservice.service.QuestionService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class QuestionServiceImpl implements QuestionService {

    private final QuestionRepository questionRepository;
    @Override
    public QuestionDto findQuestionAndTopicWhereIdNotIn(List<Long> ids, String topic) {
        if (ids == null || ids.isEmpty()) {
            return QuestionMapper.toDto(questionRepository.findFirstByTopic(topic).orElseThrow(
                    () ->  {
                        log.error("В базе нет вопросов: " + topic );
                        return new QuestionDoesntExists("doesnt exist");
                    }
            ));
        }
        return QuestionMapper.toDto(questionRepository.findFirstByTopicAndQuestionIdNotIn(topic, ids).orElseThrow(
                () ->  {
                    log.error("В базе нет вопросов: ids" + ids + " , " + topic );
                    return new QuestionDoesntExists("doesnt exist");
                }
        ));
    }

    @Override
    public QuestionDto createQuestion(QuestionDto questionDto) {

        Question entity = Question
                .builder()
                .topic(questionDto.getTopic())
                .correctAnswer(questionDto.getCorrectAnswer())
                .question(questionDto.getQuestion())
                .option1(questionDto.getOptions().get(0))
                .option2(questionDto.getOptions().get(1))
                .option3(questionDto.getOptions().get(2))
                .option4(questionDto.getOptions().get(3))
                .build();

        entity = questionRepository.save(entity);
        return QuestionMapper.toDto(entity);
    }

    @Override
    public void clearQuestions() {

    }
}
