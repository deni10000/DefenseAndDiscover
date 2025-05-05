package backend.academy.modelservice;

import org.junit.jupiter.api.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test")
class ModelServiceApplicationTests {

    public static void main(String[] args) {
        SpringApplication.from(ModelServiceApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
