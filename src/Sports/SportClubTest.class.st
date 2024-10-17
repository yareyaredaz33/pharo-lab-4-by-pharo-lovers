Class {
	#name : 'SportClubTest',
	#superclass : 'TestCase',
	#instVars : [
		'myClub',
		'athlete1',
		'athlete2',
		'athlete3',
		'athlete4'
	],
	#category : 'Sports-Tests',
	#package : 'Sports',
	#tag : 'Tests'
}

{ #category : 'running' }
SportClubTest >> setUp [ 
    myClub := SportClub new initializeWithName: 'Test Club'.
    
    athlete1 := FootballPlayer new initializeWithLastName: 'Smith' age: 28 nationality: 'USA' club: 'Best FC' contract: 60000 goals: 15.
    athlete2 := TennisPlayer new initializeWithLastName: 'Johnson' age: 24 nationality: 'UK' worldRanking: 8 earnings: #(10000 12000 9000).
    athlete3 := FootballPlayer new initializeWithLastName: 'Miller' age: 22 nationality: 'Germany' club: 'Eagles FC' contract: 70000 goals: 20.
    athlete4 := TennisPlayer new initializeWithLastName: 'Williams' age: 30 nationality: 'France' worldRanking: 25 earnings: #(15000 18000 16000).

    myClub addSportsperson: athlete1.
    myClub addSportsperson: athlete2.
    myClub addSportsperson: athlete3.
    myClub addSportsperson: athlete4.


]

{ #category : 'running' }
SportClubTest >> tearDown [ 
    "Цей метод буде викликатись після кожного тесту"
    myClub := nil.
]
