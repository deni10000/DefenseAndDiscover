package backend.academy.userservice.service;

import backend.academy.userservice.model.Category;
import backend.academy.userservice.repository.CategoryRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @PostConstruct
    public void init() {
        saveCategoryIfNotExists("history");
        saveCategoryIfNotExists("science");
        saveCategoryIfNotExists("culture");
        saveCategoryIfNotExists("nature");
    }

    private void saveCategoryIfNotExists(String name) {
        if (!categoryRepository.findByName(name).isPresent()) {
            categoryRepository.save(Category.builder().name(name).build());
        }
    }
}
