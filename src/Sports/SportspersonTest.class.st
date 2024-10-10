Class {
	#name : 'SportspersonTest',
	#superclass : 'TestCase',
	#category : 'Sports-Tests',
	#package : 'Sports',
	#tag : 'Tests'
}

{ #category : 'tests' }
SportspersonTest >> testEarningsComparison [
    | tennisPlayer footballPlayer |
    tennisPlayer := TennisPlayer new initializeWithLastName: 'Federer' age: 40 nationality: 'Switzerland' worldRanking: 5 earnings: #(10000 20000 15000).
    footballPlayer := FootballPlayer new initializeWithLastName: 'Messi' age: 35 nationality: 'Argentina' club: 'PSG' contract: 1000000 goals: 30.

    self assert: (tennisPlayer earningsLessThan: footballPlayer) = true.
]

{ #category : 'tests' }
SportspersonTest >> testFootballPlayerEarnings [
    | player |
    player := FootballPlayer new initializeWithLastName: 'Messi' age: 35 nationality: 'Argentina' club: 'PSG' contract: 1000000 goals: 30.
    self assert: player totalEarnings = 1300000.  "1% за кожен гол"
]

{ #category : 'tests' }
SportspersonTest >> testSportspersonDisplayInformation [
    | person displayString |
    person := Sportsperson new initializeWithLastName: 'Shevchenko' age: 30 nationality: 'Ukraine'.
    displayString := person displayInformation.
    
    self assert: (displayString includesSubstring: 'Last Name: Shevchenko').
    self assert: (displayString includesSubstring: 'Age: 30').
    self assert: (displayString includesSubstring: 'Nationality: Ukraine').
]

{ #category : 'tests' }
SportspersonTest >> testSportspersonInitialization [
    | person |
    person := Sportsperson new initializeWithLastName: 'Shevchenko' age: 30 nationality: 'Ukraine'.
    self assert: person lastName = 'Shevchenko'.
    self assert: person age = 30.
    self assert: person nationality = 'Ukraine'.
]

{ #category : 'tests' }
SportspersonTest >> testTennisPlayerEarnings [
    | player |
    player := TennisPlayer new initializeWithLastName: 'Federer' age: 40 nationality: 'Switzerland' worldRanking: 5 earnings: #(10000 20000 15000).
    self assert: player totalEarnings = 45000.
]
