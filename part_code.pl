
compatible(X, Y) :- compatible_product(Y, X); compatible_product(X, Y).

choose_processor(USER_CATEGORY, CHOSEN) :-
    
    % Present the prompt
    write("\n\n Please Choose Processor"), nl,
    
    % Present all the choices according to User
    forall(category(PRODUCTS, processor, USER_CATEGORY), (write(PRODUCTS), nl)),

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, processor, USER_CATEGORY))->
        !
        ;
        write("Error Invalid Choice"), nl, 
        choose_processor(USER_CATEGORY, CHOSEN).

choose_motherboard(USER_CATEGORY, PROCESSOR, CHOSEN):-
    
    % Present the prompt
    write("\n\n Please Choose a Motherboard"), nl,

    % Present all the choices according to needs and compatibility
    forall(
        (category(PRODUCTS, motherboard, USER_CATEGORY), compatible(PRODUCTS, PROCESSOR)),
        (write(PRODUCTS), nl)
        ),

    % Get the response
    read(CHOSEN),

    (category(CHOSEN, motherboard, USER_CATEGORY), compatible(CHOSEN, PROCESSOR))->
        !
        ;
        write("Error Invalid Choice"), nl, 
        choose_motherboard(USER_CATEGORY, PROCESSOR, CHOSEN).

choose_storage(USER_CATEGORY, CHOSEN, AMOUNT)

start:-
    choose_processor(casual, PROCESSOR),
    choose_motherboard(casual, PROCESSOR, MOTHERBOARD),
    write("\n\nYou Chose"),nl,
    write(PROCESSOR), nl,
    write(MOTHERBOARD).

%   Displays and prompts user to choose one of the product
%   USER_CATEGORY is the Type of the user(casual/gaming/workbench)
%   CHOSEN is the product chosen by the user 
choose_product(USER_CATEGORY,PRODUCT_TYPE, CHOSEN):-
    
    % Write the Prompts
    write("\n\nChoosing "),write(PRODUCT_TYPE),nl,
    write("Please Pick a product from the provided list:\n"),

    % Prints out all the prducts according to product type and user category
    forall(category(PRODUCTS, PRODUCT_TYPE, USER_CATEGORY), (write(PRODUCTS),nl)),

    % Get the user response
    read(CHOSEN),

    % Get the list of the valid entries again, so that we can check the validity of input
    category(PRODUCTS, PRODUCT_TYPE, USER_CATEGORY),

    % Check user choice against the valid response
    (CHOSEN=@=PRODUCTS) ->
        % Input valid
        % Return normal
        !
        ;
        % The response is not valid
        write("\nError\n Please Choose a valid response\n"),
        choose_product(USER_CATEGORY, PRODUCT_TYPE, CHOSEN).
        
% loop_choices(USER_CATEGORY, )

starast :-
    write("Welcome to PC Part Picker"), nl,
    write("Lets start with the usage."), nl,
    write("\n\nHow are you going to be using the system:"), nl,
    write("gaming\ncasual\nworkbench\n"),
    read(USER_CATEGORY),
    choose_product(USER_CATEGORY,processor,PROCESSOR),
    choose_product(USER_CATEGORY,graphic_card,GRAPHIC_CARD),
    choose_product(USER_CATEGORY,ram,RAM),
    write("\n\n You Chose"),nl,
    write(PROCESSOR),nl,write(GRAPHIC_CARD), nl, write(RAM),nl,
    cost(PROCESSOR,PROCESSOR_COST),cost(GRAPHIC_CARD,GRAPHIC_CARD_COST),cost(RAM, RAM_COST),
    write(PROCESSOR_COST),nl,write(GRAPHIC_CARD_COST),nl,write(RAM_COST),nl,
    TOTAL_COST is PROCESSOR_COST + GRAPHIC_CARD_COST + RAM_COST,
    write("TOTAL_COST"),write(TOTAL_COST).

find_mb(USER_CATEGORY, MB, PROCESSOR):-
    category(MB, motherboard, USER_CATEGORY), compatible(MB, PROCESSOR).

tempst:-
    write("Please Enter the CPU :"),
    read(A),
    forall(find_mb(casual, MB, A), (write(MB),nl)),
    read(RMB),
    find_mb(casual, RMB, A) ->
    write("FOUND");write("No scuh Product").


tt:-
    forall((category(MB, motherboard, casual), compatible(MB, intel_i3)), (write(MB), nl)).