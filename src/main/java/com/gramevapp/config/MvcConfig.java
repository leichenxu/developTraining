package com.gramevapp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

// https://dzone.com/articles/spring-security-4-authenticate-and-authorize-users
@Configuration
public class MvcConfig extends WebMvcConfigurerAdapter {
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // https://docs.spring.io/spring-security/site/docs/4.2.3.RELEASE/guides/html5/form-javaconfig.html#creating-a-login-page
        /*registry.addViewController("/login").setViewName("login");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);*/

        //registry.addViewController("/index").setViewName("index");
        registry.addViewController("/").setViewName("home");
        registry.addViewController("/403").setViewName("403");
    }

    @Bean(name = "dataSource")
    public DriverManagerDataSource dataSource() {
        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        driverManagerDataSource.setUrl("jdbc:mysql://localhost:3306/webge?autoReconnect=true&useSSL=false&serverTimezone=UTC");
        driverManagerDataSource.setUsername("usuario");
        driverManagerDataSource.setPassword("01234");
        return driverManagerDataSource;
    }

    /*@Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/jsp/");
        resolver.setSuffix(".jsp");
        return resolver;
    }*/
}