#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

tail -n +2 games.csv | while IFS=, read -r year round winner opponent winner_goals opponent_goals;
do 


$PSQL "INSERT INTO teams(name) VALUES ('$winner') ON CONFLICT (name) DO NOTHING;"
$PSQL "INSERT INTO teams(name) VALUES ('$opponent') ON CONFLICT (name) DO NOTHING;"
echo "Year: $year, Round: $round, Winner: $winner, Opponent: $opponent, Winner Goals: $winner_goals, Opponent Goals: $opponent_goals"
echo "Winner ID: $winner_id, Opponent ID: $opponent_id"
winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'");
opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'");
$PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)";
done