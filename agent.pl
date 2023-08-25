% Knowledge base - Food items, nutritional values, dietary restrictions

% Define food items and their nutritional values
food(apple, fruit, 52, 0.2, 13.8, 0.2, vitamins(a, c)).
food(banana, fruit, 96, 0.3, 22, 0.3, vitamins(a, c)).
food(chicken_breast, meat, 165, 3.6, 31, 3.6, vitamins(b12)).
food(salmon, fish, 206, 13, 0, 20, vitamins(d, b12)).
% Add more food items and their nutritional values

% Define dietary restrictions and allergies
restriction(diabetes, [sugar, honey]).
restriction(hypertension, [salt]).
% Add more dietary restrictions and allergies

% User input predicates
get_personal_info(Age, Gender, Weight, Height, ActivityLevel) :-
    write('Please enter your personal information:'), nl,
    write('Age: '),
    read(Age),
    write('Gender (male/female): '),
    read(Gender),
    write('Weight (in kg): '),
    read(Weight),
    write('Height (in cm): '),
    read(Height),
    write('Activity Level (low/medium/high): '),
    read(ActivityLevel).

get_dietary_preferences(DietaryPreferences) :-
    write('Please enter your dietary preferences (comma-separated): '),
    read(DietaryPreferences).

get_health_conditions(Conditions) :-
    write('Please enter your health conditions (comma-separated): '),
    read(Conditions).

% Rule to infer dietary requirements based on user information
infer_dietary_requirements(Age, Gender, Weight, Height, ActivityLevel, Conditions) :-
    % Add rules to infer dietary requirements based on user information
    write('Your dietary requirements: High protein, moderate carbohydrates, and moderate fats.'), nl.

% Rule to suggest a food item based on dietary preferences and health conditions
suggest_food_item(Item, Preferences, Conditions) :-
    suitable_food(Item, Preferences),
    suitable_food(Item, Conditions),
    food(Item, _, _, _, _, _, _).

% Rule to check if a food item is suitable for an individual based on dietary preferences
suitable_food(Item, Preferences) :-
    food(Item, _, _, _, _, _, _),
    \+ member(restricted_food(Item), Preferences).

% Rule to check if a food item is suitable for an individual based on health conditions
suitable_food(Item, Conditions) :-
    food(Item, _, _, _, _, _, _),
    \+ (member(Condition, Conditions), restriction(Condition, RestrictedFoods), member(Item, RestrictedFoods)).

% Rule to suggest a meal plan based on dietary preferences, nutritional requirements, and health conditions
suggest_meal_plan(DietaryPreferences, Calories, Conditions) :-
    write('Your personalized meal plan:'), nl,
    write('Breakfast:'), nl,
    random_food_item(Breakfast, DietaryPreferences, Conditions),
    write(Breakfast), nl,

    write('Lunch:'), nl,
    random_alternative_food(Breakfast, DietaryPreferences, Conditions, Lunch),
    write(Lunch), nl,

    write('Dinner:'), nl,
    random_alternative_food(Breakfast, DietaryPreferences, Conditions, Dinner),
    write(Dinner), nl,

    write('Snacks:'), nl,
    random_alternative_food(Breakfast, DietaryPreferences, Conditions, Snacks),
    write(Snacks), nl.

% Rule to randomly select a food item based on dietary preferences and health conditions
random_food_item(Item, Preferences, Conditions) :-
    findall(Food, suggest_food_item(Food, Preferences, Conditions), FoodList),
    random_member(Item, FoodList).

% Rule to randomly select an alternative food item for a meal
random_alternative_food(Item, Preferences, Conditions, Alternative) :-
    findall(Food, find_alternative_food(Item, Preferences, Conditions, Food), AlternativeList),
    random_member(Alternative, AlternativeList).

% Rule to find an alternative food item for a meal
find_alternative_food(Item, Preferences, Conditions, Alternative) :-
    food(Alternative, _, _, _, _, _, _),
    \+ (Alternative = Item, suitable_food(Item, Preferences), suitable_food(Item, Conditions)).

% Rule to track consumed meals
track_meal(Item, Calories) :-
    % Add rules to track consumed meals
    write('Meal tracked: '), write(Item), write(' (Calories: '), write(Calories), write(')'), nl.

% Rule to calculate total calorie intake
calculate_total_calories(TotalCalories) :-
    % Add rules to calculate total calorie intake
    write('Total calorie intake: '), write(TotalCalories), write(' calories.'), nl.

% Rule to suggest alternatives for a specific food item
suggest_alternatives(Item) :-
    % Add rules to suggest alternatives for a specific food item
    write('Alternatives for '), write(Item), write(':'), nl,
    write('Alternative 1'), nl,
    write('Alternative 2'), nl.

% Rule to provide tips for a healthy lifestyle
provide_tips :-
    % Add rules to provide tips for a healthy lifestyle
    write('Tip 1: Eat a variety of fruits and vegetables.'), nl,
    write('Tip 2: Drink plenty of water throughout the day.'), nl.

% Main predicate
main :-
    get_personal_info(Age, Gender, Weight, Height, ActivityLevel),
    get_dietary_preferences(DietaryPreferences),
    get_health_conditions(Conditions),
    infer_dietary_requirements(Age, Gender, Weight, Height, ActivityLevel, Conditions),
    write('Please enter your daily calorie requirement: '),
    read(Calories),
    suggest_meal_plan(DietaryPreferences, Calories, Conditions),
    write('Please enter the consumed meal (or "quit" to exit): '),
    read(ConsumedMeal),
    (ConsumedMeal \= quit ->
        write('Please enter the calories of the consumed meal: '),
        read(ConsumedCalories),
        track_meal(ConsumedMeal, ConsumedCalories),
        calculate_total_calories(_TotalCalories),
        write('Please enter a specific food item to get alternatives (or "quit" to exit): '),
        read(Item),
        (Item \= quit ->
            suggest_alternatives(Item),
            provide_tips,
            main
        ; true)
    ; true).

% Start the program
:- initialization(main).
