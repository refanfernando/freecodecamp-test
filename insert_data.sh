#! /bin/bash

# pg_dump -cC --inserts -U freecodecamp worldcup > worldcup.sql

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
  echo $($PSQL "TRUNCATE games, teams")
  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WG OG
  do
    if [[ $YEAR != "year" ]]
      then
        # get winner id
        WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name ='$WINNER'")"
          if [[ -z $WINNER_ID ]]
            then
            INSERT_TEAMS_RESULT="$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")"
              if [[ $INSERT_TEAMS_RESULT == 'INSERT 0 1' ]]
                then
                  echo "Inserted into teams $WINNER"
                fi
          fi
        # get opponent id
        OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name ='$OPPONENT'")"
          if [[ -z $OPPONENT_ID ]]
            then
            INSERT_TEAMS_RESULT="$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")"
              if [[ $INSERT_TEAMS_RESULT == 'INSERT 0 1' ]]
                then
                  echo "Inserted into teams $OPPONENT"
                fi
          fi
        # Insert into games
        WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
        OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"

        RESULT_INSERT_GAMES="$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WG,$OG)")"
        if [[ $RESULT_INSERT_GAMES == 'INSERT 0 1' ]]
          then
            echo "RESULT_INSERT_GAMES SUCCESSFULLY"
          else
            echo "RESULT_INSERT_GAMES FAIL $RESULT_INSERT_GAMES"
            exit
        fi
    fi
  done
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
  echo $($PSQL "TRUNCATE games, teams")
  cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WG OG
  do
    if [[ $YEAR != "year" ]]
      then
        # get winner id
        WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name ='$WINNER'")"
          if [[ -z $WINNER_ID ]]
            then
            INSERT_TEAMS_RESULT="$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")"
              if [[ $INSERT_TEAMS_RESULT == 'INSERT 0 1' ]]
                then
                  echo "Inserted into teams $WINNER"
                fi
          fi
        # get opponent id
        OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name ='$OPPONENT'")"
          if [[ -z $OPPONENT_ID ]]
            then
            INSERT_TEAMS_RESULT="$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")"
              if [[ $INSERT_TEAMS_RESULT == 'INSERT 0 1' ]]
                then
                  echo "Inserted into teams $OPPONENT"
                fi
          fi
        # Insert into games
        WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")"
        OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")"

        RESULT_INSERT_GAMES="$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WG,$OG)")"
        if [[ $RESULT_INSERT_GAMES == 'INSERT 0 1' ]]
          then
            echo "RESULT_INSERT_GAMES SUCCESSFULLY"
          else
            echo "RESULT_INSERT_GAMES FAIL $RESULT_INSERT_GAMES"
            exit
        fi
    fi
  done
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
