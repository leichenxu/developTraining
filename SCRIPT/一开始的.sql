create table SPRING_SESSION
(
    SESSION_ID            char(36)     not null
        primary key,
    CREATION_TIME         bigint       not null,
    LAST_ACCESS_TIME      bigint       not null,
    MAX_INACTIVE_INTERVAL int          not null,
    PRINCIPAL_NAME        varchar(100) null
);

create index SPRING_SESSION_IX1
    on SPRING_SESSION (LAST_ACCESS_TIME);


create table SPRING_SESSION_ATTRIBUTES
(
    SESSION_ID      char(36)     not null,
    ATTRIBUTE_NAME  varchar(200) not null,
    ATTRIBUTE_BYTES blob         not null,
    primary key (SESSION_ID, ATTRIBUTE_NAME),
    constraint SPRING_SESSION_ATTRIBUTES_FK
        foreign key (SESSION_ID) references SPRING_SESSION (SESSION_ID)
            on delete cascade
);

create index SPRING_SESSION_ATTRIBUTES_IX1
    on SPRING_SESSION_ATTRIBUTES (SESSION_ID);


create table diagram_data
(
    diagram_data_id    bigint auto_increment
        primary key,
    best_individual    double null,
    run_id_run_id      bigint null,
    user_id_user_id    bigint null,
    current_generation int    null,
    failed             bit    null,
    finished           bit    null,
    stopped            bit    null,
    constraint FKf5j7pguahtr4htglvimvui7y1
        foreign key (user_id_user_id) references user (user_id),
    constraint FKjq04dj6otp09hng35qnp967yn
        foreign key (run_id_run_id) references run (run_id)
);

create table diagram_pair
(
    diagram_pair_id    bigint not null
        primary key,
    best_individual    double null,
    current_generation int    null
);

create table diagram_pair_list
(
    diagram_data_id bigint null,
    diagram_pair_id bigint not null
        primary key,
    constraint FK6igixro5wgul8hvc75kmj5sse
        foreign key (diagram_data_id) references diagram_data (diagram_data_id),
    constraint FKbav0n7n177ecuu8ijp9iwmj2l
        foreign key (diagram_pair_id) references diagram_pair (diagram_pair_id)
);

create table exp_data_type_list
(
    experiment_id           bigint null,
    experiment_data_type_id bigint not null
        primary key,
    constraint FKnaoei6ntci1avr8817b0erkj4
        foreign key (experiment_id) references experiment (experiment_id)
);

create table exp_properties
(
    properties_id          bigint auto_increment
        primary key,
    bnf_path_file          varchar(255) null,
    chromosome_length      int          null,
    class_path_separator   varchar(255) null,
    crossover_prob         double       null,
    error_threshold        double       null,
    executions             int          null,
    experiment_description varchar(255) null,
    experiment_name        varchar(255) null,
    id_exp                 bigint       null,
    id_run                 bigint       null,
    initialization         varchar(255) null,
    log_population         int          null,
    logger_base_path       varchar(255) null,
    logger_level           varchar(255) null,
    max_wraps              int          null,
    model_width            int          null,
    mutation_prob          double       null,
    normalized_data        bit          null,
    num_generations        int          null,
    num_individuals        int          null,
    number_runs            int          null,
    objectives             int          null,
    real_data_copied       int          null,
    results                varchar(255) null,
    test_path              varchar(255) null,
    tournament_size        int          null,
    training_path          varchar(255) null,
    uuid_prop_dto          varchar(255) null,
    validation_path        varchar(255) null,
    view_results           bit          null,
    work_dir               varchar(255) null
);

create table expdatatype_list
(
    experiment_id         bigint null,
    experimentdatatype_id bigint not null
        primary key,
    constraint FKb2rkkceg3ppxo2usvqisrj67x
        foreign key (experiment_id) references experiment (experiment_id),
    constraint FKdnqwdjhocp54iixxons1mjf5r
        foreign key (experimentdatatype_id) references experiment_data_type (experimentdatatype_id)
);


create table experiment
(
    experiment_id          bigint auto_increment
        primary key,
    creation_date          datetime     null,
    crossover_prob         double       null,
    experiment_description varchar(255) null,
    experiment_name        varchar(255) null,
    generations            int          null,
    initialization         varchar(255) null,
    max_wraps              int          null,
    update_date            datetime     null,
    mutation_prob          double       null,
    num_codons             int          null,
    number_runs            int          null,
    objective              varchar(255) null,
    population_size        int          null,
    results                varchar(255) null,
    tournament             int          null,
    default_data_type      bigint       null,
    default_grammar        bigint       null,
    default_exp_data_type  bigint       null,
    default_run_id         bigint       null,
    constraint FK1ukdf9sa7cwpu50h01x2s6dgt
        foreign key (default_data_type) references experiment_data_type (experimentdatatype_id),
    constraint FKekij5q7quguwsivvosk9p481k
        foreign key (default_grammar) references grammar (grammar_id)
);

create table experiment_data_type
(
    experimentdatatype_id   bigint auto_increment
        primary key,
    creation_date           datetime     null,
    data_type_description   varchar(255) null,
    data_type_name          varchar(255) null,
    info                    longtext     null,
    data_type_type          varchar(255) null,
    update_date             datetime     null,
    user_id_user_id         bigint       null,
    experiment_data_type_id bigint       not null,
    run_id                  bigint       null,
    constraint FKagy8k419gredfsestpvvghlco
        foreign key (user_id_user_id) references user (user_id)
);

create table experiment_data_type_header
(
    experiment_data_type_experiment_data_type_id bigint       not null,
    header                                       varchar(255) null
);

create table experiment_row_type
(
    experimentrowtype_id                     bigint auto_increment
        primary key,
    x1                                       varchar(255) null,
    x10                                      varchar(255) null,
    x2                                       varchar(255) null,
    x3                                       varchar(255) null,
    x4                                       varchar(255) null,
    x5                                       varchar(255) null,
    x6                                       varchar(255) null,
    x7                                       varchar(255) null,
    x8                                       varchar(255) null,
    x9                                       varchar(255) null,
    y                                        varchar(255) null,
    exp_data_type_id_experimentdatatype_id   bigint       null,
    data_row                                 tinyblob     null,
    exp_data_type_id_experiment_data_type_id bigint       null,
    constraint FKgr0sg76qns4a2nib5pu4eclfg
        foreign key (exp_data_type_id_experimentdatatype_id) references experiment_data_type (experimentdatatype_id)
);
create table files_upload
(
    file_upload_id bigint auto_increment
        primary key,
    b_data         varchar(255) null,
    data           longblob     null,
    file_name      varchar(255) null
);


create table grammar
(
    grammar_id          bigint auto_increment
        primary key,
    file_text           text         null,
    grammar_description varchar(255) null,
    grammar_name        varchar(255) null,
    user_id             bigint       null,
    run_id              bigint       null,
    creation_date       datetime     null,
    constraint grammar_user_user_id_fk
        foreign key (user_id) references user (user_id)
);

create table grammar_list
(
    experiment_id bigint null,
    grammar_id    bigint not null
        primary key,
    constraint FKgkwvx8qepkv60fnfgaa43ocu9
        foreign key (experiment_id) references experiment (experiment_id),
    constraint FKrflr6gyogc45e7c7omrr9qs6b
        foreign key (grammar_id) references grammar (grammar_id)
);

create table hibernate_sequence
(
    next_val bigint null
);

INSERT INTO webge.hibernate_sequence (next_val) VALUES (141918);
create table login
(
    login_id bigint auto_increment
        primary key,
    enabled  bit          null,
    password varchar(255) null,
    username varchar(255) null
);


create table role
(
    role_id bigint auto_increment
        primary key,
    role    varchar(255) null,
    constraint UK_qwjh7xto53qcy2b835c6l4x14
        unique (role_id, role)
);

create table run
(
    run_id                   bigint auto_increment
        primary key,
    ini_date                 datetime     null,
    end_date                 datetime     null,
    run_description          varchar(255) null,
    run_name                 varchar(255) null,
    status                   int          null,
    user_id_user_id          bigint       null,
    best_individual          double       null,
    crossover_prob           double       null,
    current_generation       int          null,
    default_exp_data_type_id bigint       null,
    default_grammar_id       bigint       null,
    default_run_id           bigint       null,
    experiment_description   varchar(255) null,
    experiment_name          varchar(255) null,
    generations              int          null,
    id_properties            bigint       null,
    initialization           varchar(255) null,
    max_wraps                int          null,
    modification_date        datetime     null,
    mutation_prob            double       null,
    num_codons               int          null,
    number_runs              int          null,
    objective                varchar(255) null,
    population_size          int          null,
    results                  varchar(255) null,
    threa_id                 bigint       null,
    tournament               int          null,
    constraint FKd3qi7xda0bi67jpf9st7fycsp
        foreign key (user_id_user_id) references user (user_id)
);

create table runs_list
(
    experiment_id bigint null,
    run_id        bigint not null
        primary key,
    constraint FKft4o051nko993qllhojv197uw
        foreign key (experiment_id) references experiment (experiment_id),
    constraint FKqkfuuw440oivaupp37ejsi0ce
        foreign key (run_id) references run (run_id)
);

create table upload_file
(
    upload_file_id bigint       not null
        primary key,
    file_name      varchar(255) null,
    file_path      varchar(255) null
);


create table user
(
    user_id               bigint auto_increment
        primary key,
    about_me              varchar(255) null,
    address_direction     varchar(255) null,
    city                  varchar(255) null,
    email                 varchar(255) not null,
    enabled               bit          null,
    failed_login_attempts int          null,
    first_name            varchar(255) null,
    last_name             varchar(255) null,
    password              varchar(255) not null,
    phone                 int          null,
    state                 varchar(255) null,
    study_information     varchar(255) null,
    username              varchar(255) not null,
    work_information      varchar(255) null,
    zipcode               int          null,
    file_upload_id        bigint       null,
    constraint UK_aatxaj93xka096nsl0a7vqua7
        unique (file_upload_id),
    constraint UK_ku8s9ykb4c149v6ttg9nuypsx
        unique (user_id, username, email),
    constraint FK8b31fw00ncylsna7cqt437xgv
        foreign key (file_upload_id) references files_upload (file_upload_id)
);

create table user_details
(
    user_id            bigint       not null
        primary key,
    about_me           varchar(255) null,
    address_direction  varchar(255) null,
    city               varchar(255) null,
    first_name         varchar(255) null,
    last_name          varchar(255) null,
    phone              int          null,
    state              varchar(255) null,
    study_information  varchar(255) null,
    work_information   varchar(255) null,
    zipcode            int          null,
    profile_picture_id bigint       null,
    user_user_id       bigint       null,
    constraint UK_710yg7mjb82m7lurl0dh4sqgb
        unique (profile_picture_id)
);

create table users_experiments
(
    user_id       bigint null,
    experiment_id bigint not null
        primary key,
    constraint FK3w4wgjkf0iy5krfy6vfglno5p
        foreign key (user_id) references user (user_id),
    constraint FKj6ges712i1qrsicxr4ghobjo4
        foreign key (experiment_id) references experiment (experiment_id)
);

create table users_roles
(
    user_id   bigint       not null,
    username  varchar(255) not null,
    email     varchar(255) not null,
    role_id   bigint       not null,
    role_name varchar(255) not null
);
