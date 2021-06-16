# Exercices SQL – Base de données des villes de France

Un cours sur le langage SQL n’est vraiment utile que si on essai de le mettre en pratique dans un contexte d’usage réel.

## Prérequis

Il convient de télécharger les bases de données d’exemples, qui seront utilisées au sein des exercices.

### Table “[villes de France](villes_france.sql.gz)” (8.4Mo)

### Table “[départements de France](departement.sql.gz)” (7.9Ko)

**\*Astuces** : gardez une sauvegarde de ces tables avant d’effectuer les exercices.\*

## Exercices (requêtes SQL)

Veuillez trouver les requêtes SQL permettant d’effectuer chacune des demandes suivantes :

1. Obtenir la liste des 10 villes les plus peuplées en 2012.

2. Obtenir la liste des 50 villes ayant la plus faible superficie.

3. Obtenir la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97”.

4. Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé.

5. Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes.

6. Obtenir la liste des 10 plus grands départements, en terme de superficie.

7. Compter le nombre de villes dont le nom commence par “Saint”.

8. Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier celles dont le nom est le plus souvent utilisé par plusieurs communes

9. Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne.

10. Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants

11. Remplacez le tiret par un espace, pour toutes les villes commençant par “SAINT-” (dans la colonne qui contient les noms en majuscule)

12. Obtenir la liste des villes qui ont entre 10000 et 100000 habitants.

13. Obtenir la liste des villes en remplaçant "Saint-" par "Saint " de la colonne `ville_nom_reel` pour les villes dont le nom commence par "Saint-". Afficher une colonne `ville_taille` qui affiche 'Grande ville' (>100000 habitants), 'Ville moyenne' (entre 10000 et 100000), 'Village' (<10000).

14. Ajouter un champ `ville_nom_fix` avec "Saint-" remplacé par "Saint " ainsi qu'un champ `ville_taille` (`ENUM('Grande ville', 'Ville Moyenne', 'Village')`).
