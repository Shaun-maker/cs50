-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Commande pour avoir la description des crimes ayant eu lieu le même jour, mois, année que le canard volé de CS50. Heure : 10: 15.
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND year = 2021;


-- Avoir l'activité de la boulangerie le jour J
SELECT activity, license_plate, hour, minute FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28;


-- Beaucoup de résultat den om avec celle-ci.
SELECT name FROM people WHERE license_plate = "5P2BI95" OR "94KL13X" OR "6P58WS2";


-- Ici, focus sur la première personne à être sorti de la boulangerie après le vol, à 10h 16
SELECT name, phone_number, passport_number FROM people WHERE license_plate = "5P2BI95";


-- TOut les appels ayant eu lieu le jour J. Trop de résultat ...
SELECT caller, receiver, duration FROM phone_calls WHERE year = 2021 AND day = 28 AND month = 7;


-- Un appel de ma première suspect le jour J, Vanessa.
SELECT caller, receiver, duration FROM phone_calls WHERE year = 2021 AND day = 28 AND month = 7 AND caller = "(725) 555-4692";


-- Aucune Interview de Vanessa ne sort, et l'interview de Amanda ne donne rien, elle parle d'un docteur ...
SELECT name, transcript FROM interviews WHERE name = "Vanessa" OR name = "Amanda";


-- Interviews de Bruce, plutôt intéressant :) Barry ne donne rien.
SELECT name, transcript FROM interviews WHERE name = "Bruce";



-- Compte en banque de mon principal (et unique ...) suspect, Bruce.
SELECT account_number, creation_year FROM bank_accounts
JOIN people ON person_id = people.id
WHERE people.name = "Bruce";


-- Toute les infos de Bruce
SELECT name, phone_number, passport_number, license_plate FROM people WHERE name = "Bruce";


-- Tout les appels de Bruce. Tous gravite autours de la date du vol (28 Juillet 2021). Ca, c'est vraiment suspect :p
SELECT caller, receiver, duration, day, month, year FROM phone_calls WHERE caller = "(367) 555-5533";


-- Interviews des appels de Bruce le jour J. Carl et Gregory ont bien un résulat, et celui-ci parle des mêmes personnages, Jones (un gros) et M Merryweather, directeur de banque mince.
SELECT name, day, month, year, transcript FROM interviews WHERE name = "Carl" OR name = "Gregory" Or name = "Deborah";


-- Numéro de Carl et Gregory
SELECT name, phone_number FROM people WHERE name = "Carl" OR name = "Gregory";


-- Appel de Gregory. Tous autous du jour J.
SELECT caller, receiver, day, month, year, duration FROM phone_calls WHERE caller = "(022) 555-4052";


-- Appel de Carl, tous autours du jour J.
SELECT caller, receiver, day, month, year, duration FROM phone_calls WHERE caller = "(704) 555-5790";


-- Appel de Deborah. Gravite aussi autours du jour J.
SELECT caller, receiver, day, month, year, duration FROM phone_calls WHERE caller  = "(344) 555-9601";


-- Pour avoir tout les retraits de la personne concerné, avec la date et le lieu. Seul Bruce à retirer de l'argent ? Les autres n'ont pas de compte en banque ...
SELECT amount, transaction_type, atm_location, day, month, year FROM atm_transactions WHERE account_number IN
    (SELECT account_number FROM bank_accounts WHERE person_id IN
        (SELECT id FROM people WHERE name = "Bruce"));


-- Pour avoir le passport_number de tout mes suspect, et ainsi regarder les vols.
SELECT name, passport_number FROM people WHERE name = "Bruce" OR name = "Gregory" OR name = "Carl" OR name = "Deborah";


-- Les deux voleurs
SELECT name, passport_number FROM people WHERE name = "Bruce" OR name = "Robin";


SELECT account_number FROM bank_accounts WHERE person_id IN (SELECT id FROM people WHERE name = "Robin");


SELECT account_number, amount, transaction_type, day, month, year FROM atm_transactions WHERE account_number IN
(SELECT account_number FROM bank_accounts WHERE person_id IN (SELECT id FROM people WHERE name = "Robin"));


-- Avoir le flight_id de mes principals suspects.
SELECT flight_id, passport_number, seat FROM passengers WHERE passport_number = 3355598951 OR passport_number = 7771405611 OR passport_number = 5773159633 OR passport_number = 8714200946;


-- Les dates des vols de mes 4 suspects, avec l'id de destination/départ. Beaucoup de résultat ...
SELECT origin_airport_id, destination_airport_id, day, month, year, hour, minute FROM flights WHERE id IN
    (SELECT flight_id FROM passengers
        WHERE passport_number = 3355598951 OR passport_number = 7771405611 OR passport_number = 5773159633 OR passport_number = 8714200946);


-- Vol uniquement de Bruce
SELECT origin_airport_id, destination_airport_id, day, month, year, hour, minute FROM flights WHERE id IN
     (SELECT flight_id FROM passengers
         WHERE passport_number = 5773159633);

-- Selection sauvage des autres suspects. Ici, tout correspont pour que Carl soit celui qui a aidé Bruce.
SELECT origin_airport_id, destination_airport_id, day, month, year, hour, minute FROM flights WHERE id IN
     (SELECT flight_id FROM passengers
         WHERE passport_number = 7771405611);


SELECT origin_airport_id, destination_airport_id, day, month, year, hour, minute FROM flights WHERE id IN
     (SELECT flight_id FROM passengers
         WHERE passport_number = 3355598951);