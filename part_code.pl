user_category(casual).
user_category(workbench).
user_category(gaming).

compatible(X, Y) :- compatible_product(Y, X); compatible_product(X, Y).

choose_processor(USER_CATEGORY, CHOSEN) :-
    
    % Present the prompt
    write("\n\nAvailable Processors"), nl,
    
    % Present all the choices according to User
    forall(category(PRODUCTS, processor, USER_CATEGORY), (write(PRODUCTS), nl)),

    write("Please choose a Processor: "), nl,

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, processor, USER_CATEGORY))->
        !
        ;
        write("Error,\nInvalid Processor Choice"),
        choose_processor(USER_CATEGORY, CHOSEN).

choose_graphic_card(USER_CATEGORY, CHOSEN) :-
    
    % Present the prompt
    write("\n\nAvailable Graphics Card"), nl,
    
    % Present all the choices according to User
    forall(category(PRODUCTS, graphic_card, USER_CATEGORY), (write(PRODUCTS), nl)),

    write("Please choose a Graphics Card: "), nl,

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, graphic_card, USER_CATEGORY))->
        !
        ;
        write("Error,\nInvalid Graphic Card Choice"),
        choose_graphic_card(USER_CATEGORY, CHOSEN).

choose_motherboard(USER_CATEGORY, PROCESSOR, CHOSEN):-
    
    % Present the prompt
    write("\n\nAvailable Motherboards"), nl,

    % Present all the choices according to needs and compatibility
    forall(
        (category(PRODUCTS, motherboard, USER_CATEGORY), compatible(PRODUCTS, PROCESSOR)),
        (write(PRODUCTS), nl)
        ),

    write("Please choose a MotherBoard: "),  nl,

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, motherboard, USER_CATEGORY), compatible(CHOSEN, PROCESSOR))->
        !
        ;
        write("Error,\nInvalid Motherboard Choice"), 
        choose_motherboard(USER_CATEGORY, PROCESSOR, CHOSEN).

choose_storage(USER_CATEGORY, CHOSEN):-

    % Present the prompt
    write("\n\nAvailable Storages"), nl,

    % Present all the choices according to needs and compatibility
    forall(
        (category(PRODUCTS, storage, USER_CATEGORY)),
        (write(PRODUCTS), nl)
        ),

    write("Please choose a Storage: "),  nl,

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, storage, USER_CATEGORY))->
        !
        ;
        write("Error Invalid Storage Choice"), nl, 
        choose_storage(USER_CATEGORY, CHOSEN).


choose_ram(USER_CATEGORY, MOTHERBOARD, CHOSEN):-
    
    % Present the prompt
    write("\n\nAvailable RAM sticks"), nl,

    % Present all the choices according to needs and compatibility
    forall(
        (category(PRODUCTS, ram, USER_CATEGORY), compatible(PRODUCTS, MOTHERBOARD)),
        (write(PRODUCTS), nl)
        ),

    write("Please choose a RAM stick: "),  nl,

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, ram, USER_CATEGORY), compatible(CHOSEN, MOTHERBOARD))->
        !
        ;
        write("Error,\nInvalid RAM Choice"), 
        choose_ram(USER_CATEGORY, MOTHERBOARD, CHOSEN).


get_user_category(USER_CATEGORY):-
    % User Usage Type Input and Prompt
    write("\n\nHow are you going to be using the system:"), nl,
    write("gaming\ncasual\nworkbench\n"),

    read(USER_CATEGORY),
    
    user_category(USER_CATEGORY) ->
    !
    ;
    write("Error,\nInvalid User Category Choice"), 
    get_user_category(USER_CATEGORY).



start :-
    % Prompts
    write("Welcome to PC Part Picker"), nl,
    write("Lets start with the usage."), nl,
    
    get_user_category(USER_CATEGORY),

    % Processor
    choose_processor(USER_CATEGORY, PROCESSOR),
    
    % Graphic Card
    choose_graphic_card(USER_CATEGORY, GRAPHIC_CARD),
    
    % MotherBoard
    choose_motherboard(USER_CATEGORY, PROCESSOR, MOTHERBOARD),
    
    % RAM
    choose_ram(USER_CATEGORY, MOTHERBOARD, RAM),
    
    % Storage
    choose_storage(USER_CATEGORY, STORAGE),

    % Getting the costs of the products
    cost(PROCESSOR,PROCESSOR_COST),
    cost(GRAPHIC_CARD,GRAPHIC_CARD_COST),
    cost(RAM,RAM_COST),
    cost(MOTHERBOARD,MOTHERBOARD_COST),
    cost(STORAGE, STORAGE_COST),
    TOTAL_COST is PROCESSOR_COST + GRAPHIC_CARD_COST + RAM_COST + MOTHERBOARD_COST + STORAGE_COST,

    % Printing out the products along with estimated cost
    write("\n\n The Selected Components :-"),nl,
    write(("Processor :", PROCESSOR, ", Rs :", cost(PROCESSOR_COST))), nl,
    write(("Graphic Card: ", GRAPHIC_CARD, ", Rs :", cost(GRAPHIC_CARD_COST))), nl,
    write(("MotherBoard: ", MOTHERBOARD, ", Rs :", cost(MOTHERBOARD_COST))), nl,
    write(("RAM: ", RAM,", Rs :", cost(MOTHERBOARD_COST))), nl,
    write(("Storage: ", STORAGE, ", Rs :", cost(PROCESSOR_COST))), nl, nl,
    write(("Total Estimated Cost for the PC Build\nRs :", TOTAL_COST)),nl,nl,
    
    write("Above Mentioned prices are estimates and may change. "), nl.
