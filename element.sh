Last login: Tue Jul  5 15:43:44 on console
(base) murillo@MacBook-Air-de-Murillo ~ % vim






















    if [[ $1 =~ ^[0-9]+$ ]]
      then
        GET_ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING (atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1")
      else 
        GET_ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING (atomic_number) JOIN types USING(type_id) WHERE name LIKE '$1%' ORDER BY atomic_number LIMIT 1")
    fi
      if [[ -z $GET_ELEMENT ]]
      then
        echo "I could not find that element in the database."
      else
        echo $GET_ELEMENT | while IFS=\| read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done

