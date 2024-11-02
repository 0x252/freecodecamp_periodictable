if [[ -z $1 ]];
then
	echo "Please provide an element as an argument."
	exit;
fi
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ ! $1 =~ ^[0-9]+$ ]]; then
 export element=$($PSQL "SELECT * FROM elements LEFT JOIN properties using(atomic_number) WHERE symbol='$1' OR name='$1';")
else
 export element=$($PSQL "SELECT * FROM elements LEFT JOIN properties using(atomic_number) WHERE atomic_number='$1';")
fi
if [[ -z $element ]];
then
echo "I could not find that element in the database."
else
#IFS='|' echo $element | read -l atomic_number elemnt
IFS='|' read -r atomic_number element_name element_symbol type atomic_mass melting_point boiling_point _ <<< "$element"
echo "The element with atomic number $atomic_number is $element_symbol ($element_name). It's a $type, with a mass of $atomic_mass amu. $element_name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
fi
