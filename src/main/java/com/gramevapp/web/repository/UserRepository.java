package com.gramevapp.web.repository;

import com.gramevapp.web.model.Experiment;
import com.gramevapp.web.model.User;
import com.gramevapp.web.model.UserRegistrationDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface UserRepository  extends JpaRepository<User,Long> {
    User findByUsername(String username);
    User findByUsernameAndPassword(String username, String password);
    User findByEmailAndPassword(String email, String password);
    User findByEmail(String email);
    User save(UserRegistrationDto userRegistrationDto); // Save the new user by the register form
    User save(User user);


    @Modifying
    @Transactional
    @Query("update User u set u.userDetails.profilePicture.filePath = ?2 where u.username = ?1")
    int updateFilePath(String username, String filePath);
}