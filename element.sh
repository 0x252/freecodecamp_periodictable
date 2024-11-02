if [[ -z $1 ]];
then
	echo "Please provide an element as an argument."
	exit;
fi
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ ! $1 =~ ^[0-9]+$ ]]; then
 export element=$($PSQL "SELECT * FROM elements LEFT JOIN properties using(atomic_number) INNER JOIN types using(type_id) WHERE symbol='$1' OR name='$1';")
else
 export element=$($PSQL "SELECT * FROM elements LEFT JOIN properties using(atomic_number) INNER JOIN types using(type_id) WHERE atomic_number='$1';")
fi
if [[ -z $element ]];
then
echo "I could not find that element in the database."
else
#echo $element
#1|1|H|Hydrogen|1.008|-259.1|-252.9|nonmetal
IFS='|' read -r atomic_number a1 element_symbol element_name atomic_mass melting_point boiling_point idk type <<< "$element"
echo "The element with atomic number $a1 is $element_name ($element_symbol). It's a $idk, with a mass of $atomic_mass amu. $element_name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."

fi
