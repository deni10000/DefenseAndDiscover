package backend.academy.userservice.repository;

import backend.academy.userservice.model.Role;
import backend.academy.userservice.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findByName(String name);
    Optional<User> findFirstByName(String username);
}