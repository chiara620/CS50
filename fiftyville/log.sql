-- Keep a log of any SQL queries you execute as you solve the mystery.

-- view ehat police thinks about the crime
SELECT * FROM crime_scene_reports WHERE day = 28 and month = 7 and year = 2021;
-- Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery.

-- view the interviews of the witnesses
SELECT * FROM interviews WHERE day = 28 and month = 7 and year = 2021;
-- | 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
-- | 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
-- | 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, i heard the thief say that thay were planning to take the earliest flight out of fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- discover thief car plate
SELECT license_plate FROM bakery_security_logs WHERE day = 28 and month = 7 and year = 2021 and hour = 10 and activity = 'exit';

-- discover the names of who withdrawed money from the ATM in Leggett street
SELECT * FROM atm_transactions WHERE day = 28 and month = 7 and year = 2021 and atm_location = 'Leggett Street';
SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street';
SELECT * from people WHERE id IN (SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street');
SELECT * from people WHERE people.id IN (SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street') AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 and month = 7 and year = 2021 and hour = 10 and activity = 'exit');

-- discover the accomplice
SELECT receiver FROM phone_calls WHERE caller IN (SELECT phone_number from people WHERE people.id IN (SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street') AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 and month = 7 and year = 2021 and hour = 10 and activity = 'exit')) and day = 28 and month = 7 and year = 2021 and duration < 60;

-- add flight informations
SELECT * FROM airports where city = 'Fiftyville'; -- id is 8
SELECT * FROM flights where origin_airport_id = 8 ORDER BY day; -- first flight the 29th of July is ID = 36
SELECT * FROM passengers WHERE passport_number IN (SELECT passport_number from people WHERE people.id IN (SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street') AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 and month = 7 and year = 2021 and hour = 10 and activity = 'exit')) and flight_id = 36;

-- add phone informations
SELECT id FROM people WHERE passport_number in (SELECT passport_number FROM passengers WHERE passport_number IN (SELECT passport_number from people WHERE people.id IN (SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street') AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 and month = 7 and year = 2021 and hour = 10 and activity = 'exit')) and flight_id = 36);
SELECT caller FROM phone_calls WHERE id IN (SELECT id FROM people WHERE passport_number in (SELECT passport_number FROM passengers WHERE passport_number IN (SELECT passport_number from people WHERE people.id IN (SELECT person_id FROM bank_accounts JOIN atm_transactions ON bank_accounts.account_number = atm_transactions.account_number WHERE atm_transactions.day = 28 and atm_transactions.month = 7 and atm_transactions.year = 2021 and atm_transactions.atm_location = 'Leggett Street') AND people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE day = 28 and month = 7 and year = 2021 and hour = 10 and activity = 'exit')) and flight_id = 36)) AND year = 2021 AND month = 7 AND day = 28 and duration < 60;