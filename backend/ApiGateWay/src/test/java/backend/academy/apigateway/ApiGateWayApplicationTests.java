package backend.academy.apigateway;

import org.junit.jupiter.api.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ApiGateWayApplicationTests {

    public static void main(String[] args) {
        SpringApplication.from(ApiGateWayApplication::main).with(TestcontainersConfiguration.class).run(args);
    }
}
