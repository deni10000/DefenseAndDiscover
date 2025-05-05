package backend.academy.notificationservice;

import org.junit.jupiter.api.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

@SpringBootTest
class NotificationServiceApplicationTests {


    public static void main(String[] args) {
        SpringApplication.from(NotificationServiceApplication::main).with(TestcontainersConfiguration.class).run(args);
    }

}
