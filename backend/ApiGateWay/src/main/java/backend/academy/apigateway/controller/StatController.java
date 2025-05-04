package backend.academy.apigateway.controller;

import backend.academy.apigateway.client.StatClient;
import backend.academy.apigateway.dto.StatCounterDto;
import backend.academy.apigateway.utils.ApiPaths;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@Tag(name = "Статистика", description = "Получить статистику")
public class StatController {

    private final StatClient statClient;

    @GetMapping(ApiPaths.BASE_API+"/getStats")
    @Operation(summary = "Получить записи статистики о достижении зарегистрированных игроков")
    public ResponseEntity<List<StatCounterDto>> getAllStats(){
        return ResponseEntity.ok(statClient.getAllStats());
    }

}
